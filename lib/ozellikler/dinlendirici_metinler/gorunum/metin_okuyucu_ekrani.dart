import 'package:flutter/material.dart';
import 'dinlendirici_metinler_ekrani.dart';

class MetinOkuyucuEkrani extends StatelessWidget {
  final DinlendiriciMetin metin;

  const MetinOkuyucuEkrani({super.key, required this.metin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Renkli başlık alanı
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: metin.renk,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: metin.renk,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(metin.ikon, size: 13, color: Colors.white),
                              const SizedBox(width: 5),
                              Text(
                                metin.kategori,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          metin.baslik,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.schedule_rounded, size: 14, color: Colors.white70),
                            const SizedBox(width: 4),
                            Text(
                              '${metin.sure} okuma',
                              style: const TextStyle(color: Colors.white70, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Metin içeriği
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Büyük tırnak dekoratif
                  Text(
                    '"',
                    style: TextStyle(
                      fontSize: 64,
                      height: 0.8,
                      color: metin.renk.withValues(alpha: 0.15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Metin içeriği — paragraf paragraf
                  ...metin.icerik.split('\n\n').map(
                    (paragraf) => Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Text(
                        paragraf.trim(),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.75,
                          color: Color(0xFF334155),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Alt ayırıcı + ikon
                  Center(
                    child: Icon(
                      metin.ikon,
                      size: 32,
                      color: metin.renk.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
