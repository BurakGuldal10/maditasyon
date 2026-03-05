import 'package:flutter/material.dart';

class SuTakibiEkrani extends StatefulWidget {
  const SuTakibiEkrani({super.key});

  @override
  State<SuTakibiEkrani> createState() => _SuTakibiEkraniState();
}

class _SuTakibiEkraniState extends State<SuTakibiEkrani> {
  int _toplamSu = 0;
  int _hedefSu = 2000;
  final TextEditingController _hedefController = TextEditingController();

  static const Color _mavi     = Color(0xFF0EA5E9);
  static const Color _derinMavi = Color(0xFF0369A1);
  static const Color _acikMavi  = Color(0xFF38BDF8);
  static const Color _bg        = Color(0xFFE0F2FE);

  void _suEkle(int miktar) {
    setState(() => _toplamSu += miktar);
    if (_toplamSu >= _hedefSu) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tebrikler! Günlük su hedefine ulaştın. 💧"),
          backgroundColor: _mavi,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _hedefGuncelle() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Günlük Hedef", style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: _hedefController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Örn: 2500",
            suffixText: "ml",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _mavi, width: 2),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("İptal", style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _mavi,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              if (_hedefController.text.isNotEmpty) {
                setState(() => _hedefSu = int.parse(_hedefController.text));
                Navigator.pop(context);
              }
            },
            child: const Text("Güncelle", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double yuzde = (_toplamSu / _hedefSu).clamp(0.0, 1.0);
    final int kalan = (_hedefSu - _toplamSu).clamp(0, _hedefSu);
    final bool tamamlandi = yuzde >= 1.0;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text(
          "Su Takibi",
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0C4A6E)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0C4A6E)),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: _hedefGuncelle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Stat kartları
            Row(
              children: [
                _statKart("İçilen", _toplamSu, _mavi),
                const SizedBox(width: 12),
                _statKart("Hedef", _hedefSu, const Color(0xFF64748B)),
                const SizedBox(width: 12),
                _statKart("Kalan", kalan, const Color(0xFFF59E0B)),
              ],
            ),

            const SizedBox(height: 40),

            // Büyük yüzde göstergesi
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${(yuzde * 100).toInt()}",
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.w900,
                      color: tamamlandi ? const Color(0xFF059669) : _derinMavi,
                      height: 1,
                    ),
                  ),
                  TextSpan(
                    text: "%",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: tamamlandi ? const Color(0xFF059669) : _mavi,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              tamamlandi ? "Hedef Tamamlandı! 🎉" : "Günlük hedefe doğru",
              style: TextStyle(
                color: tamamlandi ? const Color(0xFF059669) : const Color(0xFF64748B),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 30),

            // Bardak görseli
            _suBardagi(yuzde, tamamlandi),

            const SizedBox(height: 50),

            // Hızlı ekle butonları
            Row(
              children: [
                _ekleButonu(200, Icons.local_drink_outlined, "Bardak"),
                const SizedBox(width: 12),
                _ekleButonu(500, Icons.water_drop_outlined, "Şişe"),
                const SizedBox(width: 12),
                _ekleButonu(1000, Icons.opacity_rounded, "Sürahi"),
              ],
            ),

            const SizedBox(height: 28),

            // Sıfırla
            TextButton.icon(
              onPressed: () => setState(() => _toplamSu = 0),
              icon: const Icon(Icons.refresh_rounded, size: 18, color: Color(0xFF94A3B8)),
              label: const Text(
                "Bugünü Sıfırla",
                style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _statKart(String baslik, int deger, Color renk) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: renk.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(color: renk.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              baslik,
              style: TextStyle(color: renk, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.3),
            ),
            const SizedBox(height: 6),
            Text(
              "$deger",
              style: TextStyle(color: renk, fontSize: 22, fontWeight: FontWeight.bold, height: 1),
            ),
            Text(
              "ml",
              style: TextStyle(color: renk.withValues(alpha: 0.55), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _suBardagi(double yuzde, bool tamamlandi) {
    final Color dolguRenk = tamamlandi ? const Color(0xFF34D399) : _acikMavi;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Dış bardak çerçevesi
        Container(
          width: 150,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            border: Border.all(color: _mavi.withValues(alpha: 0.25), width: 3),
            boxShadow: [
              BoxShadow(
                color: _mavi.withValues(alpha: 0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
        ),
        // Su dolumu
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(38),
            bottomRight: Radius.circular(38),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            width: 150,
            height: 220 * yuzde,
            color: dolguRenk,
          ),
        ),
        // Damla ikonu (yüzde çizgisinde kayar)
        if (yuzde > 0.05 && yuzde < 0.97)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            bottom: (220 * yuzde) - 14,
            child: const Icon(Icons.water_drop_rounded, color: Colors.white70, size: 20),
          ),
      ],
    );
  }

  Widget _ekleButonu(int miktar, IconData ikon, String etiket) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _suEkle(miktar),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: _mavi.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: _mavi.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _mavi.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(ikon, color: _mavi, size: 24),
              ),
              const SizedBox(height: 10),
              Text(
                "$miktar ml",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF0C4A6E),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                etiket,
                style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
