import 'package:flutter/material.dart';
import 'dart:async';
import '../../gunluk/gorunum/gunluk_ekrani.dart';

class NefesEgzersiziEkrani extends StatefulWidget {
  const NefesEgzersiziEkrani({super.key});

  @override
  State<NefesEgzersiziEkrani> createState() => _NefesEgzersiziEkraniState();
}

class _NefesEgzersiziEkraniState extends State<NefesEgzersiziEkrani> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  static const Color _anaRenk = Color(0xFF0EA5E9);
  static const Color _acikRenk = Color(0xFF38BDF8);

  String _selectedMode = "Rahatlama";
  String _selectedDifficulty = "Başlangıç";
  String _statusText = "Hazır mısın?";
  int _remainingSeconds = 0;
  bool _isActive = false;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _sizeAnimation = Tween<double>(begin: 150.0, end: 280.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  Map<String, int> _getDurations() {
    double multiplier = 1.0;
    if (_selectedDifficulty == "Orta") multiplier = 1.5;
    if (_selectedDifficulty == "İleri") multiplier = 2.0;

    if (_selectedMode == "Kare Nefesi") {
      int s = (4 * multiplier).round();
      return {"al": s, "tut1": s, "ver": s, "tut2": s};
    } else if (_selectedMode == "Enerji") {
      int s = (3 * multiplier).round();
      return {"al": s, "tut1": 0, "ver": (1 * multiplier).round(), "tut2": 0};
    } else {
      return {
        "al": (4 * multiplier).round(),
        "tut1": (2 * multiplier).round(),
        "ver": (6 * multiplier).round(),
        "tut2": 0
      };
    }
  }

  void _startExercise() {
    setState(() {
      _isActive = true;
      _runCycle();
    });
  }

  Future<void> _startCountdown(int seconds) async {
    if (seconds <= 0) return;
    setState(() => _remainingSeconds = seconds);
    _countdownTimer?.cancel();
    Completer<void> completer = Completer<void>();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || !_isActive) {
        timer.cancel();
        if (!completer.isCompleted) completer.complete();
        return;
      }
      if (_remainingSeconds > 1) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        if (!completer.isCompleted) completer.complete();
      }
    });
    return completer.future;
  }

  void _runCycle() async {
    if (!_isActive) return;
    final durations = _getDurations();

    if (!_isActive) return;
    setState(() => _statusText = "Nefes Al");
    _animationController.duration = Duration(seconds: durations["al"]!);
    _animationController.forward();
    await _startCountdown(durations["al"]!);

    if (!_isActive) return;
    if (durations["tut1"]! > 0) {
      setState(() {
        _statusText = "Tut";
        _remainingSeconds = durations["tut1"]!;
      });
      await _startCountdown(durations["tut1"]!);
    }

    if (!_isActive) return;
    setState(() => _statusText = "Nefes Ver");
    _animationController.duration = Duration(seconds: durations["ver"]!);
    _animationController.reverse();
    await _startCountdown(durations["ver"]!);

    if (!_isActive) return;
    if (durations["tut2"]! > 0) {
      setState(() {
        _statusText = "Tekrar için Tut";
        _remainingSeconds = durations["tut2"]!;
      });
      await _startCountdown(durations["tut2"]!);
    }

    if (_isActive) _runCycle();
  }

  void _stopExercise() {
    _isActive = false;
    _countdownTimer?.cancel();
    _animationController.stop();
    setState(() {
      _statusText = "Hazır mısın?";
      _remainingSeconds = 0;
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  Widget _chipSatiri(String baslik, List<String> secenekler, String secili, void Function(String) onSec) {
    return Column(
      children: [
        Text(
          baslik,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: secenekler.map((s) {
              final aktif = secili == s;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () => onSec(s),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: aktif ? _anaRenk : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: aktif ? _anaRenk : const Color(0xFFCBE4F5),
                      ),
                      boxShadow: aktif
                          ? [BoxShadow(color: _anaRenk.withOpacity(0.25), blurRadius: 10, offset: const Offset(0, 4))]
                          : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
                    ),
                    child: Text(
                      s,
                      style: TextStyle(
                        color: aktif ? Colors.white : const Color(0xFF475569),
                        fontWeight: aktif ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2FE),
      appBar: AppBar(
        title: const Text(
          "Nefes Egzersizi",
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0C4A6E)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0C4A6E)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isActive) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _chipSatiri(
                      "Mod Seçin",
                      ["Rahatlama", "Kare Nefesi", "Enerji"],
                      _selectedMode,
                      (s) => setState(() => _selectedMode = s),
                    ),
                    const SizedBox(height: 20),
                    _chipSatiri(
                      "Zorluk Seviyesi",
                      ["Başlangıç", "Orta", "İleri"],
                      _selectedDifficulty,
                      (s) => setState(() => _selectedDifficulty = s),
                    ),
                  ],
                ),
              ),
            ],

            const Spacer(),

            // Animasyonlu Nefes Dairesi
            AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, child) {
                return Container(
                  width: _sizeAnimation.value,
                  height: _sizeAnimation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _acikRenk.withOpacity(0.18),
                    border: Border.all(color: _anaRenk.withOpacity(0.5), width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: _anaRenk.withOpacity(0.15),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _statusText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: _isActive ? 24 : 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0C4A6E),
                          ),
                        ),
                        if (_isActive && _remainingSeconds > 0) ...[
                          const SizedBox(height: 10),
                          Text(
                            "$_remainingSeconds",
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w300,
                              color: _anaRenk,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),

            const Spacer(),

            // Başlat/Durdur Butonu
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _isActive ? _stopExercise : _startExercise,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                      decoration: BoxDecoration(
                        color: _isActive ? const Color(0xFFEF4444) : _anaRenk,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: (_isActive ? const Color(0xFFEF4444) : _anaRenk).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Text(
                        _isActive ? "Egzersizi Bitir" : "Başlat",
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  if (!_isActive) ...[
                    const SizedBox(height: 25),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const GunlukEkrani()));
                      },
                      icon: const Icon(Icons.edit_note, color: _anaRenk),
                      label: const Text(
                        "Hislerini Not Et",
                        style: TextStyle(color: _anaRenk, fontSize: 16),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
