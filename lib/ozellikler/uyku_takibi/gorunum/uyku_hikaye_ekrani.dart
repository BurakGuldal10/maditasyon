import 'package:flutter/material.dart';
import '../../../cekirdek/sabitler/renkler.dart';

class UykuHikaye {
  final String baslik;
  final String kisaAciklama;
  final String icerik;
  final String sure;
  final IconData ikon;
  final List<Color> renkler;

  const UykuHikaye({
    required this.baslik,
    required this.kisaAciklama,
    required this.icerik,
    required this.sure,
    required this.ikon,
    required this.renkler,
  });
}

const List<UykuHikaye> uykuHikayeleri = [
  UykuHikaye(
    baslik: "Orman Gezisi",
    kisaAciklama: "Huzur veren bir ormanda yürüyüş...",
    sure: "5 dk",
    ikon: Icons.forest_rounded,
    renkler: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
    icerik: """Gözlerini yavaşça kapat. Derin bir nefes al... ve bırak.

Şimdi kendini yumuşak bir orman yolunda hayal et. Ayaklarının altında yaş yaprakların sesi duyuluyor. Sabahın ilk ışıkları ağaçların arasından süzülüyor ve yüzüne değiyor.

Hava serindir. Temizdir. Her nefes aldığında ormanın taze kokusunu içine çekiyorsun — çam iğneleri, toprak ve yağmur sonrasının kokusu...

Yürüdükçe ağaçlar seni kucaklıyor. Uzaktan bir derenin sesi geliyor. Suların taşların üzerinden süzülüşü... tın tın tın...

Yolun kenarında küçük bir kaya var. Ona oturuyorsun. Sırtını kalın bir meşe ağacına yaslatıyorsun. Ağaç seni taşıyor, destekliyor.

Bir kuş ötüyor uzakta. Sonra sessizlik.

Sadece nefes. Sadece orman. Sadece şu an.

Gözlerin ağırlaşıyor. Vücudun kayayla bütünleşiyor. Her nefeste biraz daha derine, biraz daha içeriye dalıyorsun...

Orman seni sarıyor. Güvendesin. Huzurdasın. Uykuya dalmak için tam vaktinde...
""",
  ),
  UykuHikaye(
    baslik: "Yıldızlı Gece",
    kisaAciklama: "Sonsuz gökyüzünde bir yolculuk...",
    sure: "6 dk",
    ikon: Icons.star_rounded,
    renkler: [Color(0xFF1A237E), Color(0xFF0D1B4B)],
    icerik: """Nefes al... ve bırak. Omuzlarındaki tüm gerilimi yere bırak.

Kendini geniş, ıssız bir çayırda uzanmış hayal et. Üzerinde kalın, yumuşak bir battaniye var. Zemin düz ve sıcak.

Yukarıya bakıyorsun. Gökyüzü sonsuz, koyu lacivert. Ve yıldızlar...

Sayamayacağın kadar çok yıldız. Her biri farklı bir parlaklıkta. Kimileri sabit, kimileri titrek.

Bir yıldız kayıyor. Gözlerin peşinden gidiyor, sonra kayboluyor.

Kayış içinde yüzüyor gibisin. Yerçekimi azalıyor sanki. Vücudun yere gömülüyor — ağır değil, huzurlu bir ağırlık bu.

Gökyüzünde büyük ayı takım yıldızını buluyorsun. Sonra küçük ayıyı. Kutup yıldızı sabit duruyor, her zaman orada, her zaman bekliyor.

Gözlerin kapanıyor. Yıldızlar hâlâ orada, kapıların arkasında da parlıyorlar.

Evrende küçük ama değerli bir noktasın. Güvendesin. Korunuyorsun.

Sessizce, yavaşça... uykuya dalıyorsun.
""",
  ),
  UykuHikaye(
    baslik: "Deniz Kıyısı",
    kisaAciklama: "Dalgaların sesine kapıl...",
    sure: "5 dk",
    ikon: Icons.waves_rounded,
    renkler: [Color(0xFF006064), Color(0xFF00363A)],
    icerik: """Gözleri kapat. Derin bir nefes al, burnundan... ağzından yavaşça ver.

Kendini kumlu bir sahilde hayal et. Gece vakti. Ay denizin üzerinde parlıyor, gümüşi bir iz bırakıyor.

Ayaklarının altında ince, sıcak kum var. Parmakların arasından geçiyor. Her adımda battıkça çıkıyor.

Denizin sesini duy. Dalga geliyor... kıyıya vuruyor... çekiliyor. Geliyor... vuruyor... çekiliyor.

Bu ritim nefesine benziyor. Sen nefes alırken dalga geliyor. Sen verirken çekiliyor.

Islak kuma oturuyorsun. Soğuk değil — tam tersine, deniz seni serinletiyor. Tuz kokusu burnunu dolduruyor.

Bir dalga ayak parmaklarını ıslatıyor. Sonra çekiliyor. Bir daha geliyor. Bir daha...

Vücudun kuma gömülüyor. Deniz seni sallıyor, bir beşik gibi. İleri... geri... ileri... geri...

Gözlerin kapanıyor. Dalgaların sesi uzaklaşıyor ama hâlâ duyuyorsun. Ta içeriden, yüreğinin derinliğinden.

Uyku geliyor tıpkı dalga gibi... yavaşça, nazikçe, kaçınılmaz biçimde.
""",
  ),
  UykuHikaye(
    baslik: "Dağ Evi",
    kisaAciklama: "Karlı dağlarda sıcak bir sığınak...",
    sure: "6 dk",
    ikon: Icons.cabin_rounded,
    renkler: [Color(0xFF4A148C), Color(0xFF1A0533)],
    icerik: """Derin bir nefes al. Omuzlarını düşür. Rahat ol.

Kendini küçük, ahşap bir dağ evinde hayal et. Dışarıda kar yağıyor. Beyaz, sessiz, yumuşak kar.

Ama sen içeridesin. Şöminenin başında. Ateş çıtırdıyor. Turuncu, sarı alevler dans ediyor.

Elinde sıcak bir bardak var. Islak ısısı avuçlarına geçiyor. Bir yudum içiyorsun — tatlı ve sıcak.

Pencerenin camında kar taneleri birikmiş. Dışarısı bembeyaz. Sessizlik öyle derin ki neredeyse duyabiliyorsun.

Battaniyeni daha sıkı çekiyorsun üstüne. Yumuşak, ağır, seni saran bir battaniye.

Ateşin sesi... çıtırtı... çatırtı... düzenli, rahatlatıcı.

Kar yağmaya devam ediyor. Dünya yavaşlıyor. Her şey örtülüyor. Gürültüler, endişeler, yorgunluklar — hepsi karın altında kalıyor.

Gözlerin kapanıyor. Ateşin ısısı yüzüne vuruyor. Güvendesin. Sıcaksın. Huzurdasın.

Uyku seni dağın zirvesinden alıp rüyalara götürüyor...
""",
  ),
  UykuHikaye(
    baslik: "Bulut Yolculuğu",
    kisaAciklama: "Pamuk bulutların üzerinde süzül...",
    sure: "5 dk",
    ikon: Icons.cloud_rounded,
    renkler: [Color(0xFF546E7A), Color(0xFF263238)],
    icerik: """Gözleri kapat. Birkaç derin nefes al.

Her nefeste vücudun biraz daha hafifliyor. Yatak sanki seni kaldırıyor, yukarı çekiyor.

Kendini beyaz, pamuk gibi bir bulutun üzerinde hayal et. Altın ışıkla aydınlanan bir gün batımı bulutunda.

Bulut seni taşıyor. Senin için burada. Seni tutmak için var.

Yavaşça süzülüyorsunuz. Rüzgar yok — sadece yumuşak, hafif bir ilerleyiş. Şehirler, ormanlar, nehirler altından geçiyor. Ama hepsi uzak, küçük, önemsize.

Sadece sen varsın. Ve bu bulut.

Başka bulutlar geçiyor yanından. Bazen rüzgar hafifçe saçlarını okşuyor. Serin, nazik.

Gözlerin ağırlaşıyor. Bulutun içine gömülüyorsun. Pamuktan bir yatak bu. Seni saran, tutan, taşıyan.

Güneş ufkun gerisine çekiliyor. Gökyüzü pembeden mora, mordan laciverde dönüşüyor.

İlk yıldızlar çıkıyor. Bulut seni gece yolculuğuna taşıyor.

Ve sen... derin bir uykuya dalıyorsun.
""",
  ),
  UykuHikaye(
    baslik: "Yağmur Altında",
    kisaAciklama: "Cam kenarında yağmur sesi...",
    sure: "4 dk",
    ikon: Icons.water_drop_rounded,
    renkler: [Color(0xFF1565C0), Color(0xFF0D3B6B)],
    icerik: """Nefes al. Gözleri kapat.

Kendini sıcak bir odada hayal et. Büyük bir pencere var önünde. Ve dışarıda yağmur yağıyor.

Damlalar cama vuruyor. Tak... tak... tak tak... farklı ritimler, farklı sesler. Hiç bitmeyecekmiş gibi, sürekli, sakin.

Islanmıyorsun. İçeridesin. Sıcaksın.

Camın üzerinde yağmur damlalarının oluşturduğu şekillere bakıyorsun. Her damla aşağı doğru kayıyor, başka damlalarla birleşiyor, kayıyor, gidiyor.

Tıpkı düşünceler gibi. Geliyorlar... ve gidiyorlar. Tutmak zorunda değilsin.

Yağmurun sesi dolduruyor odayı. Başka bir ses yok. Başka bir şey yok.

Sadece yağmur. Sadece sen. Sadece bu an.

Gözlerin kapanıyor. Yağmurun sesi seni sallamaya başlıyor, bir ezber gibi, bir ninniye...

Uyku yağmurla birlikte geliyor. Sessiz, yumuşak, kaçınılmaz.
""",
  ),
];

