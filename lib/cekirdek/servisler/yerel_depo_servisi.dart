import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../veri/modeller/gunluk_modeli.dart';
import '../../veri/modeller/uyku_modeli.dart';

class YerelDepoServisi {
  static final YerelDepoServisi _instance = YerelDepoServisi._internal();
  factory YerelDepoServisi() => _instance;
  YerelDepoServisi._internal();

  Future<File> _dosya(String ad) async {
    final dizin = await getApplicationDocumentsDirectory();
    return File('${dizin.path}/$ad');
  }

  // ── Günlük ──────────────────────────────────────────────────

  Future<List<GunlukKaydi>> gunlukKayitlariniGetir() async {
    try {
      final dosya = await _dosya('gunluk_kayitlari.json');
      if (!await dosya.exists()) return [];
      final liste = jsonDecode(await dosya.readAsString()) as List;
      return liste.map((e) => GunlukKaydi.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> gunlukKaydiEkle(GunlukKaydi kayit) async {
    final kayitlar = await gunlukKayitlariniGetir();
    kayitlar.insert(0, kayit);
    final dosya = await _dosya('gunluk_kayitlari.json');
    await dosya.writeAsString(
      jsonEncode(kayitlar.map((e) => e.toJson()).toList()),
    );
  }

  // ── Uyku ────────────────────────────────────────────────────

  Future<List<UykuKaydi>> uykuKayitlariniGetir() async {
    try {
      final dosya = await _dosya('uyku_kayitlari.json');
      if (!await dosya.exists()) return [];
      final liste = jsonDecode(await dosya.readAsString()) as List;
      return liste.map((e) => UykuKaydi.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> uykuKaydiEkle(UykuKaydi kayit) async {
    final kayitlar = await uykuKayitlariniGetir();
    kayitlar.insert(0, kayit);
    final dosya = await _dosya('uyku_kayitlari.json');
    await dosya.writeAsString(
      jsonEncode(kayitlar.map((e) => e.toJson()).toList()),
    );
  }

}
