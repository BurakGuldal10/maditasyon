import 'package:flutter/material.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import '../../../cekirdek/sabitler/renkler.dart';
import '../../../cekirdek/servisler/ses_servisi.dart';

class UykuSesleriEkrani extends StatefulWidget {
  const UykuSesleriEkrani({super.key});

  @override
  State<UykuSesleriEkrani> createState() => _UykuSesleriEkraniState();
}

class _UykuSesleriEkraniState extends State<UykuSesleriEkrani>
    with SingleTickerProviderStateMixin {
  String? _aktifSes;
  int _seciliZamanDakika = 30;
  int _kalanSaniye = 0;
  Timer? _zamanlayici;
  bool _calisiyor = false;
  bool _sesYukleniyor = false;

  final AudioPlayer _audioPlayer = AudioPlayer();

  late AnimationController _animController;
  late Animation<double> _pulseAnimation;

  final List<Map<String, dynamic>> _sesler = [
    {
      "isim": "Yağmur",
      "ikon": Icons.water_drop_rounded,
      "renk": Color(0xFF1454A0),
      "aciklama": "Hafif yağmur sesi",
      "depolamaYolu": "sesler/yagmur/hafif_yagmur.mp3",
    },
    {
      "isim": "Okyanus",
      "ikon": Icons.waves_rounded,
      "renk": Color(0xFF1A73E8),
      "aciklama": "Dalga sesleri",
      "depolamaYolu": "sesler/doga/okyanus.mp3",
    },
    {
      "isim": "Orman",
      "ikon": Icons.forest_rounded,
      "renk": Color(0xFF2E7D32),
      "aciklama": "Kuş ve doğa sesleri",
      "depolamaYolu": "sesler/uyku/orman.mp3",
    },
    {
      "isim": "Şömine",
      "ikon": Icons.fireplace_rounded,
      "renk": Color(0xFFC62828),
      "aciklama": "Çıtırdayan ateş",
      "depolamaYolu": "sesler/uyku/ates.mp3",
    },
    {
      "isim": "Gece Böcekleri",
      "ikon": Icons.dark_mode_rounded,
      "renk": Color(0xFFF9A825),
      "aciklama": "Cırcır böcekleri",
      "depolamaYolu": "sesler/uyku/gece_bocegi.mp3",
    },
    {
      "isim": "Beyaz Gürültü",
      "ikon": Icons.graphic_eq_rounded,
      "renk": Color(0xFF546E7A),
      "aciklama": "Sakin beyaz gürültü",
      "depolamaYolu": "sesler/odak/beyaz_gurultu.mp3",
    },
  ];

  final List<int> _zamanSecenekleri = [15, 30, 45, 60, 90];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _zamanlayici?.cancel();
    _audioPlayer.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _sesiToggle(Map<String, dynamic> ses) async {
    final isim = ses["isim"] as String;
    if (_aktifSes == isim) {
      _sesiDurdur();
      return;
    }

    // Önceki sesi durdur
    await _audioPlayer.stop();
    _zamanlayici?.cancel();

    setState(() {
      _aktifSes = isim;
      _calisiyor = true;
      _kalanSaniye = _seciliZamanDakika * 60;
      _sesYukleniyor = true;
    });

    _animController.repeat(reverse: true);
    _zamanlayici = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) { timer.cancel(); return; }
      if (_kalanSaniye > 0) {
        setState(() => _kalanSaniye--);
      } else {
        _sesiDurdur();
      }
    });

    try {
      final url = await SesServisi().storageUrlAl(ses["depolamaYolu"] as String);
      await _audioPlayer.setUrl(url);
      await _audioPlayer.setLoopMode(LoopMode.one);
      _audioPlayer.play();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ses yüklenemedi, bağlantını kontrol et")),
        );
        _sesiDurdur();
      }
    } finally {
      if (mounted) setState(() => _sesYukleniyor = false);
    }
  }

  void _sesiDurdur() {
    _audioPlayer.stop();
    _zamanlayici?.cancel();
    _animController.stop();
    _animController.reset();
    setState(() {
      _aktifSes = null;
      _calisiyor = false;
      _kalanSaniye = 0;
      _sesYukleniyor = false;
    });
  }

  String _kalanSureFormati() {
    final dakika = _kalanSaniye ~/ 60;
    final saniye = _kalanSaniye % 60;
    return "${dakika.toString().padLeft(2, '0')}:${saniye.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UygulamaRenkleri.geceKoyuMavi,
      appBar: AppBar(
        title: const Text(
          "Uyku Sesleri",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Aktif ses gösterimi (çalıyorsa)
            if (_calisiyor) _aktifSesGosterimi(),

            // Zamanlayıcı seçici
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Zamanlayıcı",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _zamanSecenekleri.map((dakika) {
                        final secili = _seciliZamanDakika == dakika;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: _calisiyor
                                ? null
                                : () => setState(() => _seciliZamanDakika = dakika),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: secili
                                    ? UygulamaRenkleri.uykuMoru
                                    : Colors.white.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(25),
                                border: secili
                                    ? null
                                    : Border.all(color: Colors.white.withOpacity(0.1)),
                              ),
                              child: Text(
                                "$dakika dk",
                                style: TextStyle(
                                  color: secili ? Colors.white : Colors.white54,
                                  fontWeight: secili ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Ses kartları grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  itemCount: _sesler.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    return _sesKarti(_sesler[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aktifSesGosterimi() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            UygulamaRenkleri.uykuMoru.withOpacity(0.3),
            UygulamaRenkleri.uykuAcikMor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: UygulamaRenkleri.uykuMoru.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: UygulamaRenkleri.uykuMoru.withOpacity(0.3),
              ),
              child: _sesYukleniyor
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.music_note_rounded, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _aktifSes ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _sesYukleniyor ? "Yükleniyor..." : "Kalan: ${_kalanSureFormati()}",
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _sesiDurdur,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white12,
              ),
              child: const Icon(Icons.stop_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sesKarti(Map<String, dynamic> ses) {
    final aktif = _aktifSes == ses["isim"];
    final yukleniyor = aktif && _sesYukleniyor;

    final renk = ses["renk"] as Color;
    return GestureDetector(
      onTap: () => _sesiToggle(ses),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: aktif ? renk : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: aktif ? renk : Colors.white.withOpacity(0.08),
          ),
          boxShadow: aktif
              ? [
                  BoxShadow(
                    color: renk.withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (yukleniyor)
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(renk),
                  ),
                )
              else
                Icon(
                  ses["ikon"] as IconData,
                  size: 40,
                  color: aktif ? Colors.white : Colors.white54,
                ),
              const SizedBox(height: 12),
              Text(
                ses["isim"] as String,
                style: TextStyle(
                  color: aktif ? Colors.white : Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                ses["aciklama"] as String,
                style: TextStyle(
                  color: aktif ? Colors.white70 : Colors.white30,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
              ),
              if (aktif && !yukleniyor) ...[
                const SizedBox(height: 8),
                const Icon(
                  Icons.pause_circle_filled_rounded,
                  color: Colors.white70,
                  size: 22,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
