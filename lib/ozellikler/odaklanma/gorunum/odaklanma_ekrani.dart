import 'package:flutter/material.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import '../../../cekirdek/servisler/ses_servisi.dart';

class OdaklanmaEkrani extends StatefulWidget {
  const OdaklanmaEkrani({super.key});

  @override
  State<OdaklanmaEkrani> createState() => _OdaklanmaEkraniState();
}

class _OdaklanmaEkraniState extends State<OdaklanmaEkrani>
    with SingleTickerProviderStateMixin {
  // ── Timer ─────────────────────────────────────────────────────
  Timer? _timer;
  bool _isActive = false;
  bool _isOdakModu = true;

  int _odakSn = 25 * 60;
  int _molaSn = 5 * 60;
  int _kalanSn = 25 * 60;
  int _tamamlananSeans = 0;

  // ── Ses ───────────────────────────────────────────────────────
  String? _aktifSes;
  bool _sesYukleniyor = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  final List<Map<String, dynamic>> _sesler = [
    {
      "isim": "Yağmur",
      "ikon": Icons.water_drop_rounded,
      "renk": Color(0xFF4A90D9),
      "yol": "sesler/yagmur/hafif_yagmur.mp3",
    },
    {
      "isim": "Orman",
      "ikon": Icons.forest_rounded,
      "renk": Color(0xFF4CAF50),
      "yol": "sesler/doga/orman.mp3",
    },
    {
      "isim": "Beyaz Gürültü",
      "ikon": Icons.graphic_eq_rounded,
      "renk": Color(0xFF78909C),
      "yol": "sesler/odak/beyaz_gurultu.mp3",
    },
    {
      "isim": "Fırtına",
      "ikon": Icons.thunderstorm_rounded,
      "renk": Color(0xFF7E57C2),
      "yol": "sesler/yagmur/hafif_firtina.mp3",
    },
    {
      "isim": "Şömine",
      "ikon": Icons.local_fire_department_rounded,
      "renk": Color(0xFFFF7043),
      "yol": "sesler/odak/ates.mp3",
    },
    {
      "isim": "Meditasyon",
      "ikon": Icons.self_improvement_rounded,
      "renk": Color(0xFFAB47BC),
      "yol": "sesler/odak/meditasyon_arkaplan.mp3",
    },
    {
      "isim": "Kumru",
      "ikon": Icons.flutter_dash_rounded,
      "renk": Color(0xFF66BB6A),
      "yol": "sesler/doga/kumur.mp3",
    },
    {
      "isim": "Klarnet",
      "ikon": Icons.music_note_rounded,
      "renk": Color(0xFF5C6BC0),
      "yol": "sesler/ensturman/klarnet.mp3",
    },
  ];

  @override
  void initState() {
    super.initState();
    _kalanSn = _odakSn;
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _pulseAnim = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // ── Timer Mantığı ──────────────────────────────────────────────

  void _toggleTimer() {
    if (_isActive) {
      _timer?.cancel();
      _pulseController.stop();
      _pulseController.reset();
    } else {
      _pulseController.repeat(reverse: true);
      _timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (!mounted) { t.cancel(); return; }
        setState(() {
          if (_kalanSn > 0) {
            _kalanSn--;
          } else {
            t.cancel();
            _isActive = false;
            _pulseController.stop();
            _pulseController.reset();
            if (_isOdakModu) {
              _tamamlananSeans++;
              _isOdakModu = false;
              _kalanSn = _molaSn;
            } else {
              _isOdakModu = true;
              _kalanSn = _odakSn;
            }
          }
        });
      });
    }
    setState(() => _isActive = !_isActive);
  }

  void _resetTimer() {
    _timer?.cancel();
    _pulseController.stop();
    _pulseController.reset();
    setState(() {
      _isActive = false;
      _isOdakModu = true;
      _kalanSn = _odakSn;
    });
  }

  void _skipMod() {
    _timer?.cancel();
    _pulseController.stop();
    _pulseController.reset();
    setState(() {
      _isActive = false;
      if (_isOdakModu) {
        _tamamlananSeans++;
        _isOdakModu = false;
        _kalanSn = _molaSn;
      } else {
        _isOdakModu = true;
        _kalanSn = _odakSn;
      }
    });
  }

  void _odakSuresiSec(int saniye) {
    if (_isActive) return;
    setState(() {
      _odakSn = saniye;
      if (_isOdakModu) _kalanSn = saniye;
    });
  }

  void _molaSuresiSec(int saniye) {
    if (_isActive) return;
    setState(() {
      _molaSn = saniye;
      if (!_isOdakModu) _kalanSn = saniye;
    });
  }

  // ── Ses Mantığı ────────────────────────────────────────────────

  Future<void> _sesiToggle(Map<String, dynamic> ses) async {
    final isim = ses["isim"] as String;
    if (_aktifSes == isim) {
      await _audioPlayer.stop();
      setState(() => _aktifSes = null);
      return;
    }

    await _audioPlayer.stop();
    setState(() {
      _aktifSes = isim;
      _sesYukleniyor = true;
    });

    try {
      final url = await SesServisi().storageUrlAl(ses["yol"] as String);
      await _audioPlayer.setUrl(url);
      await _audioPlayer.setLoopMode(LoopMode.one);
      _audioPlayer.play();
    } catch (_) {
      if (mounted) {
        setState(() => _aktifSes = null);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ses yüklenemedi, bağlantını kontrol et")),
        );
      }
    } finally {
      if (mounted) setState(() => _sesYukleniyor = false);
    }
  }

  // ── Yardımcılar ────────────────────────────────────────────────

  String _formatSure(int sn) {
    final m = (sn ~/ 60).toString().padLeft(2, '0');
    final s = (sn % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  Color get _aksanRenk =>
      _isOdakModu ? const Color(0xFFA78BFA) : const Color(0xFF34D399);

  // ── BUILD ─────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final ilerleme = _kalanSn / (_isOdakModu ? _odakSn : _molaSn);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0D0D1A),
              _aksanRenk.withOpacity(0.07),
              const Color(0xFF0D0D1A),
            ],
            stops: const [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ─────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Odaklanma",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: Text(
                            key: ValueKey(_isOdakModu),
                            _isOdakModu
                                ? "Zihnini boşalt, odaklan"
                                : "Harika! Şimdi mola zamanı",
                            style: TextStyle(
                              fontSize: 13,
                              color: _aksanRenk,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Tamamlanan seans göstergesi (4 nokta)
                    Row(
                      children: List.generate(4, (i) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(left: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i < _tamamlananSeans % 4
                                ? _aksanRenk
                                : Colors.white.withOpacity(0.15),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              // ── Dairesel Timer ─────────────────────────────────
              Expanded(
                flex: 5,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _pulseAnim,
                    builder: (context, child) => Transform.scale(
                      scale: _isActive ? _pulseAnim.value : 1.0,
                      child: child,
                    ),
                    child: SizedBox(
                      width: 230,
                      height: 230,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Arka halka (gölge)
                          SizedBox.expand(
                            child: CircularProgressIndicator(
                              value: 1.0,
                              strokeWidth: 14,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white.withOpacity(0.06),
                              ),
                            ),
                          ),
                          // İlerleme halkası
                          SizedBox.expand(
                            child: CircularProgressIndicator(
                              value: ilerleme,
                              strokeWidth: 14,
                              strokeCap: StrokeCap.round,
                              valueColor: AlwaysStoppedAnimation<Color>(_aksanRenk),
                            ),
                          ),
                          // İçerik
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _formatSure(_kalanSn),
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: -1,
                                ),
                              ),
                              const SizedBox(height: 8),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _aksanRenk.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  _isOdakModu ? "ODAK" : "MOLA",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3,
                                    color: _aksanRenk,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ── Süre Seçici Chipler ────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _sureCipi("25 dk", 25 * 60, true),
                    const SizedBox(width: 8),
                    _sureCipi("50 dk", 50 * 60, true),
                    const SizedBox(width: 14),
                    Container(
                      width: 1,
                      height: 18,
                      color: Colors.white12,
                    ),
                    const SizedBox(width: 14),
                    _sureCipi("5 dk", 5 * 60, false),
                    const SizedBox(width: 8),
                    _sureCipi("10 dk", 10 * 60, false),
                  ],
                ),
              ),

              // ── Kontroller ─────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _kontrolDugme(Icons.refresh_rounded, Colors.white38, _resetTimer, 46),
                    const SizedBox(width: 22),
                    GestureDetector(
                      onTap: _toggleTimer,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: _isOdakModu
                                ? [const Color(0xFFA78BFA), const Color(0xFF7C3AED)]
                                : [const Color(0xFF34D399), const Color(0xFF059669)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _aksanRenk.withOpacity(0.45),
                              blurRadius: 22,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          _isActive ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
                    ),
                    const SizedBox(width: 22),
                    _kontrolDugme(Icons.skip_next_rounded, Colors.white38, _skipMod, 46),
                  ],
                ),
              ),

              // ── Arka Plan Sesleri ──────────────────────────────
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 4, 24, 12),
                      child: Row(
                        children: [
                          const Text(
                            "Arka Plan Sesleri",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (_aktifSes != null)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.volume_up_rounded,
                                    color: _aksanRenk,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _aktifSes!,
                                    style: TextStyle(
                                      color: _aksanRenk,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        itemCount: _sesler.length,
                        itemBuilder: (context, index) => _sesKarti(_sesler[index]),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Widget Yardımcıları ───────────────────────────────────────

  Widget _sureCipi(String etiket, int saniye, bool odakMiMola) {
    final secili = odakMiMola == _isOdakModu &&
        (odakMiMola ? _odakSn : _molaSn) == saniye;
    final renk = odakMiMola ? const Color(0xFFA78BFA) : const Color(0xFF34D399);

    return GestureDetector(
      onTap: () => odakMiMola ? _odakSuresiSec(saniye) : _molaSuresiSec(saniye),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: secili ? renk.withOpacity(0.15) : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: secili ? renk.withOpacity(0.5) : Colors.white.withOpacity(0.08),
          ),
        ),
        child: Text(
          etiket,
          style: TextStyle(
            color: secili ? renk : Colors.white38,
            fontSize: 12,
            fontWeight: secili ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _kontrolDugme(
    IconData ikon,
    Color renk,
    VoidCallback onTap,
    double boyut,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: boyut,
        height: boyut,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.07),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Icon(ikon, color: renk, size: 22),
      ),
    );
  }

  Widget _sesKarti(Map<String, dynamic> ses) {
    final isim = ses["isim"] as String;
    final aktif = _aktifSes == isim;
    final yukleniyor = aktif && _sesYukleniyor;
    final renk = ses["renk"] as Color;

    return GestureDetector(
      onTap: () => _sesiToggle(ses),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 95,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: aktif ? renk.withOpacity(0.18) : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: aktif ? renk.withOpacity(0.6) : Colors.white.withOpacity(0.08),
            width: aktif ? 1.5 : 1,
          ),
          boxShadow: aktif
              ? [BoxShadow(color: renk.withOpacity(0.3), blurRadius: 18, spreadRadius: 1)]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (yukleniyor)
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(renk),
                ),
              )
            else
              Icon(
                ses["ikon"] as IconData,
                size: 30,
                color: aktif ? renk : Colors.white38,
              ),
            const SizedBox(height: 10),
            Text(
              isim,
              style: TextStyle(
                color: aktif ? Colors.white : Colors.white54,
                fontSize: 11,
                fontWeight: aktif ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            if (aktif && !yukleniyor) ...[
              const SizedBox(height: 6),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: renk,
                  boxShadow: [BoxShadow(color: renk, blurRadius: 5)],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
