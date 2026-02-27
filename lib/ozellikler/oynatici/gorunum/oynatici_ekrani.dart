import 'package:flutter/material.dart';

import '../../../cekirdek/sabitler/renkler.dart';

class OynaticiEkrani extends StatefulWidget {
  const OynaticiEkrani({super.key});

  @override
  State<OynaticiEkrani> createState() => _OynaticiEkraniState();
}

class _OynaticiEkraniState extends State<OynaticiEkrani>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  bool _isPlaying = false;
  double _currentSliderValue = 20.0;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _rotationController.repeat();
      } else {
        _rotationController.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              UygulamaRenkleri.adacayiYesili.withOpacity(0.3),
              UygulamaRenkleri.arkaPlan,
              UygulamaRenkleri.yumusakLavanta.withOpacity(0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                // Üst Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
                    const Text(
                      "ŞİMDİ OYNATILIYOR",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.timer_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
                const Spacer(),

                // Dönen Kapak Fotoğrafı
                RotationTransition(
                  turns: _rotationController,
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Başlık ve Sanatçı
                const Text(
                  "Derin Odaklanma",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: UygulamaRenkleri.anaYaziRengi,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Zihin Arınma Serisi",
                  style: TextStyle(
                    fontSize: 16,
                    color: UygulamaRenkleri.ikincilYaziRengi,
                  ),
                ),
                const Spacer(),

                // Zaman Çizelgesi (Slider)
                Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 14,
                        ),
                        activeTrackColor: UygulamaRenkleri.adacayiYesili,
                        inactiveTrackColor: Colors.black12,
                        thumbColor: UygulamaRenkleri.adacayiYesili,
                      ),
                      child: Slider(
                        value: _currentSliderValue,
                        max: 100,
                        onChanged: (value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "03:45",
                            style: TextStyle(
                              fontSize: 12,
                              color: UygulamaRenkleri.ikincilYaziRengi,
                            ),
                          ),
                          Text(
                            "10:00",
                            style: TextStyle(
                              fontSize: 12,
                              color: UygulamaRenkleri.ikincilYaziRengi,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Kontroller
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.replay_10_rounded, size: 35),
                      onPressed: () {},
                      color: UygulamaRenkleri.anaYaziRengi,
                    ),
                    const SizedBox(width: 25),
                    GestureDetector(
                      onTap: _togglePlay,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: UygulamaRenkleri.adacayiYesili,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 45,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    IconButton(
                      icon: const Icon(Icons.forward_10_rounded, size: 35),
                      onPressed: () {},
                      color: UygulamaRenkleri.anaYaziRengi,
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
