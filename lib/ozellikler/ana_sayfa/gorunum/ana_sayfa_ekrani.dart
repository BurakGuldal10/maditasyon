import 'package:flutter/material.dart';
import '../../../cekirdek/sabitler/renkler.dart';

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
                    _kategoriOgesi("Uyku", Icons.nightlight_round, UygulamaRenkleri.yumusakLavanta),
                    _kategoriOgesi("Stres", Icons.psychology, Colors.orange[100]!),
                    _kategoriOgesi("Odak", Icons.center_focus_strong, UygulamaRenkleri.gokyuzuMavisi.withOpacity(0.3)),
                    _kategoriOgesi("Yürüyüş", Icons.directions_walk, Colors.green[100]!),
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

  Widget _kategoriOgesi(String isim, IconData ikon, Color renk) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
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