class UykuHikayeDetayEkrani extends StatelessWidget {
  final UykuHikaye hikaye;

  const UykuHikayeDetayEkrani({super.key, required this.hikaye});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hikaye.renkler.last,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white70),
        title: Text(
          hikaye.baslik,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst ikon
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(hikaye.ikon, color: Colors.white70, size: 40),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                hikaye.sure,
                style: const TextStyle(color: Colors.white38, fontSize: 13),
              ),
            ),
            const SizedBox(height: 32),
            // Hikaye metni
            Text(
              hikaye.icerik,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                height: 2.0,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UykuHikayeleriSekmesi extends StatelessWidget {
  const UykuHikayeleriSekmesi({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: uykuHikayeleri.length,
      itemBuilder: (context, index) {
        final hikaye = uykuHikayeleri[index];
        return _HikayeKarti(hikaye: hikaye);
      },
    );
  }
}

class _HikayeKarti extends StatelessWidget {
  final UykuHikaye hikaye;

  const _HikayeKarti({required this.hikaye});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UykuHikayeDetayEkrani(hikaye: hikaye),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: hikaye.renkler,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: hikaye.renkler.first.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(hikaye.ikon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hikaye.baslik,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hikaye.kisaAciklama,
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white54, size: 14),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      hikaye.sure,
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
