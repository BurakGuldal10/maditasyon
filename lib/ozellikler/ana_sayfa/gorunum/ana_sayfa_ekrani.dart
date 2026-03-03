import 'package:flutter/material.dart';
import '../../../cekirdek/sabitler/renkler.dart';
import '../../nefes_egzersizi/gorunum/nefes_egzersizi_ekrani.dart';
import '../../su_takibi/gorunum/su_takibi_ekrani.dart';
import '../../uyku_takibi/gorunum/uyku_takibi_ekrani.dart';
import '../../odaklanma/gorunum/odaklanma_ekrani.dart';
import '../../gunluk/gorunum/gunluk_ekrani.dart';
import '../../olumlamalar/gorunum/olumlamalar_ekrani.dart';

// Günlük olumlama — tarihe göre değişir
const List<String> _gunlukOlumlamalar = [
  "Ben her gün daha güçlü ve daha huzurluyum.",
  "Kendime karşı nazik ve şefkatliyim.",
  "Zorluklarla başa çıkma gücüne sahibim.",
  "Barış ve huzur içimden geliyor.",
  "Bugün harika şeyler beni bekliyor.",
  "Her nefes yeni bir başlangıç.",
  "Sevgiye ve mutluluğa layığım.",
];

class AnaSayfaEkrani extends StatelessWidget {
  const AnaSayfaEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UygulamaRenkleri.arkaPlan,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Üst Kısım: Selamlama ve Profil
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hoş geldin Burak,",
                        style: TextStyle(
                          fontSize: 18,
                          color: UygulamaRenkleri.ikincilYaziRengi,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "Bugün nasıl hissediyorsun?",
                        style: TextStyle(
                          fontSize: 22,
                          color: UygulamaRenkleri.anaYaziRengi,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: UygulamaRenkleri.adacayiYesili,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Günün Öne Çıkanı Kartı
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1506126613408-eca07ce68773?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Günün Meditasyonu",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      Text(
                        "10 Dakika Odaklanma",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Günün Olumlamas Kartı
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OlumlamalarEkrani())),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFD1C4E9), Color(0xFFB2DFDB)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(color: const Color(0xFFB39DDB).withValues(alpha: 0.35), blurRadius: 16, offset: const Offset(0, 8)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.auto_awesome_rounded, size: 14, color: Color(0xFF5E35B1)),
                                const SizedBox(width: 6),
                                const Text(
                                  "Günün Olumlamas",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF5E35B1)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _gunlukOlumlamalar[DateTime.now().day % _gunlukOlumlamalar.length],
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF2D3142), height: 1.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.5), shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF5E35B1)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Kategoriler
              const Text(
                "Kategoriler",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _kategoriOgesi(context, "Uyku", Icons.nightlight_round, UygulamaRenkleri.yumusakLavanta, gitUyku: true),
                    _kategoriOgesi(context, "Su", Icons.water_drop_rounded, Colors.blue[100]!, gitSu: true),
                    _kategoriOgesi(context, "Odak", Icons.timer_rounded, Colors.amber[100]!, gitOdak: true),
                    _kategoriOgesi(context, "Günlük", Icons.edit_note_rounded, Colors.orange[100]!, gitGunluk: true),
                    _kategoriOgesi(context, "Nefes", Icons.air_rounded, Colors.green[100]!, gitNefes: true),
                    _kategoriOgesi(context, "Olumla", Icons.auto_awesome_rounded, const Color(0xFFE8D5F5), gitOlumla: true),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Senin İçin Seçtiklerimiz
              const Text(
                "Senin için seçtiklerimiz",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              _onerilenKart("Derin Nefes Egzersizi", "5 Dakika • Rahatlama"),
              _onerilenKart("Sabah Enerjisi", "12 Dakika • Canlanma"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kategoriOgesi(BuildContext context, String isim, IconData ikon, Color renk, {bool gitNefes = false, bool gitSu = false, bool gitUyku = false, bool gitOdak = false, bool gitGunluk = false, bool gitOlumla = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () {
          if (gitNefes) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const NefesEgzersiziEkrani()));
          } else if (gitSu) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SuTakibiEkrani()));
          } else if (gitUyku) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const UykuTakibiEkrani()));
          } else if (gitOdak) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const OdaklanmaEkrani()));
          } else if (gitGunluk) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const GunlukEkrani()));
          } else if (gitOlumla) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const OlumlamalarEkrani()));
          }
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: renk, borderRadius: BorderRadius.circular(20)),
              child: Icon(ikon, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(isim, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _onerilenKart(String baslik, String altBaslik) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: UygulamaRenkleri.kartRengi,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: UygulamaRenkleri.adacayiYesili.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.play_arrow_rounded, color: UygulamaRenkleri.adacayiYesili),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(baslik, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(altBaslik, style: TextStyle(color: UygulamaRenkleri.ikincilYaziRengi, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}
