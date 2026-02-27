import 'package:flutter/material.dart';
import 'dart:async';
import '../../../cekirdek/sabitler/renkler.dart';
import '../../gunluk/gorunum/gunluk_ekrani.dart';

class NefesEgzersiziEkrani extends StatefulWidget {
  const NefesEgzersiziEkrani({super.key});

  @override
  State<NefesEgzersiziEkrani> createState() => _NefesEgzersiziEkraniState();
}

class _NefesEgzersiziEkraniState extends State<NefesEgzersiziEkrani> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  
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

  // Mod ve Zorluğa göre süreleri belirle
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
      // Rahatlama (Varsayılan)
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

    // 1. Nefes Al
    if (!_isActive) return;
    setState(() => _statusText = "Nefes Al");
    _animationController.duration = Duration(seconds: durations["al"]!);
    _animationController.forward();
    await _startCountdown(durations["al"]!);

    // 2. Tut (Nefes sonrası)
    if (!_isActive) return;
    if (durations["tut1"]! > 0) {
      setState(() {
        _statusText = "Tut";
        _remainingSeconds = durations["tut1"]!;
      });
      await _startCountdown(durations["tut1"]!);
    }

    // 3. Nefes Ver
    if (!_isActive) return;
    setState(() => _statusText = "Nefes Ver");
    _animationController.duration = Duration(seconds: durations["ver"]!);
    _animationController.reverse();
    await _startCountdown(durations["ver"]!);

    // 4. Tut (Nefes sonrası - Sadece Kare Nefesi vb.)
    if (!_isActive) return;
    if (durations["tut2"]! > 0) {
      setState(() {
        _statusText = "Tekrar için Tut";
        _remainingSeconds = durations["tut2"]!;
      });
      await _startCountdown(durations["tut2"]!);
    }

    // Döngüyü tekrarla
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UygulamaRenkleri.arkaPlan,
      appBar: AppBar(
        title: const Text("Nefes Egzersizi", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              // Mod Seçimi
              const Text("Mod Seçin", style: TextStyle(fontWeight: FontWeight.w600, color: UygulamaRenkleri.ikincilYaziRengi)),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ["Rahatlama", "Kare Nefesi", "Enerji"].map((mode) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ChoiceChip(
                        label: Text(mode),
                        selected: _selectedMode == mode,
                        onSelected: (val) {
                          if (val) setState(() => _selectedMode = mode);
                        },
                        selectedColor: UygulamaRenkleri.adacayiYesili,
                        labelStyle: TextStyle(color: _selectedMode == mode ? Colors.white : Colors.black87),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              
              // Zorluk Seviyesi Seçici
              const Text("Zorluk Seviyesi", style: TextStyle(fontWeight: FontWeight.w600, color: UygulamaRenkleri.ikincilYaziRengi)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ["Başlangıç", "Orta", "İleri"].map((diff) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ChoiceChip(
                      label: Text(diff),
                      selected: _selectedDifficulty == diff,
                      onSelected: (val) {
                        if (val) setState(() => _selectedDifficulty = diff);
                      },
                      selectedColor: UygulamaRenkleri.adacayiYesili.withOpacity(0.7),
                      labelStyle: TextStyle(color: _selectedDifficulty == diff ? Colors.white : Colors.black87),
                    ),
                  );
                }).toList(),
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
                    color: UygulamaRenkleri.adacayiYesili.withOpacity(0.15),
                    border: Border.all(color: UygulamaRenkleri.adacayiYesili.withOpacity(0.5), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: UygulamaRenkleri.adacayiYesili.withOpacity(0.1),
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
                            color: UygulamaRenkleri.anaYaziRengi
                          ),
                        ),
                        if (_isActive && _remainingSeconds > 0) ...[
                          const SizedBox(height: 10),
                          Text(
                            "$_remainingSeconds",
                            style: const TextStyle(
                              fontSize: 48, 
                              fontWeight: FontWeight.w300, 
                              color: UygulamaRenkleri.adacayiYesili
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
                        color: _isActive ? Colors.red[400] : UygulamaRenkleri.adacayiYesili,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: (_isActive ? Colors.red[400]! : UygulamaRenkleri.adacayiYesili).withOpacity(0.3),
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
                      icon: const Icon(Icons.edit_note, color: UygulamaRenkleri.adacayiYesili),
                      label: const Text("Hislerini Not Et", style: TextStyle(color: UygulamaRenkleri.adacayiYesili, fontSize: 16)),
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
