import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../nefes_egzersizi/gorunum/nefes_egzersizi_ekrani.dart';
import '../../su_takibi/gorunum/su_takibi_ekrani.dart';
import '../../uyku_takibi/gorunum/uyku_takibi_ekrani.dart';
import '../../odaklanma/gorunum/odaklanma_ekrani.dart';
import '../../gunluk/gorunum/gunluk_ekrani.dart';
import '../../dinlendirici_metinler/gorunum/dinlendirici_metinler_ekrani.dart';
import '../../dinlendirici_metinler/gorunum/metin_okuyucu_ekrani.dart';

class AnaSayfaEkrani extends StatefulWidget {
  const AnaSayfaEkrani({super.key});

  @override
  State<AnaSayfaEkrani> createState() => _AnaSayfaEkraniState();
}

class _AnaSayfaEkraniState extends State<AnaSayfaEkrani> {
  static final List<DinlendiriciMetin> _onerilens = [
    dinlendiriciMetinler.firstWhere((m) => m.id == 'm3'),
    dinlendiriciMetinler.firstWhere((m) => m.id == 'm4'),
    dinlendiriciMetinler.firstWhere((m) => m.id == 'm6'),
  ];

  static const List<Map<String, dynamic>> _kategoriler = [
    {'ad': 'Uyku',   'alt': 'Takip & Sesler', 'ikon': Icons.bedtime_rounded,            'renk': Color(0xFF7C3AED)},
    {'ad': 'Odak',   'alt': 'Konsantrasyon',  'ikon': Icons.center_focus_strong_rounded, 'renk': Color(0xFFDC2626)},
    {'ad': 'Nefes',  'alt': 'Egzersiz',       'ikon': Icons.air_rounded,                 'renk': Color(0xFF0891B2)},
    {'ad': 'Su',     'alt': 'Günlük takip',   'ikon': Icons.water_drop_rounded,           'renk': Color(0xFF0284C7)},
    {'ad': 'Günlük', 'alt': 'Zihin notları',  'ikon': Icons.edit_note_rounded,            'renk': Color(0xFF16A34A)},
  ];

  // Saate göre değişen arka plan ve içerik
  String get _arkaplanUrl {
    final h = DateTime.now().hour;
    if (h < 7) {
      // Gece: Yıldızlı gökyüzü / sakin orman
      return 'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?q=80&w=900&auto=format&fit=crop';
    } else if (h < 13) {
      // Sabah: Sisli orman yolu
      return 'https://images.unsplash.com/photo-1448375240586-882707db888b?q=80&w=900&auto=format&fit=crop';
    } else if (h < 18) {
      // Öğleden sonra: Yeşil orman
      return 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=900&auto=format&fit=crop';
    } else {
      // Akşam: Sakin deniz/okyanus
      return 'https://images.unsplash.com/photo-1505118380757-91f5f5632de0?q=80&w=900&auto=format&fit=crop';
    }
  }

  // Overlay gradient koyuluğu (okunabilirlik için)
  List<Color> get _overlayRenkler {
    final h = DateTime.now().hour;
    if (h < 7) {
      return [Colors.black.withValues(alpha: 0.5), Colors.black.withValues(alpha: 0.75)];
    }
    return [Colors.black.withValues(alpha: 0.25), Colors.black.withValues(alpha: 0.70)];
  }

  String get _selamlama {
    final h = DateTime.now().hour;
    if (h < 7)  return 'Umarım iyi uyudun 🌙';
    if (h < 12) return 'Günaydın ☀️';
    if (h < 18) return 'İyi günler 🌿';
    return 'İyi akşamlar 🌊';
  }

  String get _heroBaslik {
    final h = DateTime.now().hour;
    if (h < 7)  return 'Gece\nMeditasyonu';
    if (h < 12) return 'Sabah\nMeditasyonu';
    if (h < 18) return '10 Dakika\nOdaklanma';
    return 'Gece\nRahatlaması';
  }

  String get _heroAlt {
    final h = DateTime.now().hour;
    if (h < 7)  return 'Derin ve huzurlu bir uyku için';
    if (h < 12) return 'Güne pozitif bir enerjiyle başla';
    if (h < 18) return 'Konsantrasyon · Zihin açma';
    return 'Günü bırak · Gevşe · Uyu';
  }

