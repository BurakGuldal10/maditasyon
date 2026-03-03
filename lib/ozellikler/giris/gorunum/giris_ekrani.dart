import 'package:flutter/material.dart';
import '../../../cekirdek/sabitler/renkler.dart';
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
      backgroundColor: UygulamaRenkleri.arkaPlan,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Logo / İkon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: UygulamaRenkleri.adacayiYesili.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.self_improvement_rounded,
                  size: 52,
                  color: UygulamaRenkleri.adacayiYesili,
                ),
              ),
              const SizedBox(height: 28),
              // Başlık
              const Text(
                'Hoş Geldin',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: UygulamaRenkleri.anaYaziRengi,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'İç huzurunu bulmak için\nyolculuğuna devam et',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: UygulamaRenkleri.ikincilYaziRengi,
                ),
              ),
              const Spacer(flex: 2),
              // Google Giriş Butonu
              _yukleniyor
                  ? const CircularProgressIndicator(
                      color: UygulamaRenkleri.adacayiYesili,
                    )
                  : _googleGirisButonu(),
              const SizedBox(height: 24),
              const Text(
                'Giriş yaparak Gizlilik Politikası\'nı\nve Kullanım Koşulları\'nı kabul etmiş olursunuz.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: UygulamaRenkleri.ikincilYaziRengi,
                  height: 1.5,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _googleGirisButonu() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: _googleIleGiris,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFDDDDDD)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://www.google.com/favicon.ico',
              width: 22,
              height: 22,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.g_mobiledata_rounded,
                size: 26,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Google ile Devam Et',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: UygulamaRenkleri.anaYaziRengi,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
