import 'package:flutter/material.dart';
import 'metin_okuyucu_ekrani.dart';

class DinlendiriciMetin {
  final String id;
  final String baslik;
  final String kategori;
  final String sure;
  final IconData ikon;
  final Color renk;
  final String icerik;

  const DinlendiriciMetin({
    required this.id,
    required this.baslik,
    required this.kategori,
    required this.sure,
    required this.ikon,
    required this.renk,
    required this.icerik,
  });
}

const List<DinlendiriciMetin> dinlendiriciMetinler = [
  DinlendiriciMetin(
    id: 'm1',
    baslik: 'Uyku Öncesi Beden Tarama',
    kategori: 'Uyku',
    sure: '8 dk',
    ikon: Icons.bedtime_rounded,
    renk: Color(0xFF0F3460),
    icerik: '''Rahat bir pozisyon al. Gözlerini kapat ve birkaç derin nefes al.

Her nefes verişte bedenin biraz daha ağırlaşıyor, biraz daha yumuşuyor.

Dikkatini ayaklarının tabanına getir. Parmakların, topuğun, ayak tabanın... Onları fark et ve bırak. Rahatla.

Yavaşça dikkatini baldırlarına, dizlerine, uylukların getir. Kaslarındaki gerilimi fark et. Nefes ver ve bırak.

Kalçan, belin, sırtın... Sırtın altlığa ya da yatağa dokunduğu yerleri hisset. Ağırlığını ver. Tamamıyla bırak.

Karnın nefesle yükselip alçalıyor. Göğsün genişliyor, daralıyor. Sadece izle. Müdahale etme.

Omuzların... Fark et ne kadar gerginler. Nefes ver ve onları aşağı bırak. Boyun, çene, yüz kasların...

Alnın düzleşiyor. Gözkapakların ağırlaşıyor. Dudakların ayrılıyor.

Tüm beden şimdi tam anlamıyla dinleniyor. Ağır, sıcak, rahat.

Sadece bu ana ait ol. Yarın için hiçbir şey yapman gerekmiyor. Dün geride kaldı.

Şu an güvendesin. Rahatla ve bırak kendini uykuya...''',
  ),
  DinlendiriciMetin(
    id: 'm2',
    baslik: 'Sabah Niyeti',
    kategori: 'Sabah',
    sure: '4 dk',
    ikon: Icons.wb_sunny_rounded,
    renk: Color(0xFFB45309),
    icerik: '''Gözlerini yavaşça aç. Bugün yeni bir gün.

Birkaç derin nefes al. Her nefes alışında taze bir başlangıç hissini içine çek.

Ellerini kalbinin üzerine koy. Bugün nasıl biri olmak istiyorsun? Sakin mi? Güçlü mü? Sevgi dolu mu?

Bugün karşına çıkacak güzel anlara şimdiden teşekkür et. Henüz yaşamamış olsan da onlar seni bekliyor.

Kendine şunu söyle:
"Bugün elimden gelenin en iyisini yapacağım."
"Kendime ve başkalarına karşı nazik olacağım."
"Her anda bir seçim yapma gücüm var."

Derin bir nefes al. Tut. Yavaşça ver.

Günün sana sunduğu bu yeni sayfayı açık, meraklı ve sabırlı bir yürekle karşıla.

Günaydın.''',
  ),
  DinlendiriciMetin(
    id: 'm3',
    baslik: 'Stres Bırakma',
    kategori: 'Rahatlama',
    sure: '6 dk',
    ikon: Icons.self_improvement_rounded,
    renk: Color(0xFF0F766E),
    icerik: '''Dur. Sadece bir an için dur.

Ne kadar hızlı gittiğini fark et. Zihinde dönen düşünceler, yapılacaklar listesi, endişeler...

Şimdi onları bir kenara bırak. Sadece birkaç dakika için.

4'e kadar say ve nefes al.
1... 2... 3... 4...
Şimdi 7'ye kadar say ve tut.
1... 2... 3... 4... 5... 6... 7...
8'e kadar say ve ver.
1... 2... 3... 4... 5... 6... 7... 8...

Tekrar yap. Bu nefes seni şu ana bağlıyor.

Stres bir duygu. Duygular gelir ve geçer. Sen bu duygudan ibaret değilsin.

Elini kalbine koy. Hissediyorsun. Bu an var. Bu an geçecek.

Şu an için değiştirebileceğin nedir? Sadece onu düşün. Değiştiremeyeceklerini bir balon gibi hava vererek bırak.

Omuzlarını geri çek. Çeneni rahat bırak. Nefes ver.

Güçlüsün. Bu anı atlatacaksın.''',
  ),
  DinlendiriciMetin(
    id: 'm4',
    baslik: 'Doğa Yürüyüşü',
    kategori: 'Visualizasyon',
    sure: '7 dk',
    ikon: Icons.forest_rounded,
    renk: Color(0xFF166534),
    icerik: '''Gözlerini kapat. Derin bir nefes al.

Kendini ormanlık bir yolda hayal et. Sabahın erken saatleri. Hava serin ve taze.

Ayaklarının altında yumuşak toprak hissediyorsun. Her adımda yaprak sesleri. Kuru dal kırıntıları.

Ağaçların arasından süzülen güneş ışığı yüzüne değiyor. Sıcak, tatlı bir dokunuş.

Uzaktan bir dere sesi geliyor. Suyun taşların üzerinden akışı. Ritimli, sürekli, sakin.

Derin bir nefes al. Toprağın, yaprakların, nemin kokusunu hissediyorsun. Temiz. Doğal.

Bir ağacın yanında dur. Elinle kabuğuna dokun. Pürüzlü, serin, sağlam. Bu ağaç yıllardır burada. Geçmişi hatırlıyor, geleceği bekliyor. Sen de şu an buradasın.

Başını kaldır. Yaprakların arasından göğü görüyorsun. Mavi, berrak, sonsuz.

Bu sessizlikte, bu güzellikte, sadece kendinsin. Hiçbir şey yapman gerekmiyor. Hiçbir yere yetişmen gerekmiyor.

Sadece bu an. Sadece bu orman. Sadece sen.

Derin bir nefes al ve bu huzuru içinde tut.''',
  ),
  DinlendiriciMetin(
    id: 'm5',
    baslik: 'Şimdiye Dön',
    kategori: 'Farkındalık',
    sure: '5 dk',
    ikon: Icons.spa_rounded,
    renk: Color(0xFF0369A1),
    icerik: '''Dur. Şu an neredesin?

5 şey gör. Etrafına bak. Beş nesneyi fark et. Renkleri, şekilleri, gölgeleri.

4 şey dokunarak hisset. Ellerinin altındaki yüzey, kıyafetin teni, havanın sıcaklığı, ayaklarının bastığı zemin.

3 şey duy. Sessizliğin içinde ne var? Bir ses, uzaktan bir gürültü, nefes sesi...

2 şey kokla. Derin bir nefes al. Havada ne var? Yakın çevrenden ne geliyor?

1 şey tat. Ağzında ne hissediyorsun? Sadece fark et.

Şu an burada olduğunu fark et. Geçmiş geride kaldı. Gelecek henüz gelmedi.

Tek gerçek olan bu an.

Nefes al. Şimdi varsın. Bu yeterli.''',
  ),
  DinlendiriciMetin(
    id: 'm6',
    baslik: 'Minnettarlık Anı',
    kategori: 'Şükran',
    sure: '5 dk',
    ikon: Icons.favorite_rounded,
    renk: Color(0xFFB91C1C),
    icerik: '''Otur ya da uzan. Rahat bir pozisyon bul.

Gözlerini kapat ve ellerini kalbinin üzerine koy.

Bugün sana verilen en küçük şeyi düşün. Belki bir gülümseme. Belki sıcak bir yemek. Belki sağlıklı bir nefes.

Bu küçük şey için içinden teşekkür et. Gerçekten, yürekten.

Hayatında olan birine düşün. Seni seven, destekleyen, yanında olan biri. Onu hayal et. Gülümsemesini, sesini.

Bu kişi için içinden teşekkür et.

Şimdi kendi bedenine düşün. Seni taşıyan ayaklarına, düşünen zihnine, hisseden kalbine.

Bedenin için teşekkür et.

Minnettarlık büyür. Her teşekkür ettiğinde biraz daha büyür.

Bugün küçük ama gerçek bir şeye minnettar ol.

Nefes al. Bu duyguyu içinde tut. Güne ya da geceye bu hisle devam et.''',
  ),
  DinlendiriciMetin(
    id: 'm7',
    baslik: 'Derin Dinlenme',
    kategori: 'Uyku',
    sure: '10 dk',
    ikon: Icons.nights_stay_rounded,
    renk: Color(0xFF1E1B4B),
    icerik: '''Uzan. Bacaklarını uzat. Kollarını bedeninin yanına bırak.

Gözlerini kapat.

Bir nefes al. Derin. Yavaş. Karnın şişiyor.

Ver. Yavaş. Uzun. Karnın iniyor.

Tekrar.

Al... ver... al... ver...

Zihnin düşüncelerle dolmaya çalışabilir. Sorun değil. Onları balonlar gibi gökyüzüne bırak. Biri gider, biri gelir. Sen izliyorsun. Sadece izliyorsun.

Bedenin ağırlaşıyor. Başın, boyun, omuzların... Ağır. Sıcak. Rahat.

Kolların, ellerin, parmaklarının uçları... Ağır. Sıcak. Rahat.

Göğsün, karnın, sırtın... Yatağa bırak. Teslim ol.

Kalçaların, bacaklarının, ayaklarının... Ağır. Sıcak. Rahat.

Tüm beden şimdi tam dinleniyor. Kas kalmadı. Gerilim kalmadı. Sadece dinginlik var.

Zihnin yavaşlıyor. Düşünceler uzaklaşıyor. Sessizlik geliyor.

Bu sessizlikte güvendesin. Seviliyorsun. Her şey yolunda.

Gözkapakların ağır. Nefesler yavaş ve derin.

Bırak kendini. Tamamen bırak...''',
  ),
  DinlendiriciMetin(
    id: 'm8',
    baslik: 'İç Huzur',
    kategori: 'Farkındalık',
    sure: '6 dk',
    ikon: Icons.psychology_rounded,
    renk: Color(0xFF1D4ED8),
    icerik: '''İçinde her zaman sakin bir yer var.

Dışarıda ne kadar gürültülü olursa olsun, zihnin ne kadar meşgul olursa olsun, o yer orada.

Onu bulmak için uzaklara gitmen gerekmiyor. Sadece içine dön.

Gözlerini kapat. Nefes al. Nefes ver.

O sakin yeri hayal et. Belki bir oda. Belki bir bahçe. Belki sadece bir ışık.

Ona ulaş. Ona otur. Bir süre orada kal.

Bu yer sana ait. Kimse onu alamaz. Hiçbir durum onu yok edemez.

Zor anlarda buraya dönebilirsin. Her zaman burada.

Nefes al. İçindeki bu sakinliği hissediyorsun.

Bu senin gücün. Bu senin sığınağın. Bu sen.

Derin bir nefes al ve bu huzuru beraberinde taşı.''',
  ),
];

