import 'package:flutter/material.dart';
import '../../../cekirdek/sabitler/renkler.dart';
import 'ana_sayfa_ekrani.dart';
import '../../profil/profil_ekrani.dart';

class AnaYapi extends StatefulWidget {
  const AnaYapi({super.key});

  @override
  State<AnaYapi> createState() => _AnaYapiState();
}

class _AnaYapiState extends State<AnaYapi> {
  int _seciliIndeks = 0;

  // Ekran listesi
  final List<Widget> _ekranlar = [
    const AnaSayfaEkrani(),
    const Center(child: Text("Oynatıcı Gelecek")), // Geçici yer tutucu
    const ProfilEkrani(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ekranlar[_seciliIndeks],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _seciliIndeks,
          onTap: (index) {
            setState(() {
              _seciliIndeks = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: UygulamaRenkleri.adacayiYesili,
          unselectedItemColor: UygulamaRenkleri.ikincilYaziRengi,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Keşfet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_fill_rounded, size: 40),
              label: 'Oynat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
