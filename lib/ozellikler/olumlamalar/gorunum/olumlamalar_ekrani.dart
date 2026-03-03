import 'dart:math';
import 'package:flutter/material.dart';
import '../../../cekirdek/sabitler/renkler.dart';

const List<Map<String, dynamic>> _olumlamalar = [
  {"metin": "Ben her gün daha güçlü ve daha huzurluyum.", "renk": [0xFFB2DFDB, 0xFF80CBC4]},
  {"metin": "Kendime karşı nazik ve şefkatliyim.", "renk": [0xFFCE93D8, 0xFFBA68C8]},
  {"metin": "Hayatım güzelliklerle dolu ve bunun için şükranla doluyum.", "renk": [0xFFFFF9C4, 0xFFFFF176]},
  {"metin": "Zorluklarla başa çıkma gücüne sahibim.", "renk": [0xFFB3E5FC, 0xFF81D4FA]},
  {"metin": "Kendimi olduğum gibi kabul ediyorum.", "renk": [0xFFC8E6C9, 0xFFA5D6A7]},
  {"metin": "Barış ve huzur içimden geliyor.", "renk": [0xFFFFCCBC, 0xFFFFAB91]},
  {"metin": "Her nefes aldığımda sakinleşiyor ve rahatıyorum.", "renk": [0xFFD1C4E9, 0xFFB39DDB]},
  {"metin": "Sevgiye ve mutluluğa layığım.", "renk": [0xFFF8BBD0, 0xFFF48FB1]},
  {"metin": "Bugün harika şeyler beni bekliyor.", "renk": [0xFFDCEDC8, 0xFFC5E1A5]},
  {"metin": "Düşüncelerim sakin, kalbim huzurlu.", "renk": [0xFFB2EBF2, 0xFF80DEEA]},
  {"metin": "Her adımda kendime güveniyorum.", "renk": [0xFFFFE0B2, 0xFFFFCC80]},
  {"metin": "Geçmişi bırakıyor, şimdiye odaklanıyorum.", "renk": [0xFFE8EAF6, 0xFFC5CAE9]},
  {"metin": "İçimde sonsuz bir huzur kaynağı var.", "renk": [0xFFE0F2F1, 0xFFB2DFDB]},
  {"metin": "Hayatın her anı bana öğretecek bir şey sunuyor.", "renk": [0xFFF3E5F5, 0xFFE1BEE7]},
  {"metin": "Sağlıklı, mutlu ve enerjik hissediyorum.", "renk": [0xFFE8F5E9, 0xFFC8E6C9]},
  {"metin": "Zihinim berrak, ruhum aydınlık.", "renk": [0xFFE1F5FE, 0xFFB3E5FC]},
  {"metin": "Sevgi vermeye ve almaya açığım.", "renk": [0xFFFCE4EC, 0xFFF8BBD0]},
  {"metin": "Her güne yeni bir umutla başlıyorum.", "renk": [0xFFFFFDE7, 0xFFFFF9C4]},
  {"metin": "Kendime inanıyorum ve her şeyi başarabiliyorum.", "renk": [0xFFEDE7F6, 0xFFD1C4E9]},
  {"metin": "Bedenime iyi bakıyor, onu seviyorum.", "renk": [0xFFE8F5E9, 0xFFA5D6A7]},
  {"metin": "Korkularım beni durduramaz, cesur ilerliyorum.", "renk": [0xFFE3F2FD, 0xFFBBDEFB]},
  {"metin": "Bu an mükemmel, tam buradayım.", "renk": [0xFFE8EAF6, 0xFFB3E5FC]},
  {"metin": "Hayallerim gerçekleşmeye değer ve onların peşinden gidiyorum.", "renk": [0xFFFFF3E0, 0xFFFFE0B2]},
  {"metin": "Minnettarlık kalbimi büyütüyor.", "renk": [0xFFF9FBE7, 0xFFF0F4C3]},
  {"metin": "Her şeyin üstesinden gelebiliyorum.", "renk": [0xFFE0F7FA, 0xFFB2EBF2]},
  {"metin": "İçimdeki huzur dışarıya yansıyor.", "renk": [0xFFEDE7F6, 0xFFCE93D8]},
  {"metin": "Bugün en iyi versiyonum oluyorum.", "renk": [0xFFE8F5E9, 0xFF80CBC4]},
  {"metin": "Sevilmeye ve mutlu olmaya layığım.", "renk": [0xFFFCE4EC, 0xFFEF9A9A]},
  {"metin": "Negatif düşünceler beni tanımlamaz, ben seçiyorum.", "renk": [0xFFE8EAF6, 0xFF9FA8DA]},
  {"metin": "Her nefes yeni bir başlangıç.", "renk": [0xFFE0F2F1, 0xFF80CBC4]},
];

