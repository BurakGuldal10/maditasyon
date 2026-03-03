class SesModeli {
  final String id;
  final String baslik;
  final String sanatci;
  final String url;
  final String kapakResmi;
  final String sure;
  final String ruhHali;
  final String kategori;
  final bool premium;
  final int sira;

  SesModeli({
    required this.id,
    required this.baslik,
    required this.sanatci,
    required this.url,
    required this.kapakResmi,
    required this.sure,
    required this.ruhHali,
    this.kategori = 'genel',
    this.premium = false,
    this.sira = 0,
  });

  factory SesModeli.fromMap(Map<String, dynamic> map, String id) {
    return SesModeli(
      id: id,
      baslik: map['baslik'] ?? '',
      sanatci: map['sanatci'] ?? '',
      url: map['url'] ?? '',
      kapakResmi: map['kapakResmi'] ?? '',
      sure: map['sure'] ?? '',
      ruhHali: map['ruhHali'] ?? 'Genel',
      kategori: map['kategori'] ?? 'genel',
      premium: map['premium'] ?? false,
      sira: (map['sira'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'baslik': baslik,
      'sanatci': sanatci,
      'url': url,
      'kapakResmi': kapakResmi,
      'sure': sure,
      'ruhHali': ruhHali,
      'kategori': kategori,
      'premium': premium,
      'sira': sira,
    };
  }
}