  void _kategoriGit(String ad) {
    final Map<String, Widget> hedefler = {
      'Uyku':   const UykuTakibiEkrani(),
      'Odak':   const OdaklanmaEkrani(),
      'Nefes':  const NefesEgzersiziEkrani(),
      'Su':     const SuTakibiEkrani(),
      'Günlük': const GunlukEkrani(),
    };
    final ekran = hedefler[ad];
    if (ekran != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ekran));
    }
  }

  // ── Cam efekti (glassmorphism) ─────────────────────────────
  Widget _cam({
    required Widget child,
    double radius = 22,
    Color tint = Colors.white,
    double opaklik = 0.13,
    double bulaniklik = 14,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: bulaniklik, sigmaY: bulaniklik),
        child: Container(
          decoration: BoxDecoration(
            color: tint.withValues(alpha: opaklik),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: Colors.white.withValues(alpha: 0.22), width: 1),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double cellW = (w - 48 - 24) / 3;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A1A0A),
        body: Stack(
          children: [
            // ── Arka plan fotoğrafı ─────────────────────────
            Positioned.fill(
              child: Image.network(
                _arkaplanUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF0D2B0D), Color(0xFF061806)],
                    ),
                  ),
                ),
              ),
            ),

            // ── Karartma katmanı ────────────────────────────
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _overlayRenkler[0],
                      Colors.black.withValues(alpha: 0.48),
                      _overlayRenkler[1],
                    ],
                    stops: const [0.0, 0.4, 1.0],
                  ),
                ),
              ),
            ),

            // ── İçerik ─────────────────────────────────────
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Selamlama + ruh hali bölümü
                    _headerBolumu(),

                    const SizedBox(height: 24),

                    // Hero kart
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _heroKart(),
                    ),

                    const SizedBox(height: 24),

                    // Dinlendirici Metinler banner
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _metinlerBanner(),
                    ),

                    const SizedBox(height: 30),

                    // Keşfet
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _bolumBasligi('Keşfet', 'Tüm özellikler'),
                          const SizedBox(height: 16),
                          _kategoriGrid(cellW),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Senin için
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _bolumBasligi('Senin için', 'Özenle seçildi'),
                    ),
                    const SizedBox(height: 16),
                    _onerilenYatay(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header bölümü ───────────────────────────────────────────
  Widget _headerBolumu() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Selamlama + isim
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selamlama,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Burak',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),

          // Streak badge
          _cam(
            radius: 20,
            tint: const Color(0xFFFF6B35),
            opaklik: 0.25,
            bulaniklik: 10,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🔥', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 5),
                  Text(
                    '5 gün seri',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
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

  // ── Hero kart (cam efekti) ──────────────────────────────────
  Widget _heroKart() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const OdaklanmaEkrani()),
      ),
      child: _cam(
        radius: 28,
        opaklik: 0.18,
        bulaniklik: 18,
        child: SizedBox(
          height: 205,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                  ),
                  child: const Text(
                    '✨  Günün Önerisi',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _heroBaslik,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              height: 1.15,
                              letterSpacing: -0.6,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _heroAlt,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.65),
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Play butonu
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Color(0xFF0A2A0A),
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Dinlendirici Metinler banner (cam + yeşil ton) ──────────
  Widget _metinlerBanner() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DinlendiriciMetinlerEkrani()),
      ),
      child: _cam(
        radius: 24,
        tint: const Color(0xFF10B981),
        opaklik: 0.22,
        bulaniklik: 16,
        child: Stack(
          children: [
            Positioned(
              right: -15,
              bottom: -15,
              child: Icon(
                Icons.auto_stories_rounded,
                size: 115,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.5)),
                    ),
                    child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dinlendirici Metinler',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '8 rehberli metin  ·  Uyku · Stres · Farkındalık',
                          style: TextStyle(color: Colors.white60, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Keşfet grid (cam + renkli ton) ─────────────────────────
  Widget _kategoriGrid(double cellW) {
    return Column(
      children: [
        Row(
          children: List.generate(3, (i) => Padding(
            padding: EdgeInsets.only(right: i < 2 ? 12 : 0),
            child: _gridHucre(_kategoriler[i], cellW),
          )),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _gridHucre(_kategoriler[3], cellW),
            const SizedBox(width: 12),
            _gridHucre(_kategoriler[4], cellW),
          ],
        ),
      ],
    );
  }

  Widget _gridHucre(Map<String, dynamic> kat, double cellW) {
    final renk = kat['renk'] as Color;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _kategoriGit(kat['ad'] as String);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            width: cellW,
            height: cellW * 1.12,
            decoration: BoxDecoration(
              color: renk.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: renk.withValues(alpha: 0.45), width: 1),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: Icon(
                    kat['ikon'] as IconData,
                    size: 68,
                    color: Colors.white.withValues(alpha: 0.07),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Icon(kat['ikon'] as IconData, color: Colors.white, size: 20),
                      ),
                      const Spacer(),
                      Text(
                        kat['ad'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        kat['alt'] as String,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.55),
                          fontSize: 9,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Yatay scroll önerilen kartlar ──────────────────────────
  Widget _onerilenYatay() {
    return SizedBox(
      height: 175,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _onerilens.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, i) {
          final metin = _onerilens[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MetinOkuyucuEkrani(metin: metin)),
            ),
            child: Container(
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: metin.renk,
                boxShadow: [
                  BoxShadow(
                    color: metin.renk.withValues(alpha: 0.45),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -14,
                    bottom: -14,
                    child: Icon(
                      metin.ikon,
                      size: 95,
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Icon(metin.ikon, color: Colors.white, size: 20),
                        ),
                        const Spacer(),
                        Text(
                          metin.baslik,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.schedule_rounded, color: Colors.white60, size: 12),
                            const SizedBox(width: 4),
                            Text(metin.sure, style: const TextStyle(color: Colors.white60, fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Bölüm başlığı ──────────────────────────────────────────
  Widget _bolumBasligi(String baslik, String alt) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                baslik,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                alt,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Text(
          'Tümü →',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}