class OlumlamalarEkrani extends StatefulWidget {
  const OlumlamalarEkrani({super.key});

  @override
  State<OlumlamalarEkrani> createState() => _OlumlamalarEkraniState();
}

class _OlumlamalarEkraniState extends State<OlumlamalarEkrani> {
  late PageController _pageController;
  int _mevcutIndeks = 0;

  @override
  void initState() {
    super.initState();
    // Günün olumlama indeksini tarihe göre seç (her gün farklı)
    final gunIndeks = DateTime.now().day % _olumlamalar.length;
    _mevcutIndeks = gunIndeks;
    _pageController = PageController(initialPage: gunIndeks, viewportFraction: 0.88);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UygulamaRenkleri.arkaPlan,
      appBar: AppBar(
        title: const Text("Olumlamalar", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle_rounded),
            onPressed: _rastgeleGit,
            tooltip: 'Rastgele',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              "Bugün kendine hatırlat",
              style: TextStyle(
                fontSize: 15,
                color: UygulamaRenkleri.ikincilYaziRengi,
              ),
            ),
          ),

          // Kart sayacı
          Text(
            "${_mevcutIndeks + 1} / ${_olumlamalar.length}",
            style: TextStyle(
              fontSize: 13,
              color: UygulamaRenkleri.ikincilYaziRengi,
            ),
          ),
          const SizedBox(height: 12),

          // Kaydırılabilir kartlar
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _olumlamalar.length,
              onPageChanged: (i) => setState(() => _mevcutIndeks = i),
              itemBuilder: (context, index) {
                final olumlama = _olumlamalar[index];
                final renkler = (olumlama["renk"] as List).map((c) => Color(c as int)).toList();
                final secili = index == _mevcutIndeks;

                return AnimatedScale(
                  scale: secili ? 1.0 : 0.92,
                  duration: const Duration(milliseconds: 300),
                  child: _OlumlamaKarti(
                    metin: olumlama["metin"] as String,
                    renkler: renkler,
                    indeks: index,
                  ),
                );
              },
            ),
          ),

          // İleri / Geri butonlar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _NavButon(
                  ikon: Icons.arrow_back_ios_rounded,
                  onTap: _mevcutIndeks > 0 ? _oncekiGit : null,
                ),
                // Nokta göstergesi
                Row(
                  children: List.generate(
                    min(_olumlamalar.length, 5),
                    (i) {
                      final aktif = i == (_mevcutIndeks % 5);
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: aktif ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: aktif
                              ? UygulamaRenkleri.adacayiYesili
                              : UygulamaRenkleri.ikincilYaziRengi.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    },
                  ),
                ),
                _NavButon(
                  ikon: Icons.arrow_forward_ios_rounded,
                  onTap: _mevcutIndeks < _olumlamalar.length - 1 ? _sonrakiGit : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sonrakiGit() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _oncekiGit() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _rastgeleGit() {
    final rastgele = Random().nextInt(_olumlamalar.length);
    _pageController.animateToPage(
      rastgele,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

class _OlumlamaKarti extends StatelessWidget {
  final String metin;
  final List<Color> renkler;
  final int indeks;

  const _OlumlamaKarti({
    required this.metin,
    required this.renkler,
    required this.indeks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: renkler,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: renkler.last.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Süsleyici büyük tırnak işareti
          Positioned(
            top: 24,
            left: 28,
            child: Text(
              '"',
              style: TextStyle(
                fontSize: 100,
                height: 0.8,
                color: Colors.white.withValues(alpha: 0.3),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Olumlama metni
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 60),
              child: Text(
                metin,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3142),
                  height: 1.6,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
          // Alt çiçek ikonu
          Positioned(
            bottom: 28,
            right: 28,
            child: Icon(
              Icons.spa_rounded,
              size: 32,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButon extends StatelessWidget {
  final IconData ikon;
  final VoidCallback? onTap;

  const _NavButon({required this.ikon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: onTap != null ? Colors.white : Colors.white.withValues(alpha: 0.4),
          shape: BoxShape.circle,
          boxShadow: onTap != null
              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10)]
              : [],
        ),
        child: Icon(
          ikon,
          size: 18,
          color: onTap != null ? UygulamaRenkleri.anaYaziRengi : UygulamaRenkleri.ikincilYaziRengi,
        ),
      ),
    );
  }
}
