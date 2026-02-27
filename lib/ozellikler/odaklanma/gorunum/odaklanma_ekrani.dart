import 'package:flutter/material.dart';
import 'dart:async';
import '../../../cekirdek/sabitler/renkler.dart';

class OdaklanmaEkrani extends StatefulWidget {
  const OdaklanmaEkrani({super.key});

  @override
  State<OdaklanmaEkrani> createState() => _OdaklanmaEkraniState();
}

class _OdaklanmaEkraniState extends State<OdaklanmaEkrani> {
  Timer? _timer;
  int _secondsRemaining = 25 * 60; // Varsayılan 25 dakika
  bool _isActive = false;
  String _mode = "Odak"; // Odak veya Mola

  void _toggleTimer() {
    if (_isActive) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            _timer?.cancel();
            _isActive = false;
            // Modu değiştir (Odak -> Mola -> Odak)
            if (_mode == "Odak") {
              _mode = "Mola";
              _secondsRemaining = 5 * 60;
            } else {
              _mode = "Odak";
              _secondsRemaining = 25 * 60;
            }
          }
        });
      });
    }
    setState(() {
      _isActive = !_isActive;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isActive = false;
      _mode = "Odak";
      _secondsRemaining = 25 * 60;
    });
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _secondsRemaining / (_mode == "Odak" ? 25 * 60 : 5 * 60);

    return Scaffold(
      backgroundColor: UygulamaRenkleri.arkaPlan,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Odaklanma",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: UygulamaRenkleri.anaYaziRengi),
              ),
              const SizedBox(height: 10),
              Text(
                _mode == "Odak" ? "Zihnini serbest bırak ve odaklan." : "Harika bir iş çıkardın, şimdi mola zamanı.",
                textAlign: TextAlign.center,
                style: const TextStyle(color: UygulamaRenkleri.ikincilYaziRengi),
              ),
              const Spacer(),

              // Pomodoro Dairesel İlerleme
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 10,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _mode == "Odak" ? UygulamaRenkleri.adacayiYesili : Colors.blue[300]!,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formatTime(_secondsRemaining),
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _mode.toUpperCase(),
                        style: TextStyle(
                          letterSpacing: 2,
                          color: _mode == "Odak" ? UygulamaRenkleri.adacayiYesili : Colors.blue[300],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),

              // Odaklanma Sesleri Seçici
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Odaklanma Sesleri",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _sesKarti("Yağmur", Icons.umbrella_rounded, Colors.blue[50]!),
                    _sesKarti("Doğa", Icons.nature_rounded, Colors.green[50]!),
                    _sesKarti("Kütüphane", Icons.menu_book_rounded, Colors.orange[50]!),
                    _sesKarti("Fırtına", Icons.bolt_rounded, Colors.purple[50]!),
                  ],
                ),
              ),
              const Spacer(),

              // Kontroller
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.refresh_rounded, size: 30),
                    onPressed: _resetTimer,
                    color: UygulamaRenkleri.ikincilYaziRengi,
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: _toggleTimer,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      decoration: BoxDecoration(
                        color: _isActive ? Colors.red[300] : UygulamaRenkleri.adacayiYesili,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: (_isActive ? Colors.red[300]! : UygulamaRenkleri.adacayiYesili).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Text(
                        _isActive ? "Durdur" : "Başlat",
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined, size: 30),
                    onPressed: () {},
                    color: UygulamaRenkleri.ikincilYaziRengi,
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sesKarti(String isim, IconData ikon, Color renk) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: renk,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(ikon, color: Colors.black54),
          const SizedBox(height: 5),
          Text(isim, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
