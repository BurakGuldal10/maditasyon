import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ana_sayfa_ekrani.dart';
import '../../profil/profil_ekrani.dart';
import '../../oynatici/gorunum/oynatici_ekrani.dart';

class AnaYapi extends StatefulWidget {
  const AnaYapi({super.key});

  @override
  State<AnaYapi> createState() => _AnaYapiState();
}

class _AnaYapiState extends State<AnaYapi> {
  int _seciliIndeks = 0;

  final List<Widget> _ekranlar = [
    const AnaSayfaEkrani(),
    const OynaticiEkrani(),
    const ProfilEkrani(),
  ];

  static const List<_NavItem> _navItems = [
    _NavItem(
      ikon: Icons.home_rounded,
      ikonDolu: Icons.home_rounded,
      etiket: 'Keşfet',
    ),
    _NavItem(
      ikon: Icons.play_circle_outline_rounded,
      ikonDolu: Icons.play_circle_fill_rounded,
      etiket: 'Oynat',
    ),
    _NavItem(
      ikon: Icons.person_outline_rounded,
      ikonDolu: Icons.person_rounded,
      etiket: 'Profil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _ekranlar[_seciliIndeks],
      bottomNavigationBar: _modernNavBar(),
    );
  }

  Widget _modernNavBar() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: const Color(0xFF0A1A0A).withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_navItems.length, (i) => _navButon(i)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navButon(int index) {
    final bool secili = _seciliIndeks == index;
    final item = _navItems[index];
    // Orta buton (Oynat) biraz daha büyük
    final bool ortaButon = index == 1;

    return GestureDetector(
      onTap: () {
        if (_seciliIndeks != index) {
          HapticFeedback.lightImpact();
          setState(() => _seciliIndeks = index);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: secili ? 18 : 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: secili
              ? const Color(0xFF10B981).withValues(alpha: 0.18)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: secili ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              child: Icon(
                secili ? item.ikonDolu : item.ikon,
                color: secili
                    ? const Color(0xFF34D399)
                    : Colors.white.withValues(alpha: 0.45),
                size: ortaButon ? 30 : 24,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                color: secili
                    ? const Color(0xFF34D399)
                    : Colors.white.withValues(alpha: 0.40),
                fontSize: secili ? 11 : 10,
                fontWeight: secili ? FontWeight.w700 : FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
              child: Text(item.etiket),
            ),
            // Aktif gösterge çizgisi
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.only(top: 4),
              height: 2.5,
              width: secili ? 18 : 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: secili
                    ? const LinearGradient(
                        colors: [Color(0xFF10B981), Color(0xFF34D399)],
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData ikon;
  final IconData ikonDolu;
  final String etiket;

  const _NavItem({
    required this.ikon,
    required this.ikonDolu,
    required this.etiket,
  });
}
