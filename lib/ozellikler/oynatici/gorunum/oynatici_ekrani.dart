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
  /// Firebase Storage yolu — örn: 'sesler/yagmur/hafif_yagmur.mp3'
  /// null = yakında eklenecek
  final String? depolamaYolu;
  final bool dongulu;
  final String sureEtiketi;

  const OynaticiParcasi({
    required this.id,
    required this.isim,
    required this.altBaslik,
    required this.ikon,
    this.depolamaYolu,
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
// Firebase Storage yolları: sesler/{kategori}/{dosya}.mp3
// ─────────────────────────────────────────────────────────────────────────────

const List<SesKategorisi> _kategoriler = [
  // ── 🌧️ YAĞMUR (4 parça) ────────────────────────────────────────────────
  SesKategorisi(
    id: 'yagmur',
    isim: 'Yağmur',
    emoji: '🌧️',
    gradientRenkler: [Color(0xFF0C2D4E), Color(0xFF0369A1)],
    aksanRengi: Color(0xFF38BDF8),
    parcalar: [
      OynaticiParcasi(
        id: 'y1', isim: 'Hafif Yağmur', altBaslik: 'Dinlendirici',
        ikon: Icons.grain_rounded,
        depolamaYolu: 'sesler/yagmur/hafif_yagmur.mp3',
      ),
      OynaticiParcasi(
        id: 'y2', isim: 'Yağmur', altBaslik: 'Sürekli Yağış',
        ikon: Icons.water_rounded,
        depolamaYolu: 'sesler/yagmur/yagmur.mp3',
      ),
      OynaticiParcasi(
        id: 'y3', isim: 'Gök Gürültüsü', altBaslik: 'Güçlü Fırtına',
        ikon: Icons.thunderstorm_rounded,
        depolamaYolu: 'sesler/yagmur/gok_gurultusu.mp3',
      ),
      OynaticiParcasi(
        id: 'y4', isim: 'Hafif Fırtına', altBaslik: 'Rüzgar & Yağmur',
        ikon: Icons.cyclone_rounded,
        depolamaYolu: 'sesler/yagmur/hafif_firtina.mp3',
      ),
    ],
  ),

  // ── 🌿 DOĞA (6 parça) ──────────────────────────────────────────────────
  SesKategorisi(
    id: 'doga',
    isim: 'Doğa',
    emoji: '🌿',
    gradientRenkler: [Color(0xFF052E16), Color(0xFF15803D)],
    aksanRengi: Color(0xFF4ADE80),
    parcalar: [
      OynaticiParcasi(
        id: 'd1', isim: 'Okyanus', altBaslik: 'Sakinleştirici Dalgalar',
        ikon: Icons.waves_rounded,
        depolamaYolu: 'sesler/doga/okyanus.mp3',
      ),
      OynaticiParcasi(
        id: 'd2', isim: 'Orman', altBaslik: 'Huzurlu Doğa',
        ikon: Icons.forest_rounded,
        depolamaYolu: 'sesler/doga/orman.mp3',
      ),
      OynaticiParcasi(
        id: 'd3', isim: 'Kuş Sesi', altBaslik: 'Sabah Neşesi',
        ikon: Icons.eco_rounded,
        depolamaYolu: 'sesler/doga/kus_sesi.mp3',
      ),
      OynaticiParcasi(
        id: 'd4', isim: 'Baykuş', altBaslik: 'Gece Melodisi',
        ikon: Icons.dark_mode_rounded,
        depolamaYolu: 'sesler/doga/baykus.mp3',
      ),
      OynaticiParcasi(
        id: 'd5', isim: 'Gece Böceği', altBaslik: 'Sıcak Yaz Gecesi',
        ikon: Icons.nightlight_round,
        depolamaYolu: 'sesler/doga/gece_bocegi.mp3',
      ),
      OynaticiParcasi(
        id: 'd6', isim: 'Kedi', altBaslik: 'Rahatlatıcı Miyav',
        ikon: Icons.pets_rounded,
        depolamaYolu: 'sesler/doga/kedi.mp3',
      ),
      OynaticiParcasi(
        id: 'd7', isim: 'Kumru', altBaslik: 'Doğadan Güvercin',
        ikon: Icons.flutter_dash_rounded,
        depolamaYolu: 'sesler/doga/kumur.mp3',
      ),
    ],
  ),

  // ── 🎵 ENSTRÜMAN (8 parça) ─────────────────────────────────────────────
  SesKategorisi(
    id: 'enstruman',
    isim: 'Enstrüman',
    emoji: '🎵',
    gradientRenkler: [Color(0xFF2E1065), Color(0xFF7C3AED)],
    aksanRengi: Color(0xFFA78BFA),
    parcalar: [
      OynaticiParcasi(
        id: 'e1', isim: 'Sakin Piyano', altBaslik: 'Huzur Melodisi',
        ikon: Icons.piano_rounded, dongulu: false,
        depolamaYolu: 'sesler/ensturman/sakin_piyano.mp3',
      ),
      OynaticiParcasi(
        id: 'e2', isim: 'Flüt', altBaslik: 'Ruh Yolculuğu',
        ikon: Icons.queue_music_rounded, dongulu: false,
        depolamaYolu: 'sesler/ensturman/flut.mp3',
      ),
      OynaticiParcasi(
        id: 'e3', isim: 'Tibet Kasesi', altBaslik: 'Şifa Titreşimleri',
        ikon: Icons.radio_button_unchecked_rounded,
        depolamaYolu: 'sesler/ensturman/tibet_kasesi.mp3',
      ),
      OynaticiParcasi(
        id: 'e4', isim: 'Zil Sesleri', altBaslik: 'Arındırıcı Ton',
        ikon: Icons.notifications_rounded,
        depolamaYolu: 'sesler/ensturman/ziller.mp3',
      ),
      OynaticiParcasi(
        id: 'e5', isim: 'Keman', altBaslik: 'Derin Duygular',
        ikon: Icons.library_music_rounded, dongulu: false,
        depolamaYolu: 'sesler/ensturman/keman.mp3',
      ),
      OynaticiParcasi(
        id: 'e6', isim: 'Klasik Keman', altBaslik: 'Zarif & Hassas',
        ikon: Icons.audiotrack_rounded, dongulu: false,
        depolamaYolu: 'sesler/ensturman/klasik_keman.mp3',
      ),
      OynaticiParcasi(
        id: 'e7', isim: 'Kalimba & Mantra', altBaslik: 'Tinsel Yolculuk',
        ikon: Icons.music_note_rounded,
        depolamaYolu: 'sesler/ensturman/kalimba_mantra.mp3',
      ),
      OynaticiParcasi(
        id: 'e8', isim: 'Çan & Su', altBaslik: 'Doğa ile Armoni',
        ikon: Icons.water_drop_rounded,
        depolamaYolu: 'sesler/ensturman/can_ve_su.mp3',
      ),
      OynaticiParcasi(
        id: 'e9', isim: 'Klarnet', altBaslik: 'Zarif Melodi',
        ikon: Icons.queue_music_rounded, dongulu: false,
        depolamaYolu: 'sesler/ensturman/klarnet.mp3',
      ),
    ],
  ),

  // ── 😌 RAHATLAMA (6 parça) ─────────────────────────────────────────────
  SesKategorisi(
    id: 'rahatlama',
    isim: 'Rahatlama',
    emoji: '😌',
    gradientRenkler: [Color(0xFF4A044E), Color(0xFFA21CAF)],
    aksanRengi: Color(0xFFE879F9),
    parcalar: [
      OynaticiParcasi(
        id: 'r1', isim: 'Kozmik Meditasyon', altBaslik: 'Evrensel Huzur',
        ikon: Icons.blur_circular_rounded,
        depolamaYolu: 'sesler/rahatlama/cosmic_meditasyon.mp3',
      ),
      OynaticiParcasi(
        id: 'r2', isim: 'Flüt Meditasyon', altBaslik: 'Ruh Dinlendirici',
        ikon: Icons.queue_music_rounded, dongulu: false,
        depolamaYolu: 'sesler/rahatlama/flut_meditasyon.mp3',
      ),
      OynaticiParcasi(
        id: 'r3', isim: 'Ambient Meditasyon', altBaslik: 'Saf Dinginlik',
        ikon: Icons.graphic_eq_rounded,
        depolamaYolu: 'sesler/rahatlama/meditasyon_ambient.mp3',
      ),
      OynaticiParcasi(
        id: 'r4', isim: 'Enstrümantal Huzur', altBaslik: 'Melodik Rahatlama',
        ikon: Icons.piano_rounded, dongulu: false,
        depolamaYolu: 'sesler/rahatlama/meditasyon_instrumental.mp3',
      ),
      OynaticiParcasi(
        id: 'r5', isim: 'Hafif Doku', altBaslik: 'Yumuşak Atmosfer',
        ikon: Icons.blur_on_rounded,
        depolamaYolu: 'sesler/rahatlama/hafif_doku.mp3',
      ),
      OynaticiParcasi(
        id: 'r6', isim: 'Ateş Sesi', altBaslik: 'Sıcak & Sakin',
        ikon: Icons.local_fire_department_rounded,
        depolamaYolu: 'sesler/rahatlama/ates.mp3',
      ),
    ],
  ),

  // ── 🎯 ODAK (3 parça) ──────────────────────────────────────────────────
  SesKategorisi(
    id: 'odak',
    isim: 'Odak',
    emoji: '🎯',
    gradientRenkler: [Color(0xFF431407), Color(0xFFB45309)],
    aksanRengi: Color(0xFFFBBF24),
    parcalar: [
      OynaticiParcasi(
        id: 'o1', isim: 'Beyaz Gürültü', altBaslik: 'Konsantrasyon',
        ikon: Icons.radio_rounded,
        depolamaYolu: 'sesler/odak/beyaz_gurultu.mp3',
      ),
      OynaticiParcasi(
        id: 'o2', isim: 'Şömine Ateşi', altBaslik: 'Sıcak & Odaklı',
        ikon: Icons.local_fire_department_rounded,
        depolamaYolu: 'sesler/odak/ates.mp3',
      ),
      OynaticiParcasi(
        id: 'o3', isim: 'Meditasyon Müziği', altBaslik: 'Sessiz Üretkenlik',
        ikon: Icons.headphones_rounded, dongulu: false,
        depolamaYolu: 'sesler/odak/meditasyon_arkaplan.mp3',
      ),
    ],
  ),

  // ── 🌙 UYKU (4 parça) ──────────────────────────────────────────────────
  SesKategorisi(
    id: 'uyku',
    isim: 'Uyku',
    emoji: '🌙',
    gradientRenkler: [Color(0xFF0A0A1A), Color(0xFF1E1B4B)],
    aksanRengi: Color(0xFF818CF8),
    parcalar: [
      OynaticiParcasi(
        id: 'u1', isim: 'Orman Sesleri', altBaslik: 'Doğa & Sessizlik',
        ikon: Icons.forest_rounded,
        depolamaYolu: 'sesler/uyku/orman.mp3',
      ),
      OynaticiParcasi(
        id: 'u2', isim: 'Şömine Ateşi', altBaslik: 'Sıcak & Huzurlu',
        ikon: Icons.local_fire_department_rounded,
        depolamaYolu: 'sesler/uyku/ates.mp3',
      ),
      OynaticiParcasi(
        id: 'u3', isim: 'Flüt Ninnisi', altBaslik: 'Nazik Melodi',
        ikon: Icons.bedtime_rounded, dongulu: false,
        depolamaYolu: 'sesler/uyku/flut.mp3',
      ),
      OynaticiParcasi(
        id: 'u4', isim: 'Gece Böceği', altBaslik: 'Yaz Gecesi',
        ikon: Icons.nightlight_round,
        depolamaYolu: 'sesler/uyku/gece_bocegi.mp3',
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
  bool _yukleniyor = false;
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
    if (parca.depolamaYolu == null) {
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

    setState(() {
      _aktifParca = parca;
      _yukleniyor = true;
    });

    try {
      final url = await _sesServisi.storageUrlAl(parca.depolamaYolu!);
      await _sesServisi.urlCal(url, loop: parca.dongulu);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${parca.isim}" yüklenemedi. Bağlantını kontrol et.'),
            backgroundColor: Colors.red[700],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        setState(() => _aktifParca = null);
      }
    } finally {
      if (mounted) setState(() => _yukleniyor = false);
    }
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
                      yukleniyor: aktif && _yukleniyor,
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
              yukleniyor: _yukleniyor,
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
  final bool yukleniyor;
  final VoidCallback onTap;

  const _ParcaKarti({
    required this.parca,
    required this.kategori,
    required this.aktif,
    required this.caliyorMu,
    required this.yukleniyor,
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
                  if (yukleniyor)
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          kategori.aksanRengi,
                        ),
                      ),
                    )
                  else
                    Icon(parca.ikon,
                        color: aktif
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.7),
                        size: 26),
                  // Playing pulse indicator
                  if (caliyorMu && !yukleniyor)
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
                if (yukleniyor)
                  Text(
                    'Yükleniyor...',
                    style: TextStyle(
                      color: kategori.aksanRengi.withValues(alpha: 0.7),
                      fontSize: 10,
                    ),
                  )
                else if (parca.depolamaYolu == null)
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
  final bool yukleniyor;
  final VoidCallback onToggle;
  final VoidCallback onDurdur;
  final VoidCallback onTap;

  const _MiniOynatici({
    required this.parca,
    required this.kategori,
    required this.caliyorMu,
    required this.yukleniyor,
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
              child: yukleniyor
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(parca.ikon, color: Colors.white, size: 22),
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
                    yukleniyor
                        ? 'Yükleniyor...'
                        : "${kategori.emoji} ${kategori.isim}",
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
              icon: yukleniyor
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(
                      caliyorMu ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
              onPressed: yukleniyor ? null : onToggle,
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

          // ── Progress bar (only for non-loop tracks) ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: parca.depolamaYolu != null ? 7 : 0,
                    ),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                    activeTrackColor: kategori.aksanRengi,
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.15),
                    thumbColor: Colors.white,
                  ),
                  child: Slider(
                    value: parca.dongulu ? 0 : _ilerleme,
                    onChanged: parca.depolamaYolu != null && !parca.dongulu
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
