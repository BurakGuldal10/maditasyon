import 'package:flutter/material.dart';
import 'ozellikler/ana_sayfa/gorunum/ana_yapi.dart';

void main() {
  runApp(const MaditasyonUygulamasi());
}

class MaditasyonUygulamasi extends StatelessWidget {
  const MaditasyonUygulamasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maditasyon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Montserrat',
      ),
      home: const AnaYapi(),
    );
  }
}
