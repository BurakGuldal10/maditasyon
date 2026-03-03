import 'package:flutter/material.dart';
import '../../../cekirdek/sabitler/renkler.dart';

class GunlukEkrani extends StatefulWidget {
  const GunlukEkrani({super.key});

  @override
  State<GunlukEkrani> createState() => _GunlukEkraniState();
}

class _GunlukEkraniState extends State<GunlukEkrani> {
  String _selectedMood = "";
  final TextEditingController _noteController = TextEditingController();

  final List<Map<String, dynamic>> _moods = [
    {"emoji": "😊", "label": "Mutlu"},
    {"emoji": "😌", "label": "Huzurlu"},
    {"emoji": "😐", "label": "Normal"},
    {"emoji": "😔", "label": "Üzgün"},
    {"emoji": "🤯", "label": "Stresli"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UygulamaRenkleri.arkaPlan,
      appBar: AppBar(
        title: const Text("Zihin Günlüğü", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bugün nasıl hissediyorsun?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UygulamaRenkleri.anaYaziRengi),
            ),
            const SizedBox(height: 20),
            
            // Mood Seçici
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _moods.map((mood) {
                bool isSelected = _selectedMood == mood["label"];
                return GestureDetector(
                  onTap: () => setState(() => _selectedMood = mood["label"]),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? UygulamaRenkleri.adacayiYesili : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                          ],
                        ),
                        child: Text(mood["emoji"], style: const TextStyle(fontSize: 24)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mood["label"],
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? UygulamaRenkleri.adacayiYesili : UygulamaRenkleri.ikincilYaziRengi,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 40),
            const Text(
              "Neler düşünüyorsun?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UygulamaRenkleri.anaYaziRengi),
            ),
            const SizedBox(height: 15),
            
            // Not Giriş Alanı
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                ],
              ),
              child: TextField(
                controller: _noteController,
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: "Buraya yazmaya başla...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Kaydet Butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Kaydetme mantığı buraya gelecek
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Günlüğün kaydedildi ✨")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: UygulamaRenkleri.adacayiYesili,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("Günlüğü Kaydet", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
