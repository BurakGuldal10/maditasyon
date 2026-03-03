import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../cekirdek/sabitler/renkler.dart';
import '../../cekirdek/servisler/auth_servisi.dart';

class ProfilEkrani extends StatelessWidget {
  const ProfilEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    final User? kullanici = FirebaseAuth.instance.currentUser;
    final AuthServisi authServisi = AuthServisi();

    return Scaffold(
      backgroundColor: UygulamaRenkleri.arkaPlan,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Profilim",
          style: TextStyle(color: UygulamaRenkleri.anaYaziRengi, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: UygulamaRenkleri.ikincilYaziRengi),
            onPressed: () => _cikisOnayla(context, authServisi),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profil Özeti
            CircleAvatar(
              radius: 50,
              backgroundImage: kullanici?.photoURL != null
                  ? NetworkImage(kullanici!.photoURL!)
                  : null,
              backgroundColor: UygulamaRenkleri.adacayiYesili.withOpacity(0.2),
              child: kullanici?.photoURL == null
                  ? const Icon(
                      Icons.person_rounded,
                      size: 50,
                      color: UygulamaRenkleri.adacayiYesili,
                    )
                  : null,
            ),
            const SizedBox(height: 15),
            Text(
              kullanici?.displayName ?? 'Misafir',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: UygulamaRenkleri.anaYaziRengi,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              kullanici?.email ?? '',
              style: const TextStyle(color: UygulamaRenkleri.ikincilYaziRengi),
            ),
            const SizedBox(height: 5),
            Text(
              "Yolculuğun 12. günündesin",
              style: TextStyle(color: UygulamaRenkleri.ikincilYaziRengi),
            ),
            const SizedBox(height: 30),

            // Toplam Süre Kartı (Haftalık Özet)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: UygulamaRenkleri.adacayiYesili,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Column(
              ),
            ),
            const SizedBox(height: 30),

            // Haftalık Grafik (Basit Sütun Grafik)
            _bolumBasligi("Haftalık Aktivite"),
            const SizedBox(height: 15),
            Container(
              height: 150,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: UygulamaRenkleri.kartRengi,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _grafikCubugu("Pzt", 0.4),
                  _grafikCubugu("Sal", 0.7),
                  _grafikCubugu("Çar", 0.9),
                  _grafikCubugu("Per", 0.5),
                  _grafikCubugu("Cum", 0.8),
                  _grafikCubugu("Cmt", 0.3),
                  _grafikCubugu("Paz", 0.6),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Başarı Rozetleri
            _bolumBasligi("Başarı Rozetleri"),
            const SizedBox(height: 15),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              children: [
                _rozetOgesi("3 Günlük Seri", Icons.local_fire_department, true),
                _rozetOgesi("Gece Kuşu", Icons.dark_mode, true),
                _rozetOgesi("Farkındalık", Icons.self_improvement, false),
                _rozetOgesi("Erken Kalkan", Icons.wb_sunny, false),
                _rozetOgesi("Usta", Icons.workspace_premium, false),
                _rozetOgesi("Odaklanma", Icons.center_focus_strong, true),
              ],
            ),
            const SizedBox(height: 30),

            // Çıkış Butonu
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _cikisOnayla(context, authServisi),
                icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                label: const Text(
                  'Çıkış Yap',
                  style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cikisOnayla(BuildContext context, AuthServisi authServisi) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Çıkış Yap', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Hesabından çıkmak istediğine emin misin?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('İptal', style: TextStyle(color: UygulamaRenkleri.ikincilYaziRengi)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              authServisi.cikisYap();
            },
            child: const Text('Çıkış Yap', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  Widget _bolumBasligi(String baslik) {
    return Row(
      children: [
        Text(
          baslik,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: UygulamaRenkleri.anaYaziRengi,
          ),
        ),
      ],
    );
  }

  Widget _grafikCubugu(String gun, double yukseklikOrani) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 80 * yukseklikOrani,
          width: 12,
          decoration: BoxDecoration(
            color: UygulamaRenkleri.adacayiYesili.withOpacity(yukseklikOrani > 0.6 ? 1 : 0.4),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 8),
        Text(gun, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _rozetOgesi(String isim, IconData ikon, bool kazanildi) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: kazanildi ? UygulamaRenkleri.yumusakLavanta : Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(ikon, color: kazanildi ? UygulamaRenkleri.adacayiYesili : Colors.grey[400], size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          isim,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: kazanildi ? UygulamaRenkleri.anaYaziRengi : Colors.grey),
        ),
      ],
    );
  }
}
