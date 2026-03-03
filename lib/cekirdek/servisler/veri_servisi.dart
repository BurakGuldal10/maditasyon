import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../veri/modeller/ses_modeli.dart';

class VeriServisi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  static const String _koleksiyon = 'sesler';
  static const String _storageKok = 'sesler';

  // ── Tüm sesleri getir ───────────────────────────────────────────────────────
  Future<List<SesModeli>> sesleriGetir({bool kullaniciPremiumMu = false}) async {
    final firestoreSonuc = await _firestoreSesleriGetir(kullaniciPremiumMu: kullaniciPremiumMu);
    if (firestoreSonuc.isNotEmpty) return firestoreSonuc;
    // Firestore boşsa Storage'dan yükle
    return _storagedenSesleriGetir();
  }

  // ── Kategoriye göre getir — Firestore yoksa Storage fallback ────────────────
  Future<List<SesModeli>> kategoriyeGoreGetir(
    String kategori, {
    bool kullaniciPremiumMu = false,
  }) async {
    final firestoreSonuc = await _firestoreKategoriyeGoreGetir(
      kategori,
      kullaniciPremiumMu: kullaniciPremiumMu,
    );
    if (firestoreSonuc.isNotEmpty) return firestoreSonuc;
    // Firestore boşsa o klasörü Storage'dan tara
    return _storageKlasorundenGetir(kategori);
  }

  // ── Tüm ses kategorilerini tek seferde getir ────────────────────────────────
  Future<List<SesModeli>> tumKategorileriGetir({bool kullaniciPremiumMu = false}) async {
    final firestoreSonuc = await _firestoreSesleriGetir(kullaniciPremiumMu: kullaniciPremiumMu);
    if (firestoreSonuc.isNotEmpty) return firestoreSonuc;
    return _storagedenSesleriGetir();
  }

  // ── Storage'daki TÜM klasörleri tara, Firestore'a kaydet (tek seferlik) ─────
  Future<int> storagedenOtomatikKaydet() async {
    int kaydedilenSayisi = 0;
    try {
      final kok = await _storage.ref(_storageKok).listAll();

      // Önce kök seviyedeki dosyalar
      for (final dosya in kok.items) {
        final kaydedildi = await _dosyayiKaydet(dosya, 'genel');
        if (kaydedildi) kaydedilenSayisi++;
      }

      // Sonra alt klasörler (sesler/uyku/, sesler/doga/, vb.)
      for (final klasor in kok.prefixes) {
        final klasorAdi = klasor.name;
        final icerik = await klasor.listAll();
        for (final dosya in icerik.items) {
          final kaydedildi = await _dosyayiKaydet(dosya, klasorAdi);
          if (kaydedildi) kaydedilenSayisi++;
        }
      }
    } catch (e) {
      // ignore
    }
    return kaydedilenSayisi;
  }

  // ── Ruh haline göre ─────────────────────────────────────────────────────────
  Future<List<SesModeli>> ruhHalineGoreGetir(
    String ruhHali, {
    bool kullaniciPremiumMu = false,
  }) async {
    try {
      Query sorgu = _firestore
          .collection(_koleksiyon)
          .where('ruhHali', isEqualTo: ruhHali)
          .orderBy('sira');
      if (!kullaniciPremiumMu) {
        sorgu = sorgu.where('premium', isEqualTo: false);
      }
      final snapshot = await sorgu.get();
      return snapshot.docs
          .map((doc) => SesModeli.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (_) {
      return [];
    }
  }

  // ── Download URL al ─────────────────────────────────────────────────────────
  Future<String?> downloadUrlAl(String kategori, String dosyaAdi) async {
    try {
      return await _storage.ref('$_storageKok/$kategori/$dosyaAdi').getDownloadURL();
    } catch (_) {
      return null;
    }
  }

  // ── Manuel ses kaydetme ─────────────────────────────────────────────────────
  Future<void> sesYukle({
    required String kategori,
    required String dosyaAdi,
    required String baslik,
    required String sanatci,
    required String sure,
    required String ruhHali,
    String kapakResmi = '',
    bool premium = false,
    int sira = 0,
  }) async {
    final url = await downloadUrlAl(kategori, dosyaAdi);
    if (url == null) return;
    await _firestore.collection(_koleksiyon).add({
      'baslik': baslik,
      'sanatci': sanatci,
      'url': url,
      'kapakResmi': kapakResmi,
      'sure': sure,
      'ruhHali': ruhHali,
      'kategori': kategori,
      'premium': premium,
      'sira': sira,
    });
  }

  // ── Geliştirme: örnek veriler ───────────────────────────────────────────────
  Future<void> ornekVerileriYukle() async {
    final ornekler = [
      {'baslik': 'Orman Kuşları', 'sanatci': 'Doğa Terapisi', 'url': '', 'kapakResmi': '', 'sure': '45:00', 'ruhHali': 'orman', 'kategori': 'doga', 'premium': false, 'sira': 1},
      {'baslik': 'Yağmur Sesi',   'sanatci': 'Doğa Terapisi', 'url': '', 'kapakResmi': '', 'sure': '30:00', 'ruhHali': 'yagmur', 'kategori': 'doga', 'premium': false, 'sira': 2},
      {'baslik': 'Derin Odaklanma', 'sanatci': 'Zihin Serisi', 'url': '', 'kapakResmi': '', 'sure': '10:00', 'ruhHali': 'Odaklanmış', 'kategori': 'meditasyon', 'premium': false, 'sira': 1},
    ];
    for (final veri in ornekler) {
      await _firestore.collection(_koleksiyon).add(veri);
    }
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ── Özel (private) yardımcı metodlar ───────────────────────────────────────
  // ════════════════════════════════════════════════════════════════════════════

  Future<List<SesModeli>> _firestoreSesleriGetir({bool kullaniciPremiumMu = false}) async {
    try {
      Query sorgu = _firestore.collection(_koleksiyon).orderBy('sira');
      if (!kullaniciPremiumMu) {
        sorgu = sorgu.where('premium', isEqualTo: false);
      }
      final snapshot = await sorgu.get();
      return snapshot.docs
          .map((doc) => SesModeli.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<SesModeli>> _firestoreKategoriyeGoreGetir(
    String kategori, {
    bool kullaniciPremiumMu = false,
  }) async {
    try {
      Query sorgu = _firestore
          .collection(_koleksiyon)
          .where('kategori', isEqualTo: kategori)
          .orderBy('sira');
      if (!kullaniciPremiumMu) {
        sorgu = sorgu.where('premium', isEqualTo: false);
      }
      final snapshot = await sorgu.get();
      return snapshot.docs
          .map((doc) => SesModeli.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (_) {
      return [];
    }
  }

  // Storage'daki TÜM klasörleri ve kök dosyaları listeler
  Future<List<SesModeli>> _storagedenSesleriGetir() async {
    final tumu = <SesModeli>[];
    try {
      final kok = await _storage.ref(_storageKok).listAll();
      for (final dosya in kok.items) {
        final model = await _referanstenModel(dosya, 'genel');
        if (model != null) tumu.add(model);
      }
      for (final klasor in kok.prefixes) {
        final liste = await _storageKlasorundenGetir(klasor.name);
        tumu.addAll(liste);
      }
    } catch (_) {}
    return tumu;
  }

  // Tek bir Storage klasörünü tara
  Future<List<SesModeli>> _storageKlasorundenGetir(String klasorAdi) async {
    final sonuc = <SesModeli>[];
    try {
      final icerik = await _storage.ref('$_storageKok/$klasorAdi').listAll();
      for (final ref in icerik.items) {
        final model = await _referanstenModel(ref, klasorAdi);
        if (model != null) sonuc.add(model);
      }
    } catch (_) {}
    return sonuc;
  }

  // Storage dosya referansından SesModeli oluştur
  Future<SesModeli?> _referanstenModel(Reference ref, String kategori) async {
    try {
      final url = await ref.getDownloadURL();
      final baslik = _dosyaAdiniDuzenle(ref.name);
      return SesModeli(
        id: ref.fullPath,
        baslik: baslik,
        sanatci: 'Doğa Terapisi',
        url: url,
        kapakResmi: '',
        sure: '',
        ruhHali: kategori,
        kategori: kategori,
        premium: false,
        sira: 0,
      );
    } catch (_) {
      return null;
    }
  }

  // Tek bir dosyayı Firestore'a kaydet (zaten varsa atla)
  Future<bool> _dosyayiKaydet(Reference ref, String kategori) async {
    try {
      // Aynı fullPath ile kayıt var mı kontrol et
      final var_ = await _firestore
          .collection(_koleksiyon)
          .where('storageYolu', isEqualTo: ref.fullPath)
          .limit(1)
          .get();
      if (var_.docs.isNotEmpty) return false; // zaten kayıtlı

      final url = await ref.getDownloadURL();
      final baslik = _dosyaAdiniDuzenle(ref.name);

      await _firestore.collection(_koleksiyon).add({
        'baslik': baslik,
        'sanatci': 'Doğa Terapisi',
        'url': url,
        'kapakResmi': '',
        'sure': '',
        'ruhHali': kategori,
        'kategori': kategori,
        'premium': false,
        'sira': 0,
        'storageYolu': ref.fullPath, // tekrar kaydetmeyi önler
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  // "orman_kuslari.mp3" → "Orman Kuslari"
  String _dosyaAdiniDuzenle(String dosyaAdi) {
    return dosyaAdi
        .replaceAll(RegExp(r'\.\w+$'), '')  // uzantıyı kaldır
        .replaceAll('_', ' ')
        .replaceAll('-', ' ')
        .split(' ')
        .map((k) => k.isEmpty ? '' : '${k[0].toUpperCase()}${k.substring(1)}')
        .join(' ');
  }
}
