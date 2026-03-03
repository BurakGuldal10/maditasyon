import 'package:flutter/material.dart';
import '../../../cekirdek/servisler/auth_servisi.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  final AuthServisi _authServisi = AuthServisi();
  bool _yukleniyor = false;

  Future<void> _googleIleGiris() async {
    setState(() => _yukleniyor = true);
    try {
      await _authServisi.googleIleGiris();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Giriş başarısız: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _yukleniyor = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFC8E6D8), // mint yeşil
              Color(0xFFDDD6F0), // lavanta
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                // Üst boşluk + Lotus ikon alanı
                const Spacer(flex: 3),
                _lotusIkon(),
                const Spacer(flex: 2),

                // Başlık
                const Text(
                  'Huzura',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF2D3142),
                    letterSpacing: 1.2,
                  ),
                ),
                const Text(
                  'Hoş Geldiniz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF2D3142),
                    letterSpacing: 1.2,
                  ),
                ),

                const Spacer(flex: 3),

                // Butonlar
                if (_yukleniyor)
                  const CircularProgressIndicator(color: Color(0xFF2D3142))
                else ...[
                  _googleButonu(),
                  const SizedBox(height: 14),
                  _appleButonu(),
                ],

                const SizedBox(height: 24),

                // Alt yazı
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7080),
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(text: 'Giriş yaparak '),
                      TextSpan(
                        text: 'Kullanım Koşulları',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xFF4A5568),
                        ),
                      ),
                      TextSpan(text: '\'nı kabul\netmiş sayılırsınız.'),
                    ],
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _lotusIkon() {
    return SizedBox(
      width: 160,
      height: 160,
      child: CustomPaint(
        painter: _LotusPainter(),
      ),
    );
  }

  Widget _googleButonu() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: _googleIleGiris,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFDDDDDD)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg',
              width: 20,
              height: 20,
              errorBuilder: (_, __, ___) => const Text(
                'G',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4285F4),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Google ile Devam Et',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2D3142),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appleButonu() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A1A1A),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.apple, size: 22, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Apple ile Devam Et',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LotusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.75)
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Merkez yaprak
    _yaprakCiz(canvas, paint, cx, cy, 0, size);
    // Sol yapraklar
    _yaprakCiz(canvas, paint, cx, cy, -35, size);
    _yaprakCiz(canvas, paint, cx, cy, -65, size);
    // Sağ yapraklar
    _yaprakCiz(canvas, paint, cx, cy, 35, size);
    _yaprakCiz(canvas, paint, cx, cy, 65, size);

    // Alt gövde
    final govdePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    final govdePath = Path();
    govdePath.moveTo(cx - size.width * 0.08, cy + size.height * 0.28);
    govdePath.quadraticBezierTo(cx, cy + size.height * 0.38, cx + size.width * 0.08, cy + size.height * 0.28);
    govdePath.quadraticBezierTo(cx, cy + size.height * 0.22, cx - size.width * 0.08, cy + size.height * 0.28);
    canvas.drawPath(govdePath, govdePaint);
  }

  void _yaprakCiz(Canvas canvas, Paint paint, double cx, double cy, double aciDerece, Size size) {
    final aci = aciDerece * 3.14159 / 180;
    canvas.save();
    canvas.translate(cx, cy + size.height * 0.1);
    canvas.rotate(aci);

    final yaprak = Path();
    final h = size.height * 0.38;
    final w = size.width * 0.12;
    yaprak.moveTo(0, 0);
    yaprak.cubicTo(-w, -h * 0.4, -w * 0.8, -h * 0.8, 0, -h);
    yaprak.cubicTo(w * 0.8, -h * 0.8, w, -h * 0.4, 0, 0);
    canvas.drawPath(yaprak, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
