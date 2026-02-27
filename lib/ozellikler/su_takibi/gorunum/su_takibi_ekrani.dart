import 'package:flutter/material.dart';
import '../../../cekirdek/sabitler/renkler.dart';

class SuTakibiEkrani extends StatefulWidget {
  const SuTakibiEkrani({super.key});

  @override
  State<SuTakibiEkrani> createState() => _SuTakibiEkraniState();
}

class _SuTakibiEkraniState extends State<SuTakibiEkrani> {
  int _toplamSu = 0;
  int _hedefSu = 2000; // Varsayılan hedef
  final TextEditingController _hedefController = TextEditingController();

  void _suEkle(int miktar) {
    setState(() {
      _toplamSu += miktar;
    });
    
    if (_toplamSu >= _hedefSu) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tebrikler! Günlük su hedefine ulaştın. 💧"),
          backgroundColor: Colors.blueAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _hedefGuncelle() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Günlük Hedefi Belirle"),
        content: TextField(
          controller: _hedefController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "Örn: 2500",
            suffixText: "ml",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("İptal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_hedefController.text.isNotEmpty) {
                setState(() {
                  _hedefSu = int.parse(_hedefController.text);
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Güncelle"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double yuzde = (_toplamSu / _hedefSu).clamp(0.0, 1.1); // Biraz taşma payı için 1.1

    return Scaffold(
      backgroundColor: UygulamaRenkleri.arkaPlan,
      appBar: AppBar(
        title: const Text("Su Takibi", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.blueGrey),
            onPressed: _hedefGuncelle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // İlerleme Özeti
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _istatistikOgesi("İçilen", "$_toplamSu ml", Colors.blue),
                    _istatistikOgesi("Hedef", "$_hedefSu ml", Colors.grey),
                    _istatistikOgesi("Kalan", "${(_hedefSu - _toplamSu).clamp(0, _hedefSu)} ml", Colors.orange),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // Büyük Su Bardağı Görseli
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Boş Bardak Çerçevesi
                  Container(
                    width: 160,
                    height: 240,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.withOpacity(0.2), width: 6),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  // Dolu Su Kısmı
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutBack,
                    width: 150,
                    height: 230 * (yuzde > 1.0 ? 1.0 : yuzde),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue[300]!, Colors.blue[600]!],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                  ),
                  // Yüzde Yazısı
                  Positioned(
                    top: 100,
                    child: Column(
                      children: [
                        Text(
                          "%${(yuzde * 100).toInt()}",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: yuzde > 0.5 ? Colors.white : Colors.blueGrey,
                          ),
                        ),
                        Text(
                          "Tamamlandı",
                          style: TextStyle(
                            fontSize: 12,
                            color: yuzde > 0.5 ? Colors.white70 : Colors.blueGrey.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),

              // Su Ekleme Butonları
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _hizliEkleButonu(200, Icons.local_drink_outlined, "Bardak"),
                  _hizliEkleButonu(500, Icons.water_drop_outlined, "Şişe"),
                  _hizliEkleButonu(1000, Icons.opacity_rounded, "Sürahi"),
                ],
              ),
              const SizedBox(height: 40),
              
              // Sıfırla Butonu
              TextButton(
                onPressed: () => setState(() => _toplamSu = 0),
                child: Text(
                  "Bugünü Sıfırla",
                  style: TextStyle(color: Colors.red[300], fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _istatistikOgesi(String baslik, String deger, Color renk) {
    return Column(
      children: [
        Text(baslik, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        const SizedBox(height: 5),
        Text(deger, style: TextStyle(color: renk, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _hizliEkleButonu(int miktar, IconData ikon, String etiket) {
    return GestureDetector(
      onTap: () => _suEkle(miktar),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue[100]!),
            ),
            child: Icon(ikon, color: Colors.blue[700], size: 30),
          ),
          const SizedBox(height: 8),
          Text("$miktar ml", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(etiket, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
        ],
      ),
    );
  }
}
