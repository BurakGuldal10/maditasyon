import 'package:flutter/material.dart';
import '../../../cekirdek/sabitler/renkler.dart';

class SuTakibiEkrani extends StatefulWidget {
  const SuTakibiEkrani({super.key});

  @override
  State<SuTakibiEkrani> createState() => _SuTakibiEkraniState();
}

class _SuTakibiEkraniState extends State<SuTakibiEkrani> {
  int _toplamSu = 0;
  final int _hedefSu = 2000;

  void _suEkle(int miktar) {
    setState(() {
      _toplamSu += miktar;
    });
  }

  @override
  Widget build(BuildContext context) {
    double yuzde = (_toplamSu / _hedefSu).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: UygulamaRenkleri.arkaPlan,
      appBar: AppBar(title: const Text("Su Takibi"), backgroundColor: Colors.transparent),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Su Dalga Animasyonu (Basit Temsil)
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.withOpacity(0.3), width: 4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 200,
                  height: 300 * yuzde,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                Positioned(
                  top: 130,
                  child: Text(
                    "%${(yuzde * 100).toInt()}",
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              "$_toplamSu / $_hedefSu ml",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _suButonu(250, Icons.local_drink),
                const SizedBox(width: 20),
                _suButonu(500, Icons.water_drop),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _suButonu(int miktar, IconData ikon) {
    return ElevatedButton.icon(
      onPressed: () => _suEkle(miktar),
      icon: Icon(ikon),
      label: Text("+$miktar ml"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[100],
        foregroundColor: Colors.blue[900],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
