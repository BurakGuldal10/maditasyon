import 'package:flutter/material.dart';
import 'dart:async';
import '../../../cekirdek/sabitler/renkler.dart';

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
  String _statusText = "Başlamak için tıkla";
  bool _isActive = false;

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

  void _startExercise() {
    setState(() {
      _isActive = true;
      _runCycle();
    });
  }

  void _runCycle() async {
    if (!_isActive) return;

    // Nefes Al
    setState(() => _statusText = "Nefes Al...");
    _animationController.forward();
    await Future.delayed(const Duration(seconds: 4));

    if (!_isActive) return;
    
    // Tut (Eğer Kare Nefesi ise)
    if (_selectedMode == "Kare Nefesi") {
      setState(() => _statusText = "Tut...");
      await Future.delayed(const Duration(seconds: 4));
    }

    if (!_isActive) return;

    // Nefes Ver
    setState(() => _statusText = "Nefes Ver...");
    _animationController.reverse();
    await Future.delayed(const Duration(seconds: 4));

    if (_isActive) _runCycle();
  }

  void _stopExercise() {
    setState(() {
      _isActive = false;
      _statusText = "Egzersiz Durduruldu";
      _animationController.stop();
    });
  }

  @override
  void dispose() {
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Zorluk Seviyesi Seçici
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ["Başlangıç", "Orta", "İleri"].map((diff) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ChoiceChip(
                      label: Text(diff),
                      selected: _selectedDifficulty == diff,
                      onSelected: (val) => setState(() => _selectedDifficulty = diff),
                      selectedColor: UygulamaRenkleri.adacayiYesili,
                      labelStyle: TextStyle(color: _selectedDifficulty == diff ? Colors.white : Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            
            // Mod Seçimi
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["Rahatlama", "Kare Nefesi", "Enerji"].map((mode) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ActionChip(
                      label: Text(mode),
                      onPressed: () => setState(() => _selectedMode = mode),
                      backgroundColor: _selectedMode == mode ? UygulamaRenkleri.adacayiYesili.withOpacity(0.2) : Colors.white,
                      side: BorderSide(color: _selectedMode == mode ? UygulamaRenkleri.adacayiYesili : Colors.grey[300]!),
                    ),
                  );
                }).toList(),
              ),
            ),
            
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
                    color: UygulamaRenkleri.adacayiYesili.withOpacity(0.3),
                    border: Border.all(color: UygulamaRenkleri.adacayiYesili, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: UygulamaRenkleri.adacayiYesili.withOpacity(0.2),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _statusText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UygulamaRenkleri.adacayiYesili),
                    ),
                  ),
                );
              },
            ),
            
            const Spacer(),
            
            // Başlat/Durdur Butonu
            GestureDetector(
              onTap: _isActive ? _stopExercise : _startExercise,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                decoration: BoxDecoration(
                  color: _isActive ? Colors.red[300] : UygulamaRenkleri.adacayiYesili,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  _isActive ? "Durdur" : "Egzersizi Başlat",
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
