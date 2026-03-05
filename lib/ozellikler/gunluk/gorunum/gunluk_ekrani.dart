import 'package:flutter/material.dart';
import '../../../cekirdek/servisler/yerel_depo_servisi.dart';
import '../../../veri/modeller/gunluk_modeli.dart';

class GunlukEkrani extends StatefulWidget {
  const GunlukEkrani({super.key});

  @override
  State<GunlukEkrani> createState() => _GunlukEkraniState();
}

class _GunlukEkraniState extends State<GunlukEkrani> {
  String _selectedMood = "";
  final TextEditingController _noteController = TextEditingController();
  final YerelDepoServisi _depo = YerelDepoServisi();
  List<GunlukKaydi> _gecmisKayitlar = [];

  static const Color _teal = Color(0xFF0D9488);
  static const Color _bg = Color(0xFFFAF7F2);

  final List<Map<String, dynamic>> _moods = [
    {"emoji": "😊", "label": "Mutlu",   "renk": Color(0xFFF59E0B)},
    {"emoji": "😌", "label": "Huzurlu", "renk": Color(0xFF0D9488)},
    {"emoji": "😐", "label": "Normal",  "renk": Color(0xFF78716C)},
    {"emoji": "😔", "label": "Üzgün",   "renk": Color(0xFF8D6E63)},
    {"emoji": "🤯", "label": "Stresli", "renk": Color(0xFFF97316)},
  ];

  @override
  void initState() {
    super.initState();
    _kayitlariYukle();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _kayitlariYukle() async {
    final kayitlar = await _depo.gunlukKayitlariniGetir();
    if (mounted) setState(() => _gecmisKayitlar = kayitlar);
  }

  Future<void> _kaydet() async {
    if (_selectedMood.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen ruh halini seç 🌟")),
      );
      return;
    }

    final kayit = GunlukKaydi(
      tarih: DateTime.now(),
      ruhHali: _selectedMood,
      not: _noteController.text,
    );

    await _depo.gunlukKaydiEkle(kayit);

    if (mounted) {
      setState(() {
        _gecmisKayitlar.insert(0, kayit);
        _selectedMood = "";
        _noteController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Günlüğün kaydedildi ✨")),
      );
    }
  }

  Color _moodRengi(String label) {
    return (_moods.firstWhere(
      (m) => m["label"] == label,
      orElse: () => {"renk": _teal},
    )["renk"]) as Color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text(
          "Zihin Günlüğü",
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1C1917)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1C1917)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bugün nasıl hissediyorsun?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1C1917)),
            ),
            const SizedBox(height: 20),

            // Mood Seçici
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _moods.map((mood) {
                final isSelected = _selectedMood == mood["label"];
                final renk = mood["renk"] as Color;
                return GestureDetector(
                  onTap: () => setState(() => _selectedMood = mood["label"] as String),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? renk : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? renk : const Color(0xFFE7E5E4),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected ? renk.withOpacity(0.3) : Colors.black.withOpacity(0.05),
                              blurRadius: isSelected ? 12 : 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(mood["emoji"] as String, style: const TextStyle(fontSize: 24)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mood["label"] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? renk : const Color(0xFF78716C),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 35),

            const Text(
              "Neler düşünüyorsun?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1C1917)),
            ),
            const SizedBox(height: 15),

            // Not Giriş Alanı
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE7E5E4)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
                ],
              ),
              child: TextField(
                controller: _noteController,
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: "Buraya yazmaya başla...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Color(0xFFB9B2AB)),
                ),
                style: const TextStyle(color: Color(0xFF292524), height: 1.5),
              ),
            ),

            const SizedBox(height: 25),

            // Kaydet Butonu
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: _kaydet,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: _teal,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _teal.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Günlüğü Kaydet",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),

            // Geçmiş Kayıtlar
            if (_gecmisKayitlar.isNotEmpty) ...[
              const SizedBox(height: 40),
              const Text(
                "Geçmiş Kayıtlar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1C1917)),
              ),
              const SizedBox(height: 15),
              ..._gecmisKayitlar.map((kayit) => _gecmisKayitKarti(kayit)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _gecmisKayitKarti(GunlukKaydi kayit) {
    final moodEmoji = (_moods.firstWhere(
      (m) => m["label"] == kayit.ruhHali,
      orElse: () => {"emoji": "📝", "label": kayit.ruhHali},
    )["emoji"]) as String;

    final tarihStr =
        "${kayit.tarih.day.toString().padLeft(2, '0')}.${kayit.tarih.month.toString().padLeft(2, '0')}.${kayit.tarih.year}";

    final renk = _moodRengi(kayit.ruhHali);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: renk, width: 4)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: renk.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(moodEmoji, style: const TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  kayit.ruhHali,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: renk),
                ),
                const Spacer(),
                Text(
                  tarihStr,
                  style: const TextStyle(color: Color(0xFFB9B2AB), fontSize: 12),
                ),
              ],
            ),
            if (kayit.not.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                kayit.not,
                style: const TextStyle(color: Color(0xFF57534E), fontSize: 13, height: 1.5),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
