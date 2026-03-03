import 'dart:async';
import 'package:flutter/material.dart';

import '../../../cekirdek/servisler/ses_servisi.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────────────────────────────────────

class OynaticiParcasi {
  final String id;
  final String isim;
  final String altBaslik;
  final IconData ikon;
  final String? url; // null = yakında eklenecek
  final bool dongulu;
  final String sureEtiketi;

  const OynaticiParcasi({
    required this.id,
    required this.isim,
    required this.altBaslik,
    required this.ikon,
    this.url,
    this.dongulu = true,
    this.sureEtiketi = '∞',
  });
}

class SesKategorisi {
  final String id;
  final String isim;
  final String emoji;
  final List<Color> gradientRenkler;
  final Color aksanRengi;
  final List<OynaticiParcasi> parcalar;

  const SesKategorisi({
    required this.id,
    required this.isim,
    required this.emoji,
    required this.gradientRenkler,
    required this.aksanRengi,
    required this.parcalar,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// CATEGORY & TRACK DATA
// URL alanları boş — bir sonraki adımda ses dosyası formatını konuşup ekleyeceğiz
// ─────────────────────────────────────────────────────────────────────────────

const List<SesKategorisi> _kategoriler = [
  SesKategorisi(
    id: 'yagmur',
    isim: 'Yağmur',
    emoji: '🌧️',
    gradientRenkler: [Color(0xFF0C2D4E), Color(0xFF0369A1)],
    aksanRengi: Color(0xFF38BDF8),
    parcalar: [
      OynaticiParcasi(
        id: 'y1', isim: 'Hafif Yağmur', altBaslik: 'Dinlendirici',
        ikon: Icons.grain_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'y2', isim: 'Gök Gürültüsü', altBaslik: 'Güçlü Fırtına',
        ikon: Icons.thunderstorm_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'y3', isim: 'Çatıya Yağmur', altBaslik: 'Sıcak & Rahat',
        ikon: Icons.cottage_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'y4', isim: 'Yağmurlu Orman', altBaslik: 'Doğa & Yağmur',
        ikon: Icons.forest_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'y5', isim: 'Sağanak', altBaslik: 'Yoğun Yağış',
        ikon: Icons.water_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'y6', isim: 'Şehir Yağmuru', altBaslik: 'Kent Melodisi',
        ikon: Icons.location_city_rounded, url: null,
      ),
    ],
  ),

  SesKategorisi(
    id: 'doga',
    isim: 'Doğa',
    emoji: '🌿',
    gradientRenkler: [Color(0xFF052E16), Color(0xFF15803D)],
    aksanRengi: Color(0xFF4ADE80),
    parcalar: [
      OynaticiParcasi(
        id: 'd1', isim: 'Okyanus Dalgaları', altBaslik: 'Sakinleştirici',
        ikon: Icons.waves_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'd2', isim: 'Orman Kuşları', altBaslik: 'Sabah Neşesi',
        ikon: Icons.eco_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'd3', isim: 'Şelale', altBaslik: 'Taze & Canlı',
        ikon: Icons.water_drop_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'd4', isim: 'Dere Sesi', altBaslik: 'Akış & Huzur',
        ikon: Icons.stream_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'd5', isim: 'Rüzgar', altBaslik: 'Hafif Esinti',
        ikon: Icons.air_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'd6', isim: 'Kamp Ateşi', altBaslik: 'Sıcak & Sakin',
        ikon: Icons.local_fire_department_rounded, url: null,
      ),
    ],
  ),

  SesKategorisi(
    id: 'enstruman',
    isim: 'Enstrüman',
    emoji: '🎵',
    gradientRenkler: [Color(0xFF2E1065), Color(0xFF7C3AED)],
    aksanRengi: Color(0xFFA78BFA),
    parcalar: [
      OynaticiParcasi(
        id: 'e1', isim: 'Sakin Piyano', altBaslik: 'Huzur Melodisi',
        ikon: Icons.piano_rounded, dongulu: false, sureEtiketi: '8 dk', url: null,
      ),
      OynaticiParcasi(
        id: 'e2', isim: 'Akustik Gitar', altBaslik: 'Sıcak Tonlar',
        ikon: Icons.music_note_rounded, dongulu: false, sureEtiketi: '6 dk', url: null,
      ),
      OynaticiParcasi(
        id: 'e3', isim: 'Tibet Kasesi', altBaslik: 'Şifa Titreşimleri',
        ikon: Icons.radio_button_unchecked_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'e4', isim: 'Meditasyon Flütü', altBaslik: 'Ruh Yolculuğu',
        ikon: Icons.queue_music_rounded, dongulu: false, sureEtiketi: '7 dk', url: null,
      ),
      OynaticiParcasi(
        id: 'e5', isim: 'Çello Melodisi', altBaslik: 'Derin Duygular',
        ikon: Icons.library_music_rounded, dongulu: false, sureEtiketi: '9 dk', url: null,
      ),
      OynaticiParcasi(
        id: 'e6', isim: 'Kristal Keman', altBaslik: 'Hassas & Zarif',
        ikon: Icons.audiotrack_rounded, dongulu: false, sureEtiketi: '5 dk', url: null,
      ),
    ],
  ),

  SesKategorisi(
    id: 'rahatlama',
    isim: 'Rahatlama',
    emoji: '😌',
    gradientRenkler: [Color(0xFF4A044E), Color(0xFFA21CAF)],
    aksanRengi: Color(0xFFE879F9),
    parcalar: [
      OynaticiParcasi(
        id: 'r1', isim: '432 Hz', altBaslik: 'Doğal Frekans',
        ikon: Icons.graphic_eq_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'r2', isim: 'Kristal Kaseler', altBaslik: 'Ses Banyosu',
        ikon: Icons.circle_rounded, dongulu: false, sureEtiketi: '12 dk', url: null,
      ),
      OynaticiParcasi(
        id: 'r3', isim: 'Binaural Theta', altBaslik: 'Derin Rahatlama',
        ikon: Icons.waves_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'r4', isim: 'Derin Nefes', altBaslik: 'Nefes ile Ahenk',
        ikon: Icons.air_rounded, dongulu: false, sureEtiketi: '8 dk', url: null,
      ),
      OynaticiParcasi(
        id: 'r5', isim: '528 Hz Şifa', altBaslik: 'Sevgi Frekansı',
        ikon: Icons.favorite_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'r6', isim: 'Ambient Huzur', altBaslik: 'Saf Dinginlik',
        ikon: Icons.blur_on_rounded, url: null,
      ),
    ],
  ),

  SesKategorisi(
    id: 'odak',
    isim: 'Odak',
    emoji: '🎯',
    gradientRenkler: [Color(0xFF431407), Color(0xFFB45309)],
    aksanRengi: Color(0xFFFBBF24),
    parcalar: [
      OynaticiParcasi(
        id: 'o1', isim: 'Kahve Dükkanı', altBaslik: 'Arka Plan Gürültüsü',
        ikon: Icons.coffee_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'o2', isim: 'Beyaz Gürültü', altBaslik: 'Konsantrasyon',
        ikon: Icons.radio_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'o3', isim: '40 Hz Gamma', altBaslik: 'Zihin Aktivasyonu',
        ikon: Icons.bolt_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'o4', isim: 'Binaural Beta', altBaslik: 'Odaklanma Dalgası',
        ikon: Icons.ssid_chart_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'o5', isim: 'Kütüphane', altBaslik: 'Sessiz Üretkenlik',
        ikon: Icons.menu_book_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'o6', isim: 'Lo-Fi Beats', altBaslik: 'Yaratıcı Akış',
        ikon: Icons.headphones_rounded, dongulu: false, sureEtiketi: '∞', url: null,
      ),
    ],
  ),

  SesKategorisi(
    id: 'uyku',
    isim: 'Uyku',
    emoji: '🌙',
    gradientRenkler: [Color(0xFF0A0A1A), Color(0xFF1E1B4B)],
    aksanRengi: Color(0xFF818CF8),
    parcalar: [
      OynaticiParcasi(
        id: 'u1', isim: 'Delta Dalgaları', altBaslik: 'Derin Uyku Frekansı',
        ikon: Icons.nightlight_round, url: null,
      ),
      OynaticiParcasi(
        id: 'u2', isim: 'Uyku Melodisi', altBaslik: 'Yumuşak Geçiş',
        ikon: Icons.bedtime_rounded, dongulu: false, sureEtiketi: '45 dk', url: null,
      ),
      OynaticiParcasi(
        id: 'u3', isim: 'Gece Sesleri', altBaslik: 'Doğa & Sessizlik',
        ikon: Icons.dark_mode_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'u4', isim: 'Lullaby Piyano', altBaslik: 'Nazik Melodi',
        ikon: Icons.piano_rounded, dongulu: false, sureEtiketi: '30 dk', url: null,
      ),
      OynaticiParcasi(
        id: 'u5', isim: 'Derin Uyku', altBaslik: 'Binaural Delta',
        ikon: Icons.cloud_rounded, url: null,
      ),
      OynaticiParcasi(
        id: 'u6', isim: 'Nefes & Uyku', altBaslik: 'Yavaşla & Bırak',
        ikon: Icons.air_rounded, dongulu: false, sureEtiketi: '20 dk', url: null,
      ),
    ],
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class OynaticiEkrani extends StatefulWidget {
  const OynaticiEkrani({super.key});

  @override
  State<OynaticiEkrani> createState() => _OynaticiEkraniState();
}

class _OynaticiEkraniState extends State<OynaticiEkrani>
    with SingleTickerProviderStateMixin {
  final SesServisi _sesServisi = SesServisi();

  int _aktifKategoriIndeks = 0;
  OynaticiParcasi? _aktifParca;
  bool _caliyorMu = false;
  StreamSubscription<bool>? _caliyorMuSub;

  SesKategorisi get _aktifKategori => _kategoriler[_aktifKategoriIndeks];

  @override
  void initState() {
    super.initState();
    _caliyorMuSub = _sesServisi.caliyorMuStream.listen((playing) {
      if (mounted) setState(() => _caliyorMu = playing);
    });
  }

  @override
  void dispose() {
    _caliyorMuSub?.cancel();
    super.dispose();
  }

  Future<void> _parcayiCal(OynaticiParcasi parca) async {
    if (parca.url == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${parca.isim}" yakında eklenecek 🎵'),
          backgroundColor: _aktifKategori.aksanRengi.withValues(alpha: 0.9),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() => _aktifParca = parca);
    await _sesServisi.urlCal(parca.url!, loop: parca.dongulu);
  }

  Future<void> _toggleOynat() async {
    if (_caliyorMu) {
      await _sesServisi.duraklat();
    } else {
      await _sesServisi.devamEt();
    }
  }

  Future<void> _durdur() async {
    await _sesServisi.durdur();
    setState(() => _aktifParca = null);
  }

  void _tamEkraniAc() {
    if (_aktifParca == null) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TamEkranOynatici(
        parca: _aktifParca!,
        kategori: _aktifKategori,
        caliyorMu: _caliyorMu,
        onToggle: _toggleOynat,
        onDurdur: _durdur,
        sesServisi: _sesServisi,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final kategori = _aktifKategori;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kategori.gradientRenkler[0],
              kategori.gradientRenkler[1].withValues(alpha: 0.7),
              const Color(0xFF0D0D1A),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sesler",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          "${kategori.emoji} ${kategori.isim}",
                          style: TextStyle(
                            fontSize: 13,
                            color: kategori.aksanRengi,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.timer_outlined, color: Colors.white.withValues(alpha: 0.7)),
                      onPressed: () {
                        // Zamanlayıcı — sonraki aşama
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // ── Category chips ────────────────────────────────────
              SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _kategoriler.length,
                  itemBuilder: (context, index) {
                    final k = _kategoriler[index];
                    final secili = index == _aktifKategoriIndeks;
                    return GestureDetector(
                      onTap: () => setState(() => _aktifKategoriIndeks = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: secili
                              ? LinearGradient(
                                  colors: [
                                    k.aksanRengi,
                                    k.aksanRengi.withValues(alpha: 0.7),
                                  ],
                                )
                              : null,
                          color: secili
                              ? null
                              : Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: secili
                                ? Colors.transparent
                                : Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: Text(
                          "${k.emoji} ${k.isim}",
                          style: TextStyle(
                            color: secili ? Colors.black87 : Colors.white60,
                            fontWeight: secili
                                ? FontWeight.bold
                                : FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // ── Track grid ────────────────────────────────────────
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.fromLTRB(
                    20, 0, 20,
                    _aktifParca != null ? 90 : 20,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.88,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemCount: kategori.parcalar.length,
                  itemBuilder: (context, index) {
                    final parca = kategori.parcalar[index];
                    final aktif = _aktifParca?.id == parca.id;
                    return _ParcaKarti(
                      parca: parca,
                      kategori: kategori,
                      aktif: aktif,
                      caliyorMu: aktif && _caliyorMu,
                      onTap: () => _parcayiCal(parca),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // ── Mini player ───────────────────────────────────────────────
      bottomSheet: _aktifParca != null
          ? _MiniOynatici(
              parca: _aktifParca!,
              kategori: _aktifKategori,
              caliyorMu: _caliyorMu,
              onToggle: _toggleOynat,
              onDurdur: _durdur,
              onTap: _tamEkraniAc,
            )
          : null,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TRACK CARD
// ─────────────────────────────────────────────────────────────────────────────

class _ParcaKarti extends StatelessWidget {
  final OynaticiParcasi parca;
  final SesKategorisi kategori;
  final bool aktif;
  final bool caliyorMu;
  final VoidCallback onTap;

  const _ParcaKarti({
    required this.parca,
    required this.kategori,
    required this.aktif,
    required this.caliyorMu,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: aktif ? 0.14 : 0.07),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: aktif
                ? kategori.aksanRengi.withValues(alpha: 0.7)
                : Colors.white.withValues(alpha: 0.08),
            width: aktif ? 1.5 : 1,
          ),
          boxShadow: aktif
              ? [
                  BoxShadow(
                    color: kategori.aksanRengi.withValues(alpha: 0.25),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: aktif
                      ? [kategori.aksanRengi, kategori.gradientRenkler[1]]
                      : [
                          Colors.white.withValues(alpha: 0.12),
                          Colors.white.withValues(alpha: 0.06),
                        ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(parca.ikon,
                      color: aktif
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.7),
                      size: 26),
                  // Playing pulse indicator
                  if (caliyorMu)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: kategori.aksanRengi,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: kategori.aksanRengi,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(),

            // Track name
            Text(
              parca.isim,
              style: TextStyle(
                color: aktif ? Colors.white : Colors.white.withValues(alpha: 0.9),
                fontWeight: FontWeight.bold,
                fontSize: 14,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              parca.altBaslik,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 10),

            // Duration & playing state row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    parca.sureEtiketi,
                    style: TextStyle(
                      color: kategori.aksanRengi,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (parca.url == null)
                  Text(
                    'Yakında',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 10,
                    ),
                  )
                else if (aktif)
                  Icon(
                    caliyorMu ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded,
                    color: kategori.aksanRengi,
                    size: 20,
                  )
                else
                  Icon(
                    Icons.play_circle_outline_rounded,
                    color: Colors.white.withValues(alpha: 0.4),
                    size: 20,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MINI PLAYER
// ─────────────────────────────────────────────────────────────────────────────

class _MiniOynatici extends StatelessWidget {
  final OynaticiParcasi parca;
  final SesKategorisi kategori;
  final bool caliyorMu;
  final VoidCallback onToggle;
  final VoidCallback onDurdur;
  final VoidCallback onTap;

  const _MiniOynatici({
    required this.parca,
    required this.kategori,
    required this.caliyorMu,
    required this.onToggle,
    required this.onDurdur,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kategori.gradientRenkler[1],
              kategori.gradientRenkler[0],
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: kategori.aksanRengi.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            // Icon
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(parca.ikon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parca.isim,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${kategori.emoji} ${kategori.isim}",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.65),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // Play/Pause
            IconButton(
              icon: Icon(
                caliyorMu ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: onToggle,
            ),
            // Stop
            IconButton(
              icon: Icon(
                Icons.close_rounded,
                color: Colors.white.withValues(alpha: 0.6),
                size: 22,
              ),
              onPressed: onDurdur,
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FULL SCREEN PLAYER (bottom sheet modal)
// ─────────────────────────────────────────────────────────────────────────────

class _TamEkranOynatici extends StatefulWidget {
  final OynaticiParcasi parca;
  final SesKategorisi kategori;
  final bool caliyorMu;
  final VoidCallback onToggle;
  final VoidCallback onDurdur;
  final SesServisi sesServisi;

  const _TamEkranOynatici({
    required this.parca,
    required this.kategori,
    required this.caliyorMu,
    required this.onToggle,
    required this.onDurdur,
    required this.sesServisi,
  });

  @override
  State<_TamEkranOynatici> createState() => _TamEkranOynaticiState();
}

class _TamEkranOynaticiState extends State<_TamEkranOynatici>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  StreamSubscription<bool>? _sub;
  bool _caliyorMu = false;
  Duration _pozisyon = Duration.zero;
  Duration _toplamSure = Duration.zero;
  StreamSubscription<Duration?>? _pozSub;
  StreamSubscription<Duration?>? _sureSub;

  @override
  void initState() {
    super.initState();
    _caliyorMu = widget.caliyorMu;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _sub = widget.sesServisi.caliyorMuStream.listen((v) {
      if (mounted) setState(() => _caliyorMu = v);
    });
    _pozSub = widget.sesServisi.pozisyonStream.listen((d) {
      if (mounted && d != null) setState(() => _pozisyon = d);
    });
    _sureSub = widget.sesServisi.toplamSureStream.listen((d) {
      if (mounted && d != null) setState(() => _toplamSure = d);
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _sub?.cancel();
    _pozSub?.cancel();
    _sureSub?.cancel();
    super.dispose();
  }

  String _formatSure(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  double get _ilerleme {
    if (_toplamSure.inSeconds == 0) return 0;
    return (_pozisyon.inSeconds / _toplamSure.inSeconds).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final kategori = widget.kategori;
    final parca = widget.parca;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kategori.gradientRenkler[0],
            const Color(0xFF080810),
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Handle
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Close / title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: Colors.white, size: 30),
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      kategori.emoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      kategori.isim.toUpperCase(),
                      style: TextStyle(
                        color: kategori.aksanRengi,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const SizedBox(width: 30),
              ],
            ),
          ),
          const Spacer(),

          // ── Animated icon display ──────────────────────────────
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final scale = _caliyorMu
                  ? 1.0 + _pulseController.value * 0.06
                  : 1.0;
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    kategori.aksanRengi.withValues(alpha: 0.4),
                    kategori.gradientRenkler[1].withValues(alpha: 0.6),
                    kategori.gradientRenkler[0],
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: kategori.aksanRengi.withValues(alpha: 0.35),
                    blurRadius: 60,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Icon(parca.ikon, size: 80, color: Colors.white),
            ),
          ),
          const Spacer(),

          // ── Track info ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Text(
                  parca.isim,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  parca.altBaslik,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.55),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ── Progress bar (only for non-loop tracks with a real URL) ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: parca.url != null ? 7 : 0,
                    ),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                    activeTrackColor: kategori.aksanRengi,
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.15),
                    thumbColor: Colors.white,
                  ),
                  child: Slider(
                    value: parca.dongulu ? 0 : _ilerleme,
                    onChanged: parca.url != null && !parca.dongulu
                        ? (v) {}
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        parca.dongulu ? '∞' : _formatSure(_pozisyon),
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.45),
                            fontSize: 12),
                      ),
                      Text(
                        parca.dongulu ? 'Döngü' : _formatSure(_toplamSure),
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.45),
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ── Controls ───────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Stop
              IconButton(
                icon: Icon(Icons.stop_rounded,
                    color: Colors.white.withValues(alpha: 0.5), size: 32),
                onPressed: () {
                  widget.onDurdur();
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 24),

              // Play / Pause (main button)
              GestureDetector(
                onTap: widget.onToggle,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kategori.aksanRengi,
                        kategori.gradientRenkler[1],
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: kategori.aksanRengi.withValues(alpha: 0.45),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Icon(
                    _caliyorMu ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 40,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(width: 24),

              // Loop indicator
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: parca.dongulu
                      ? kategori.aksanRengi.withValues(alpha: 0.2)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  parca.dongulu ? Icons.repeat_one_rounded : Icons.repeat_rounded,
                  color: parca.dongulu
                      ? kategori.aksanRengi
                      : Colors.white.withValues(alpha: 0.4),
                  size: 28,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
