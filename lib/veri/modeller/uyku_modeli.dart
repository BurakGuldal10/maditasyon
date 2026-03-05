/// Bir gecelik uyku kaydını temsil eden model
class UykuKaydi {
  final DateTime tarih;
  final String yatisSaati;
  final String uyanmaSaati;
  final Duration uykuSuresi;
  final int kalitePuani; // 1-5 arası
  final String? not;

  UykuKaydi({
    required this.tarih,
    required this.yatisSaati,
    required this.uyanmaSaati,
    required this.uykuSuresi,
    required this.kalitePuani,
    this.not,
  });

  Map<String, dynamic> toJson() => {
        'tarih': tarih.toIso8601String(),
        'yatisSaati': yatisSaati,
        'uyanmaSaati': uyanmaSaati,
        'uykuSuresiDakika': uykuSuresi.inMinutes,
        'kalitePuani': kalitePuani,
        'not': not,
      };

  factory UykuKaydi.fromJson(Map<String, dynamic> json) => UykuKaydi(
        tarih: DateTime.parse(json['tarih'] as String),
        yatisSaati: json['yatisSaati'] as String,
        uyanmaSaati: json['uyanmaSaati'] as String,
        uykuSuresi: Duration(minutes: json['uykuSuresiDakika'] as int),
        kalitePuani: json['kalitePuani'] as int,
        not: json['not'] as String?,
      );

  /// Saat ve dakikayı "X sa Y dk" formatında döndürür
  String get sureBilgisi {
    final saat = uykuSuresi.inHours;
    final dakika = uykuSuresi.inMinutes % 60;
    return "$saat sa $dakika dk";
  }

  /// Kalite puanını metin olarak döndürür
  String get kaliteMetni {
    switch (kalitePuani) {
      case 1:
        return "Çok Kötü";
      case 2:
        return "Kötü";
      case 3:
        return "Normal";
      case 4:
        return "İyi";
      case 5:
        return "Mükemmel";
      default:
        return "Bilinmiyor";
    }
  }
}
