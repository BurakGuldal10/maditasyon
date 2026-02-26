import 'package:flutter/material.dart';
import '../../../cekirdek/sabitler/renkler.dart';

class UykuTakibiEkrani extends StatelessWidget {
  const UykuTakibiEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1C2E), // Koyu gece mavisi
      appBar: AppBar(
        title: const Text("Uyku Takibi", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.dark_mode, size: 80, color: Colors.amberAccent),
            ),
            const SizedBox(height: 30),
            const Text(
              "Dün Gece",
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const Text(
              "7 Saat 30 Dakika",
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            _uykuBilgiKarti("Yatış Zamanı", "23:15", Icons.bedtime),
            const SizedBox(height: 15),
            _uykuBilgiKarti("Uyanış Zamanı", "06:45", Icons.wb_sunny),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Text("Uyku Kalitesi", style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star_half, color: Colors.amber),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _uykuBilgiKarti(String baslik, String saat, IconData ikon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(ikon, color: UygulamaRenkleri.gokyuzuMavisi),
              const SizedBox(width: 15),
              Text(baslik, style: const TextStyle(color: Colors.white)),
            ],
          ),
          Text(saat, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }
}
