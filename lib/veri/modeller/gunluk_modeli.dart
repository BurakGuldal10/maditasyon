class GunlukKaydi {
  final DateTime tarih;
  final String ruhHali;
  final String not;

  GunlukKaydi({
    required this.tarih,
    required this.ruhHali,
    required this.not,
  });

  Map<String, dynamic> toJson() => {
        'tarih': tarih.toIso8601String(),
        'ruhHali': ruhHali,
        'not': not,
      };

  factory GunlukKaydi.fromJson(Map<String, dynamic> json) => GunlukKaydi(
        tarih: DateTime.parse(json['tarih'] as String),
        ruhHali: json['ruhHali'] as String? ?? '',
        not: json['not'] as String? ?? '',
      );
}
