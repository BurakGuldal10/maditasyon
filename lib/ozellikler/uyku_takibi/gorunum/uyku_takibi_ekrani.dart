import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../cekirdek/sabitler/renkler.dart';
import '../../../veri/modeller/uyku_modeli.dart';
import 'uyku_sesleri_ekrani.dart';
import 'uyku_hikaye_ekrani.dart';

class UykuTakibiEkrani extends StatefulWidget {
  const UykuTakibiEkrani({super.key});

  @override
  State<UykuTakibiEkrani> createState() => _UykuTakibiEkraniState();
}

class _UykuTakibiEkraniState extends State<UykuTakibiEkrani>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Kayıt sekmesi değişkenleri
  int _yatisSaat = 23;
  int _yatisDakika = 0;
  int _uyanmaSaat = 7;
  int _uyanmaDakika = 0;
  int _kalitePuani = 0;
  final TextEditingController _notController = TextEditingController();

  // Geçmiş kayıtları (bellekte tutulan demo veriler)
  final List<UykuKaydi> _uykuKayitlari = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _ornekVeriEkle();
  }

  void _ornekVeriEkle() {
    final simdi = DateTime.now();
    _uykuKayitlari.addAll([
      UykuKaydi(
        tarih: simdi.subtract(const Duration(days: 1)),
        yatisSaati: "23:15",
        uyanmaSaati: "06:45",
        uykuSuresi: const Duration(hours: 7, minutes: 30),
        kalitePuani: 4,
      ),
      UykuKaydi(
        tarih: simdi.subtract(const Duration(days: 2)),
        yatisSaati: "00:30",
        uyanmaSaati: "08:00",
        uykuSuresi: const Duration(hours: 7, minutes: 30),
        kalitePuani: 3,
      ),
      UykuKaydi(
        tarih: simdi.subtract(const Duration(days: 3)),
        yatisSaati: "22:45",
        uyanmaSaati: "06:30",
        uykuSuresi: const Duration(hours: 7, minutes: 45),
        kalitePuani: 5,
      ),
      UykuKaydi(
        tarih: simdi.subtract(const Duration(days: 4)),
        yatisSaati: "01:00",
        uyanmaSaati: "07:15",
        uykuSuresi: const Duration(hours: 6, minutes: 15),
        kalitePuani: 2,
      ),
    ]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _notController.dispose();
    super.dispose();
  }

  /// İki saat arasındaki süreyi hesaplar (gece yarısını aşan durumu da kapsar)
  Duration _sureyiHesapla() {
    int yatisDk = _yatisSaat * 60 + _yatisDakika;
    int uyanmaDk = _uyanmaSaat * 60 + _uyanmaDakika;

    if (uyanmaDk <= yatisDk) {
      uyanmaDk += 24 * 60;
    }

    return Duration(minutes: uyanmaDk - yatisDk);
  }

  void _saatSec(bool yatisIcin) {
    int geciciSaat = yatisIcin ? _yatisSaat : _uyanmaSaat;
    int geciciDakika = yatisIcin ? _yatisDakika : _uyanmaDakika;

    final saatController = FixedExtentScrollController(initialItem: geciciSaat);
    final dakikaController = FixedExtentScrollController(
      initialItem: geciciDakika,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 320,
          decoration: const BoxDecoration(
            color: UygulamaRenkleri.geceMavisi,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              // Başlık satırı
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "İptal",
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    ),
                    Text(
                      yatisIcin ? "Yatış Zamanı" : "Uyanış Zamanı",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (yatisIcin) {
                            _yatisSaat = geciciSaat;
                            _yatisDakika = geciciDakika;
                          } else {
                            _uyanmaSaat = geciciSaat;
                            _uyanmaDakika = geciciDakika;
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Tamam",
                        style: TextStyle(
                          color: UygulamaRenkleri.uykuAcikMor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white12, height: 1),
              // Saat ve Dakika tekerlekleri
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Saat tekerleği (0-23)
                    SizedBox(
                      width: 80,
                      child: CupertinoPicker(
                        scrollController: saatController,
                        itemExtent: 50,
                        selectionOverlay: Container(
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                color: UygulamaRenkleri.uykuMoru.withOpacity(
                                  0.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onSelectedItemChanged: (index) {
                          geciciSaat = index;
                        },
                        children: List.generate(24, (i) {
                          return Center(
                            child: Text(
                              i.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const Text(
                      ":",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Dakika tekerleği (0-59)
                    SizedBox(
                      width: 80,
                      child: CupertinoPicker(
                        scrollController: dakikaController,
                        itemExtent: 50,
                        selectionOverlay: Container(
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                color: UygulamaRenkleri.uykuMoru.withOpacity(
                                  0.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onSelectedItemChanged: (index) {
                          geciciDakika = index;
                        },
                        children: List.generate(60, (i) {
                          return Center(
                            child: Text(
                              i.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _kaydiKaydet() {
    if (_kalitePuani == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lütfen uyku kalitenizi puanlayın ⭐"),
          backgroundColor: UygulamaRenkleri.uykuMoru,
        ),
      );
      return;
    }

    final sure = _sureyiHesapla();
    final yeniKayit = UykuKaydi(
      tarih: DateTime.now(),
      yatisSaati:
          "${_yatisSaat.toString().padLeft(2, '0')}:${_yatisDakika.toString().padLeft(2, '0')}",
      uyanmaSaati:
          "${_uyanmaSaat.toString().padLeft(2, '0')}:${_uyanmaDakika.toString().padLeft(2, '0')}",
      uykuSuresi: sure,
      kalitePuani: _kalitePuani,
      not: _notController.text.isNotEmpty ? _notController.text : null,
    );

    setState(() {
      _uykuKayitlari.insert(0, yeniKayit);
      _kalitePuani = 0;
      _notController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Uyku kaydın başarıyla eklendi 🌙"),
        backgroundColor: UygulamaRenkleri.uykuMoru,
      ),
    );
  }

  // ─────────── İstatistik Hesaplamaları ───────────

  String get _ortalamaUykuSuresi {
    if (_uykuKayitlari.isEmpty) return "—";
    final toplamDakika = _uykuKayitlari.fold<int>(
      0,
      (toplam, kayit) => toplam + kayit.uykuSuresi.inMinutes,
    );
    final ortalama = toplamDakika ~/ _uykuKayitlari.length;
    return "${ortalama ~/ 60} sa ${ortalama % 60} dk";
  }

  String get _enIyiGece {
    if (_uykuKayitlari.isEmpty) return "—";
    final enIyi = _uykuKayitlari.reduce(
      (a, b) => a.kalitePuani >= b.kalitePuani ? a : b,
    );
    return enIyi.sureBilgisi;
  }

  double get _ortalamaKalite {
    if (_uykuKayitlari.isEmpty) return 0;
    return _uykuKayitlari.fold<int>(
          0,
          (toplam, kayit) => toplam + kayit.kalitePuani,
        ) /
        _uykuKayitlari.length;
  }

  // ─────────── BUILD ───────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UygulamaRenkleri.geceMavisi,
      appBar: AppBar(
        title: const Text(
          "Uyku Takibi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.music_note_rounded, color: Colors.white70),
            tooltip: "Uyku Sesleri",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UykuSesleriEkrani(),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: UygulamaRenkleri.uykuMoru,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          tabs: const [
            Tab(icon: Icon(Icons.add_circle_outline), text: "Kayıt"),
            Tab(icon: Icon(Icons.history_rounded), text: "Geçmiş"),
            Tab(icon: Icon(Icons.menu_book_rounded), text: "Hikayeler"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_kayitSekmesi(), _gecmisSekmesi(), const UykuHikayeleriSekmesi()],
      ),
    );
  }

  // ─────────── KAYIT SEKMESİ ───────────

  Widget _kayitSekmesi() {
    final sure = _sureyiHesapla();
    final saatStr = "${sure.inHours} sa ${sure.inMinutes % 60} dk";

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Ay ikonu ve uyku süresi gösterimi
          const SizedBox(height: 10),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  UygulamaRenkleri.uykuMoru.withOpacity(0.3),
                  UygulamaRenkleri.uykuAcikMor.withOpacity(0.1),
                ],
              ),
            ),
            child: const Icon(
              Icons.dark_mode_rounded,
              size: 50,
              color: UygulamaRenkleri.yildizSarisi,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            saatStr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Tahmini uyku süresi",
            style: TextStyle(color: Colors.white38, fontSize: 14),
          ),
          const SizedBox(height: 30),

          // Yatış ve Uyanış saat kartları
          Row(
            children: [
              Expanded(
                child: _saatSeciciKarti(
                  "Yatış Zamanı",
                  Icons.bedtime_rounded,
                  _yatisSaat,
                  _yatisDakika,
                  () => _saatSec(true),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _saatSeciciKarti(
                  "Uyanış Zamanı",
                  Icons.wb_sunny_rounded,
                  _uyanmaSaat,
                  _uyanmaDakika,
                  () => _saatSec(false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Kalite Puanlama
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Column(
              children: [
                const Text(
                  "Uyku Kalitesi",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () => setState(() => _kalitePuani = index + 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: AnimatedScale(
                          scale: _kalitePuani > index ? 1.2 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            _kalitePuani > index
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: _kalitePuani > index
                                ? UygulamaRenkleri.yildizSarisi
                                : Colors.white24,
                            size: 40,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                if (_kalitePuani > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    _kalitePuaniMetni(_kalitePuani),
                    style: TextStyle(
                      color: UygulamaRenkleri.yildizSarisi.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Not alanı
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: TextField(
              controller: _notController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Rüyanı veya notlarını yaz... (isteğe bağlı)",
                hintStyle: TextStyle(color: Colors.white24),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.edit_note, color: Colors.white24),
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Kaydet butonu
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _kaydiKaydet,
              style: ElevatedButton.styleFrom(
                backgroundColor: UygulamaRenkleri.uykuMoru,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 8,
                shadowColor: UygulamaRenkleri.uykuMoru.withOpacity(0.4),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save_rounded),
                  SizedBox(width: 10),
                  Text(
                    "Uyku Kaydını Kaydet",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _saatSeciciKarti(
    String baslik,
    IconData ikon,
    int saat,
    int dakika,
    VoidCallback onTap,
  ) {
    final saatStr =
        "${saat.toString().padLeft(2, '0')}:${dakika.toString().padLeft(2, '0')}";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          children: [
            Icon(ikon, color: UygulamaRenkleri.uykuAcikMor, size: 28),
            const SizedBox(height: 10),
            Text(
              baslik,
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
            const SizedBox(height: 5),
            Text(
              saatStr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Değiştirmek için dokun",
              style: TextStyle(
                color: UygulamaRenkleri.uykuAcikMor.withOpacity(0.5),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _kalitePuaniMetni(int puan) {
    switch (puan) {
      case 1:
        return "Çok Kötü 😞";
      case 2:
        return "Kötü 😕";
      case 3:
        return "Normal 😐";
      case 4:
        return "İyi 😊";
      case 5:
        return "Mükemmel 🤩";
      default:
        return "";
    }
  }

  // ─────────── GEÇMİŞ SEKMESİ ───────────

  Widget _gecmisSekmesi() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // İstatistik kartları
          Row(
            children: [
              Expanded(
                child: _istatistikKarti(
                  "Ort. Süre",
                  _ortalamaUykuSuresi,
                  Icons.access_time_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _istatistikKarti(
                  "En İyi Gece",
                  _enIyiGece,
                  Icons.emoji_events_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _istatistikKarti(
                  "Ort. Kalite",
                  _ortalamaKalite.toStringAsFixed(1),
                  Icons.star_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          const Text(
            "Son Kayıtlar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          if (_uykuKayitlari.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Icon(
                      Icons.nights_stay_rounded,
                      size: 60,
                      color: Colors.white.withOpacity(0.15),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Henüz kayıt yok",
                      style: TextStyle(color: Colors.white38, fontSize: 16),
                    ),
                    const Text(
                      "İlk uyku kaydını eklemek için\nKayıt sekmesine git",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white24, fontSize: 13),
                    ),
                  ],
                ),
              ),
            )
          else
            ...List.generate(_uykuKayitlari.length, (index) {
              return _gecmisKayitKarti(_uykuKayitlari[index]);
            }),
        ],
      ),
    );
  }

  Widget _istatistikKarti(String baslik, String deger, IconData ikon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            UygulamaRenkleri.uykuMoru.withOpacity(0.2),
            UygulamaRenkleri.uykuAcikMor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: UygulamaRenkleri.uykuMoru.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(ikon, color: UygulamaRenkleri.uykuAcikMor, size: 24),
          const SizedBox(height: 8),
          Text(
            deger,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            baslik,
            style: const TextStyle(color: Colors.white38, fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _gecmisKayitKarti(UykuKaydi kayit) {
    final gunler = [
      "Pazartesi",
      "Salı",
      "Çarşamba",
      "Perşembe",
      "Cuma",
      "Cumartesi",
      "Pazar",
    ];
    final gunAdi = gunler[kayit.tarih.weekday - 1];
    final tarihStr =
        "${kayit.tarih.day.toString().padLeft(2, '0')}.${kayit.tarih.month.toString().padLeft(2, '0')}";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$gunAdi • $tarihStr",
                style: const TextStyle(color: Colors.white54, fontSize: 13),
              ),
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < kayit.kalitePuani
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: i < kayit.kalitePuani
                        ? UygulamaRenkleri.yildizSarisi
                        : Colors.white12,
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.bedtime_rounded,
                    color: UygulamaRenkleri.uykuAcikMor,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    kayit.yatisSaati,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(width: 15),
                  const Icon(
                    Icons.wb_sunny_rounded,
                    color: UygulamaRenkleri.yildizSarisi,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    kayit.uyanmaSaati,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: UygulamaRenkleri.uykuMoru.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  kayit.sureBilgisi,
                  style: const TextStyle(
                    color: UygulamaRenkleri.uykuAcikMor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (kayit.not != null && kayit.not!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.note_rounded, color: Colors.white24, size: 14),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    kayit.not!,
                    style: const TextStyle(color: Colors.white38, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
