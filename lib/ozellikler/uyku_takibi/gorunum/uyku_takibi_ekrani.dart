import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../cekirdek/servisler/yerel_depo_servisi.dart';
import '../../../veri/modeller/uyku_modeli.dart';
import 'uyku_sesleri_ekrani.dart';
import 'uyku_hikaye_ekrani.dart';

class UykuTakibiEkrani extends StatefulWidget {
  const UykuTakibiEkrani({super.key});

  @override
  State<UykuTakibiEkrani> createState() => _UykuTakibiEkraniState();
}

class _UykuTakibiEkraniState extends State<UykuTakibiEkrani>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _glowCtrl;
  late Animation<double> _glowAnim;

  int _yatisSaat = 23;
  int _yatisDakika = 0;
  int _uyanmaSaat = 7;
  int _uyanmaDakika = 0;
  int _kalitePuani = 0;
  final TextEditingController _notController = TextEditingController();

  final YerelDepoServisi _depo = YerelDepoServisi();
  final List<UykuKaydi> _uykuKayitlari = [];

  static const _bg = Color(0xFF080818);
  static const _purpleGlow = Color(0xFF7C3AED);
  static const _indigoAccent = Color(0xFF818CF8);
  static const _moonYellow = Color(0xFFFCD34D);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );
    _kayitlariYukle();
  }

  Future<void> _kayitlariYukle() async {
    final kayitlar = await _depo.uykuKayitlariniGetir();
    if (mounted) setState(() => _uykuKayitlari.addAll(kayitlar));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _glowCtrl.dispose();
    _notController.dispose();
    super.dispose();
  }

  Duration _sureyiHesapla() {
    int yatisDk = _yatisSaat * 60 + _yatisDakika;
    int uyanmaDk = _uyanmaSaat * 60 + _uyanmaDakika;
    if (uyanmaDk <= yatisDk) uyanmaDk += 24 * 60;
    return Duration(minutes: uyanmaDk - yatisDk);
  }

  void _saatSec(bool yatisIcin) {
    int geciciSaat = yatisIcin ? _yatisSaat : _uyanmaSaat;
    int geciciDakika = yatisIcin ? _yatisDakika : _uyanmaDakika;

    final saatController = FixedExtentScrollController(initialItem: geciciSaat);
    final dakikaController = FixedExtentScrollController(initialItem: geciciDakika);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 320,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A0A3E), Color(0xFF0A1540)],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(color: _purpleGlow.withOpacity(0.25)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                      yatisIcin ? "🌙  Yatış Zamanı" : "☀️  Uyanış Zamanı",
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
                          color: _indigoAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.white.withOpacity(0.08), height: 1),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 90,
                      child: CupertinoPicker(
                        scrollController: saatController,
                        itemExtent: 52,
                        selectionOverlay: Container(
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                color: _purpleGlow.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        onSelectedItemChanged: (index) => geciciSaat = index,
                        children: List.generate(
                          24,
                          (i) => Center(
                            child: Text(
                              i.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      ":",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: CupertinoPicker(
                        scrollController: dakikaController,
                        itemExtent: 52,
                        selectionOverlay: Container(
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                color: _purpleGlow.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        onSelectedItemChanged: (index) => geciciDakika = index,
                        children: List.generate(
                          60,
                          (i) => Center(
                            child: Text(
                              i.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
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

  Future<void> _kaydiKaydet() async {
    if (_kalitePuani == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Lütfen uyku kalitenizi puanlayın ⭐"),
          backgroundColor: _purpleGlow,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

    await _depo.uykuKaydiEkle(yeniKayit);

    if (mounted) {
      setState(() {
        _uykuKayitlari.insert(0, yeniKayit);
        _kalitePuani = 0;
        _notController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Uyku kaydın başarıyla eklendi 🌙"),
          backgroundColor: _purpleGlow,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  // ─────────── İstatistik Hesaplamaları ───────────

  String get _ortalamaUykuSuresi {
    if (_uykuKayitlari.isEmpty) return "—";
    final toplamDakika =
        _uykuKayitlari.fold<int>(0, (t, k) => t + k.uykuSuresi.inMinutes);
    final ort = toplamDakika ~/ _uykuKayitlari.length;
    return "${ort ~/ 60}s ${ort % 60}dk";
  }

  String get _enIyiGece {
    if (_uykuKayitlari.isEmpty) return "—";
    return _uykuKayitlari
        .reduce((a, b) => a.kalitePuani >= b.kalitePuani ? a : b)
        .sureBilgisi;
  }

  double get _ortalamaKalite {
    if (_uykuKayitlari.isEmpty) return 0;
    return _uykuKayitlari.fold<int>(0, (t, k) => t + k.kalitePuani) /
        _uykuKayitlari.length;
  }

  // ─────────── BUILD ───────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A0533),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A0533),
                Color(0xFF0D1B4B),
                Color(0xFF080818),
              ],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
          child: Stack(
            children: [
              Positioned(top: 22, right: 80, child: _yildiz(3.5, 0.7)),
              Positioned(top: 48, right: 160, child: _yildiz(2.5, 0.45)),
              Positioned(top: 35, left: 100, child: _yildiz(2.0, 0.55)),
              Positioned(top: 55, left: 50, child: _yildiz(4.0, 0.35)),
              Positioned(top: 18, left: 200, child: _yildiz(3.0, 0.6)),
            ],
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Uyku Takibi",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Kaliteli uyku, sağlıklı zihin 🌙",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UykuSesleriEkrani()),
            ),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _purpleGlow.withOpacity(0.4),
                    _indigoAccent.withOpacity(0.25),
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _purpleGlow.withOpacity(0.3)),
              ),
              child: const Icon(
                Icons.music_note_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: const Color(0xFF1454A0),
            borderRadius: BorderRadius.circular(22),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
          tabs: const [
            Tab(icon: Icon(Icons.add_circle_outline, size: 18), text: "Kayıt"),
            Tab(icon: Icon(Icons.bar_chart_rounded, size: 18), text: "Geçmiş"),
            Tab(
                icon: Icon(Icons.menu_book_rounded, size: 18),
                text: "Hikayeler"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _kayitSekmesi(),
          _gecmisSekmesi(),
          const UykuHikayeleriSekmesi(),
        ],
      ),
    );
  }

  Widget _yildiz(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(opacity),
        shape: BoxShape.circle,
      ),
    );
  }

  // ─────────── KAYIT SEKMESİ ───────────

  Widget _kayitSekmesi() {
    final sure = _sureyiHesapla();
    final saatler = sure.inHours;
    final dakikalar = sure.inMinutes % 60;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 30),
      child: Column(
        children: [
          // Moon glow + duration
          AnimatedBuilder(
            animation: _glowAnim,
            builder: (_, __) => Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [Color(0xFF1454A0), Color(0xFF071428)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1454A0).withOpacity(_glowAnim.value * 0.7),
                    blurRadius: 45,
                    spreadRadius: 10,
                  ),
                  BoxShadow(
                    color: const Color(0xFF2F80ED).withOpacity(_glowAnim.value * 0.35),
                    blurRadius: 80,
                    spreadRadius: 22,
                  ),
                ],
              ),
              child: const Icon(
                Icons.dark_mode_rounded,
                size: 62,
                color: _moonYellow,
              ),
            ),
          ),
          const SizedBox(height: 22),

          // Duration display
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: saatler.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 54,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
                const TextSpan(
                  text: " sa  ",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: dakikalar.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 54,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
                const TextSpan(
                  text: " dk",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFF1A3A6B).withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF2A5298).withOpacity(0.5)),
            ),
            child: const Text(
              "Tahmini uyku süresi",
              style: TextStyle(color: Color(0xFF93C5FD), fontSize: 13),
            ),
          ),
          const SizedBox(height: 32),

          // Time selector cards
          Row(
            children: [
              Expanded(child: _yatisKarti()),
              const SizedBox(width: 14),
              Expanded(child: _uyanisKarti()),
            ],
          ),
          const SizedBox(height: 20),

          // Quality rating
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF071428),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: const Color(0xFF1A3A6B), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0A1628).withOpacity(0.5),
                  blurRadius: 22,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Uyku Kalitesi",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _kaliteEmoji(1, "😞", "Çok Kötü"),
                    _kaliteEmoji(2, "😕", "Kötü"),
                    _kaliteEmoji(3, "😐", "Normal"),
                    _kaliteEmoji(4, "😊", "İyi"),
                    _kaliteEmoji(5, "🤩", "Mükemmel"),
                  ],
                ),
                if (_kalitePuani > 0) ...[
                  const SizedBox(height: 16),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _kaliteRenk(_kalitePuani).withOpacity(0.3),
                          _kaliteRenk(_kalitePuani).withOpacity(0.12),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: _kaliteRenk(_kalitePuani).withOpacity(0.4),
                      ),
                    ),
                    child: Text(
                      _kalitePuaniMetni(_kalitePuani),
                      style: TextStyle(
                        color: _kaliteRenk(_kalitePuani),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Note field
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
              color: const Color(0xFF071428),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: const Color(0xFF1A3A6B), width: 1.2),
            ),
            child: TextField(
              controller: _notController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: "Rüyanı veya notlarını yaz... ✨",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.25)),
                border: InputBorder.none,
                icon: const Icon(
                  Icons.edit_note_rounded,
                  color: Color(0xFF6B8CC4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Save button
          GestureDetector(
            onTap: _kaydiKaydet,
            child: Container(
              width: double.infinity,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFF1454A0),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1454A0).withOpacity(0.45),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.nights_stay_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Uyku Kaydını Kaydet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _yatisKarti() {
    final saatStr =
        "${_yatisSaat.toString().padLeft(2, '0')}:${_yatisDakika.toString().padLeft(2, '0')}";
    return GestureDetector(
      onTap: () => _saatSec(true),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF071428),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: const Color(0xFF1A3A6B), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF071428).withOpacity(0.6),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFA0B4FF).withOpacity(0.12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFA0B4FF).withOpacity(0.2),
                    blurRadius: 14,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.bedtime_rounded,
                color: Color(0xFFA0B4FF),
                size: 26,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Yatış",
              style: TextStyle(color: Color(0xFF6B8CC4), fontSize: 13),
            ),
            const SizedBox(height: 6),
            Text(
              saatStr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1A3A6B).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Düzenle",
                style: TextStyle(color: Color(0xFF6B8CC4), fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _uyanisKarti() {
    final saatStr =
        "${_uyanmaSaat.toString().padLeft(2, '0')}:${_uyanmaDakika.toString().padLeft(2, '0')}";
    return GestureDetector(
      onTap: () => _saatSec(false),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF071428),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: const Color(0xFF1A3A6B), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF071428).withOpacity(0.6),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // Güneş ikonu — amber glow ile
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFBBF24).withOpacity(0.12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFBBF24).withOpacity(0.3),
                    blurRadius: 14,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.wb_sunny_rounded,
                color: Color(0xFFFBBF24),
                size: 26,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Uyanış",
              style: TextStyle(color: Color(0xFF6B8CC4), fontSize: 13),
            ),
            const SizedBox(height: 6),
            Text(
              saatStr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1A3A6B).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Düzenle",
                style: TextStyle(color: Color(0xFF6B8CC4), fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kaliteEmoji(int puan, String emoji, String label) {
    final secili = _kalitePuani == puan;
    return GestureDetector(
      onTap: () => setState(() => _kalitePuani = puan),
      child: AnimatedScale(
        scale: secili ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: secili
                    ? _kaliteRenk(puan).withOpacity(0.28)
                    : Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
                border: secili
                    ? Border.all(
                        color: _kaliteRenk(puan).withOpacity(0.65),
                        width: 2,
                      )
                    : null,
              ),
              child: Text(emoji, style: const TextStyle(fontSize: 26)),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: secili ? _kaliteRenk(puan) : Colors.white30,
                fontSize: 10,
                fontWeight: secili ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _kaliteRenk(int puan) {
    switch (puan) {
      case 1:
        return const Color(0xFFEF4444);
      case 2:
        return const Color(0xFFF97316);
      case 3:
        return const Color(0xFFFBBF24);
      case 4:
        return const Color(0xFF34D399);
      case 5:
        return const Color(0xFF818CF8);
      default:
        return Colors.white;
    }
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
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stat cards
          Row(
            children: [
              Expanded(
                child: _istatistikKarti(
                  "Ort. Süre",
                  _ortalamaUykuSuresi,
                  Icons.access_time_rounded,
                  const [Color(0xFF6A82FB), Color(0xFF9B59B6)],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _istatistikKarti(
                  "En İyi Gece",
                  _enIyiGece,
                  Icons.emoji_events_rounded,
                  const [Color(0xFFF7971E), Color(0xFFFFD200)],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _istatistikKarti(
                  "Ort. Kalite",
                  _ortalamaKalite.toStringAsFixed(1),
                  Icons.star_rounded,
                  const [Color(0xFF11998E), Color(0xFF38EF7D)],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Section header
          Row(
            children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [_purpleGlow, _indigoAccent],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Son Kayıtlar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                "${_uykuKayitlari.length} kayıt",
                style: const TextStyle(color: Colors.white38, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (_uykuKayitlari.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _purpleGlow.withOpacity(0.1),
                        border: Border.all(color: _purpleGlow.withOpacity(0.2)),
                      ),
                      child: const Icon(
                        Icons.nights_stay_rounded,
                        size: 40,
                        color: Colors.white24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Henüz kayıt yok",
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
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
            ...List.generate(
              _uykuKayitlari.length,
              (i) => _gecmisKayitKarti(_uykuKayitlari[i]),
            ),
        ],
      ),
    );
  }

  Widget _istatistikKarti(
    String baslik,
    String deger,
    IconData ikon,
    List<Color> gradient,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withOpacity(0.38),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(ikon, color: Colors.white.withOpacity(0.9), size: 22),
          const SizedBox(height: 8),
          Text(
            deger,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            baslik,
            style: TextStyle(
              color: Colors.white.withOpacity(0.72),
              fontSize: 10,
            ),
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
    final borderColor = _kaliteRenk(kayit.kalitePuani);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF13103A), Color(0xFF0D0F2A)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Colored quality bar
              Container(
                width: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [borderColor, borderColor.withOpacity(0.3)],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$gunAdi • $tarihStr",
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < kayit.kalitePuani
                                    ? Icons.star_rounded
                                    : Icons.star_outline_rounded,
                                color: i < kayit.kalitePuani
                                    ? _moonYellow
                                    : Colors.white12,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _zamanCip(
                            Icons.bedtime_rounded,
                            kayit.yatisSaati,
                            const Color(0xFF818CF8),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white.withOpacity(0.2),
                            size: 14,
                          ),
                          const SizedBox(width: 8),
                          _zamanCip(
                            Icons.wb_sunny_rounded,
                            kayit.uyanmaSaati,
                            const Color(0xFFFCD34D),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  _purpleGlow.withOpacity(0.35),
                                  _indigoAccent.withOpacity(0.35),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              kayit.sureBilgisi,
                              style: const TextStyle(
                                color: _indigoAccent,
                                fontSize: 12,
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
                            Icon(
                              Icons.auto_stories_rounded,
                              color: Colors.white.withOpacity(0.3),
                              size: 13,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                kayit.not!,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.4),
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _zamanCip(IconData ikon, String saat, Color renk) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(ikon, color: renk, size: 14),
        const SizedBox(width: 4),
        Text(
          saat,
          style: TextStyle(
            color: renk,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