const List<String> _kategoriler = ['Tümü', 'Uyku', 'Sabah', 'Rahatlama', 'Visualizasyon', 'Farkındalık', 'Şükran'];

class DinlendiriciMetinlerEkrani extends StatefulWidget {
  const DinlendiriciMetinlerEkrani({super.key});

  @override
  State<DinlendiriciMetinlerEkrani> createState() => _DinlendiriciMetinlerEkraniState();
}

class _DinlendiriciMetinlerEkraniState extends State<DinlendiriciMetinlerEkrani> {
  String _seciliKategori = 'Tümü';

  List<DinlendiriciMetin> get _filtrelenmisMetinler => _seciliKategori == 'Tümü'
      ? dinlendiriciMetinler
      : dinlendiriciMetinler.where((m) => m.kategori == _seciliKategori).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Dinlendirici Metinler',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1E293B)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kategori filtresi
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: _kategoriler.length,
              separatorBuilder: (context, i) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final kat = _kategoriler[i];
                final aktif = _seciliKategori == kat;
                return GestureDetector(
                  onTap: () => setState(() => _seciliKategori = kat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: aktif ? const Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: aktif ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Text(
                      kat,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: aktif ? Colors.white : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Metin listesi
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              physics: const BouncingScrollPhysics(),
              itemCount: _filtrelenmisMetinler.length,
              separatorBuilder: (context, i) => const SizedBox(height: 12),
              itemBuilder: (context, i) => _metinKarti(_filtrelenmisMetinler[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metinKarti(DinlendiriciMetin metin) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MetinOkuyucuEkrani(metin: metin)),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Sol ikon kutusu
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: metin.renk,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(metin.ikon, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 14),
            // Başlık + kategori + süre
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    metin.baslik,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: metin.renk.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          metin.kategori,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: metin.renk,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.schedule_rounded, size: 12, color: Colors.grey[400]),
                      const SizedBox(width: 3),
                      Text(
                        metin.sure,
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }
}
