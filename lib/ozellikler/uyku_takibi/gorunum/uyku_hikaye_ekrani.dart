import 'package:flutter/material.dart';

// ─── Model ───────────────────────────────────────────────────────────────────

class UykuHikaye {
  final String baslik;
  final String kisaAciklama;
  final String icerik;
  final String sure;
  final IconData ikon;
  final List<Color> renkler;
  final String kategori;

  const UykuHikaye({
    required this.baslik,
    required this.kisaAciklama,
    required this.icerik,
    required this.sure,
    required this.ikon,
    required this.renkler,
    required this.kategori,
  });
}

// ─── Kategoriler ──────────────────────────────────────────────────────────────

class HikayeKategori {
  final String ad;
  final IconData ikon;
  final Color renk;

  const HikayeKategori({required this.ad, required this.ikon, required this.renk});
}

const List<HikayeKategori> hikayeKategorileri = [
  HikayeKategori(ad: "Doğa",      ikon: Icons.forest_rounded,       renk: Color(0xFF2E7D32)),
  HikayeKategori(ad: "Pozitif",   ikon: Icons.auto_awesome_rounded, renk: Color(0xFFE65100)),
  HikayeKategori(ad: "Uyku",      ikon: Icons.nightlight_round,     renk: Color(0xFF1A237E)),
  HikayeKategori(ad: "İç Huzur",  ikon: Icons.self_improvement_rounded, renk: Color(0xFF4A148C)),
];

// ─── Tüm Hikayeler ────────────────────────────────────────────────────────────

const List<UykuHikaye> tumHikayeler = [

  // ══════════════════════════════
  //  DOĞA
  // ══════════════════════════════

  UykuHikaye(
    kategori: "Doğa",
    baslik: "Orman Gezisi",
    kisaAciklama: "Huzur veren bir ormanda yürüyüş...",
    sure: "5 dk",
    ikon: Icons.forest_rounded,
    renkler: [Color(0xFF388E3C), Color(0xFF1B5E20)],
    icerik: """Gözlerini yavaşça kapat. Derin bir nefes al... ve bırak.

Kendini yumuşak bir orman yolunda hayal et. Ayaklarının altında yaş yaprakların sesi var. Sabahın ilk ışıkları ağaçların arasından süzülüyor ve yüzüne değiyor.

Hava serindir. Temizdir. Her nefeste ormanın taze kokusunu içine çekiyorsun — çam iğneleri, toprak ve yağmur sonrasının kokusu...

Yürüdükçe ağaçlar seni kucaklıyor. Uzaktan bir derenin sesi geliyor. Suların taşların üzerinden süzülüşü... tın tın tın...

Yolun kenarında küçük bir kaya var. Ona oturuyorsun. Sırtını kalın bir meşe ağacına yaslatıyorsun. Ağaç seni taşıyor, destekliyor.

Bir kuş ötüyor uzakta. Sonra sessizlik.

Sadece nefes. Sadece orman. Sadece şu an.

Gözlerin ağırlaşıyor. Orman seni sarıyor. Güvendesin. Huzurdasın.
""",
  ),

  UykuHikaye(
    kategori: "Doğa",
    baslik: "Deniz Kıyısı",
    kisaAciklama: "Dalgaların ritmine bırak kendini...",
    sure: "5 dk",
    ikon: Icons.waves_rounded,
    renkler: [Color(0xFF00838F), Color(0xFF00363A)],
    icerik: """Gözleri kapat. Derin bir nefes al, burnundan... ağzından yavaşça ver.

Kendini kumlu bir sahilde hayal et. Gece vakti. Ay denizin üzerinde parlıyor, gümüşi bir yol çiziyor.

Denizin sesini duy. Dalga geliyor... kıyıya vuruyor... çekiliyor. Geliyor... vuruyor... çekiliyor.

Bu ritim nefesine benziyor. Sen nefes alırken dalga geliyor. Sen verirken çekiliyor.

Vücudun kuma gömülüyor. Deniz seni sallıyor, bir beşik gibi. İleri... geri... ileri... geri...

Tuz kokusu burnunu dolduruyor. Bir dalga ayak parmaklarını ıslatıyor. Sonra çekiliyor.

Gözlerin kapanıyor. Uyku geliyor tıpkı dalga gibi... yavaşça, nazikçe, kaçınılmaz biçimde.
""",
  ),

  UykuHikaye(
    kategori: "Doğa",
    baslik: "Yağmur Melodisi",
    kisaAciklama: "Cam kenarında yağmur sesi...",
    sure: "4 dk",
    ikon: Icons.water_drop_rounded,
    renkler: [Color(0xFF1565C0), Color(0xFF0D3B6B)],
    icerik: """Nefes al. Gözleri kapat.

Kendini sıcak bir odada hayal et. Büyük bir pencere var önünde. Ve dışarıda yağmur yağıyor.

Damlalar cama vuruyor. Tak... tak... tak tak... farklı ritimler, farklı sesler.

Islanmıyorsun. İçeridesin. Sıcaksın.

Camın üzerinde yağmur damlalarının şekillerine bakıyorsun. Her damla aşağı kayıyor, başkalarıyla birleşiyor, gidiyor.

Tıpkı düşünceler gibi. Geliyorlar... ve gidiyorlar. Tutmak zorunda değilsin.

Yağmurun sesi odayı dolduruyor. Başka bir ses yok. Başka bir şey yok.

Uyku yağmurla birlikte geliyor. Sessiz, yumuşak, kaçınılmaz.
""",
  ),

  UykuHikaye(
    kategori: "Doğa",
    baslik: "Çiçek Bahçesi",
    kisaAciklama: "Rengarenk bir bahçede dinlen...",
    sure: "5 dk",
    ikon: Icons.local_florist_rounded,
    renkler: [Color(0xFF558B2F), Color(0xFF33691E)],
    icerik: """Derin bir nefes al ve bırak.

Kendini güneşli bir bahçede hayal et. Ayaklarının altında yumuşak çimen var. Taze kesilmiş çimen kokusu burnuna geliyor.

Etrafında her renkte çiçek. Lavantalı morlar, güneşi andıran sarılar, sevgi dolu kırmızılar, huzur veren maviler...

Arılar çiçekten çiçeğe uçuyor. Tatlı bir vızıltı var havada. Bir kelebek geçiyor yanından — turuncu ve siyah kanatlar, hafifçe inip kalkıyor.

Bahçenin ortasındaki ahşap bankta oturuyorsun. Güneş yüzünü ısıtıyor. Gözlerin kapanıyor ama çiçekleri hissedebiliyorsun, renkleri içinde taşıyorsun.

Bahçe sana şunu fısıldıyor: Her şey büyüyor. Her şey açıyor. Sen de açıyorsun.

Huzur içinde, gülümseyerek uykuya dalıyorsun.
""",
  ),

  UykuHikaye(
    kategori: "Doğa",
    baslik: "Dere Kenarı",
    kisaAciklama: "Serin bir derenin yanında dinlen...",
    sure: "4 dk",
    ikon: Icons.water_rounded,
    renkler: [Color(0xFF00695C), Color(0xFF004D40)],
    icerik: """Gözlerini kapat. Omuzlarını düşür.

Kendini taşlık bir dere kenarında hayal et. Su berrak ve serin. Güneş ışığı suyun yüzeyinde dans ediyor, küçük gökkuşakları oluşturuyor.

Taşların üzerine oturuyorsun. Ayaklarını suya daldırıyorsun. Serin, canlandırıcı...

Dere kendi haline akıyor. Hiçbir şey onu durduramıyor. Taşların etrafından dolaşıyor, önündeki her engeli aşıyor. Nazikçe, ısrarla.

Tıpkı senin gibi. Sen de her engelin etrafından geçebiliyorsun. Nazikçe, ısrarla.

Kuşlar ötüşüyor. Yapraklar hışırdıyor. Dere şarkı söylüyor.

Gözlerin kapanıyor. Su sesi seni taşıyor... uzaklara, derinlere, uykuya...
""",
  ),

  UykuHikaye(
    kategori: "Doğa",
    baslik: "Gün Batımı",
    kisaAciklama: "Turuncu gökyüzünde huzur bul...",
    sure: "5 dk",
    ikon: Icons.wb_twilight_rounded,
    renkler: [Color(0xFFBF360C), Color(0xFF7B1FA2)],
    icerik: """Nefes al... ve bırak.

Tepede duruyorsun. Önünde sonsuz bir ufuk var. Güneş yavaşça alçalıyor — turuncu, pembe, mor. Gökyüzü bir tablo gibi.

Rüzgar yüzünü okşuyor. Serin ama sert değil. Saçlarını hafifçe dağıtıyor.

Güneş biraz daha alçalıyor. Renklerin derinleşiyor. Turuncu koyulaşıyor, pembe mor oluyor.

Gün bitti. Her şey tamam. Her şey tamamlandı.

Bugün ne kadar yük taşıdın bilmiyorum. Ama bu gün batımı sana şunu söylüyor: Her gün biter. Ve her gece bir uyku getirir. Ve her sabah yeni bir şans.

Güneş ufka gömülüyor. İlk yıldızlar çıkıyor.

Sen de gömülüyorsun — yatağına, uykuya, derin bir dinlenmeye.
""",
  ),

  // ══════════════════════════════
  //  POZİTİF
  // ══════════════════════════════

  UykuHikaye(
    kategori: "Pozitif",
    baslik: "Bugün Yeterliydin",
    kisaAciklama: "Kendine şefkatle bak...",
    sure: "5 dk",
    ikon: Icons.favorite_rounded,
    renkler: [Color(0xFFE64A19), Color(0xFFBF360C)],
    icerik: """Gözlerini kapat. Derin bir nefes al.

Bu gün boyunca ne kadar çok şey yaptığını düşün. Belki fark etmedin ama... kalktın. Devam ettin. Hayatın içinde kaldın.

Bu küçük değil. Bu büyük.

Bazen en cesur şey sadece devam etmektir. Ve sen devam ettin.

Mükemmel olmak zorunda değilsin. Güçlü olmak zorunda değilsin. Sadece sen olman yeterli.

Kendine bir an için şunu söyle: "Bugün yeterliyim."

Bunu hissedebiliyor musun? Göğsünde bir yumuşama var mı?

Her nefeste bu his büyüsün. Her nefeste biraz daha kendine yaklaş.

Sen sevilmeye layıksın. Tam şu an, olduğun haliyle.

Huzur içinde uyu. Yarın seni bekleyen yeni bir gün var.
""",
  ),

  UykuHikaye(
    kategori: "Pozitif",
    baslik: "Minnet Bahçesi",
    kisaAciklama: "Hayatındaki güzellikleri say...",
    sure: "5 dk",
    ikon: Icons.spa_rounded,
    renkler: [Color(0xFFF57F17), Color(0xFFE65100)],
    icerik: """Derin bir nefes al. Bırak.

Şimdi seninle bir alıştırma yapalım. Gözlerini kapat ve hayatındaki üç güzel şeyi düşün.

Küçük olabilirler. Sevdiğin biri. Sıcak bir içecek. Sabah güneşi. Güldüğün bir an. Yardım eden bir el.

Bu güzellikler hep orada. Bazen gürültünün altında kalıyorlar ama yok olmuyorlar.

Kalbinin üzerine elini koy. Hissedebiliyorsun — atıyor. Senin için. Durmadan.

Vücudun her gece iyileşiyor uyurken. Hiçbir şey yapmadan, sadece nefes alırken bile, içinde mucizeler oluyor.

Şükran duygusu göğsünde açılıyor. Sıcak, yumuşak, doldurucu.

Bu güzelliklerle beraber uyu bu gece. Onlar seninle.
""",
  ),

  UykuHikaye(
    kategori: "Pozitif",
    baslik: "Sabahın Sesi",
    kisaAciklama: "Yarın yeni bir başlangıç seni bekliyor...",
    sure: "4 dk",
    ikon: Icons.wb_sunny_rounded,
    renkler: [Color(0xFFFF8F00), Color(0xFFE65100)],
    icerik: """Gözlerini kapat. Nefes al.

Yarın sabah güneş doğacak. Her zaman doğduğu gibi. Durmadan, yorulmadan, sadece senin için değil ama kesinlikle sen dahil.

Ve o ışık pencerenden içeri girecek. Yüzüne değecek. Sıcacık.

Yarın yeni bir sayfa. Bugünün yorgunluğu, bugünün hataları, bugünün endişeleri — hepsi bu gece uykuyla yıkanacak.

Sabah kalktığında yeniden başlama şansın var. Her sabah bu şans sana veriliyor.

Şu an tek yapman gereken şey uyumak. Bedenini dinlendirmek. Zihnini serbest bırakmak.

Sabah gelecek. Ve sen hazır olacaksın.

Şimdi, huzurla... gözlerini kapat... ve uyu.
""",
  ),

  UykuHikaye(
    kategori: "Pozitif",
    baslik: "Güçlü Adımlar",
    kisaAciklama: "Sen düşündüğünden çok daha güçlüsün...",
    sure: "5 dk",
    ikon: Icons.directions_walk_rounded,
    renkler: [Color(0xFFAD1457), Color(0xFF880E4F)],
    icerik: """Derin bir nefes al. Kendini şu ana getir.

Düşün — bugüne kadar kaç zorluğu aştın. Kaç kez "bunu yapamam" dedikten sonra yine de yaptın.

Hepsini saymak zorunda değilsin. Sadece bil ki: Sen geçmişte her zaman bir yol buldun.

Bazen yavaş yürüdün. Bazen tökezledin. Ama durduğunda bile, eninde sonunda tekrar kalktın.

Bu senin gücün. Senden alınamaz.

Ve bu gece, bu güç seninle birlikte uyuyacak. Sabah uyandığında o yine orada olacak — dinlenmiş, hazır, seninle.

Sen düşündüğünden çok daha güçlüsün.

Bu bilgiyle, huzurla uyu.
""",
  ),

  UykuHikaye(
    kategori: "Pozitif",
    baslik: "Seni Seviyorum",
    kisaAciklama: "Kendine karşı nazik ol bu gece...",
    sure: "4 dk",
    ikon: Icons.volunteer_activism_rounded,
    renkler: [Color(0xFFC62828), Color(0xFF7B1FA2)],
    icerik: """Gözlerini kapat. Ellerini karnının üzerine koy.

Şimdi sana bir şey sormak istiyorum: Kendine ne zaman son kez "iyi iş çıkardın" dedin?

Çoğu zaman kendimize karşı en sert eleştirmeniz oluyoruz. Başkasına asla söylemeyeceğimiz şeyleri kendimize söylüyoruz.

Bu gece bunu bırakalım.

Kendine şefkatle bak. Tıpkı iyi bir dost gibi. Tıpkı küçük bir çocuğa bakar gibi.

"İyi yaptın. Denemeye devam ediyorsun. Bu yeterli."

Bu sözleri içine çek. Onlara izin ver.

Sen sevgiye layıksın — özellikle kendinden.

Nazikçe, sevgiyle uyu bu gece.
""",
  ),

  UykuHikaye(
    kategori: "Pozitif",
    baslik: "Hayalin Kapısı",
    kisaAciklama: "Hayallerin gerçekleşebilir...",
    sure: "6 dk",
    ikon: Icons.lightbulb_rounded,
    renkler: [Color(0xFF1565C0), Color(0xFF4A148C)],
    icerik: """Derin bir nefes al.

Gözlerini kapat ve bir hayalini düşün. Gerçekleşmesini istediğin, yüreğinin bir köşesinde sakladığın o hayali.

Belki küçük, belki büyük. Önemli değil.

Şimdi o hayalin içinde olduğunu hayal et. Nasıl görünüyor? Nasıl hissettiriyor? Etrafında ne var?

Bu his gerçek. Bu his sende var. Ve sende olan her şey mümkün.

Hayaller gerçekleşmeden önce hep önce içimizde başlıyor. Tam şu anda yaptığın gibi.

Uykuya dalarken o hayali yanında götür. Beynin bu gece onunla çalışacak, yollar arayacak, kapılar açacak.

Sabah uyandığında, belki bir adım daha yakın olacaksın.

Hayalinle birlikte uyu.
""",
  ),

  // ══════════════════════════════
  //  UYKU
  // ══════════════════════════════

  UykuHikaye(
    kategori: "Uyku",
    baslik: "Yıldızlı Gece",
    kisaAciklama: "Sonsuz gökyüzünde bir yolculuk...",
    sure: "6 dk",
    ikon: Icons.star_rounded,
    renkler: [Color(0xFF283593), Color(0xFF0D1B4B)],
    icerik: """Nefes al... ve bırak. Omuzlarındaki tüm gerilimi yere bırak.

Kendini geniş, ıssız bir çayırda uzanmış hayal et. Üzerinde kalın, yumuşak bir battaniye var.

Yukarıya bakıyorsun. Gökyüzü sonsuz, koyu lacivert. Ve yıldızlar...

Sayamayacağın kadar çok yıldız. Her biri farklı bir parlaklıkta.

Bir yıldız kayıyor. Gözlerin peşinden gidiyor, sonra kayboluyor.

Vücudun yere gömülüyor — ağır değil, huzurlu bir ağırlık bu.

Kutup yıldızı sabit duruyor. Her zaman orada. Her zaman bekliyor.

Gözlerin kapanıyor. Evrende küçük ama değerli bir noktasın. Güvendesin. Korunuyorsun.

Sessizce, yavaşça... uykuya dalıyorsun.
""",
  ),

  UykuHikaye(
    kategori: "Uyku",
    baslik: "Dağ Evi",
    kisaAciklama: "Karlı dağlarda şömine başında...",
    sure: "6 dk",
    ikon: Icons.cabin_rounded,
    renkler: [Color(0xFF4A148C), Color(0xFF1A0533)],
    icerik: """Derin bir nefes al. Omuzlarını düşür. Rahat ol.

Kendini küçük, ahşap bir dağ evinde hayal et. Dışarıda kar yağıyor. Beyaz, sessiz, yumuşak.

Ama sen içeridesin. Şöminenin başında. Ateş çıtırdıyor. Alevler dans ediyor.

Elinde sıcak bir bardak var. Avuçlarına geçiyor ısısı. Bir yudum içiyorsun — tatlı ve sıcak.

Battaniyeni daha sıkı çekiyorsun. Yumuşak, ağır, seni saran bir battaniye.

Ateşin sesi... çıtırtı... çatırtı... düzenli, rahatlatıcı.

Kar yağmaya devam ediyor. Dünya yavaşlıyor. Gürültüler, endişeler — hepsi karın altında kalıyor.

Güvendesin. Sıcaksın. Huzurdasın.

Uyku seni dağın zirvesinden alıp rüyalara götürüyor...
""",
  ),

  UykuHikaye(
    kategori: "Uyku",
    baslik: "Bulut Yolculuğu",
    kisaAciklama: "Pamuk bulutların üzerinde süzül...",
    sure: "5 dk",
    ikon: Icons.cloud_rounded,
    renkler: [Color(0xFF546E7A), Color(0xFF263238)],
    icerik: """Gözleri kapat. Birkaç derin nefes al.

Her nefeste vücudun biraz daha hafifliyor.

Kendini beyaz, pamuk gibi bir bulutun üzerinde hayal et. Gün batımı bulutunda.

Bulut seni taşıyor. Senin için burada.

Yavaşça süzülüyorsunuz. Şehirler, ormanlar, nehirler altından geçiyor. Hepsi uzak, küçük, önemsize.

Sadece sen varsın. Ve bu bulut.

Gözlerin ağırlaşıyor. Bulutun içine gömülüyorsun. Pamuktan bir yatak bu.

Güneş ufkun gerisine çekiliyor. İlk yıldızlar çıkıyor.

Ve sen... derin bir uykuya dalıyorsun.
""",
  ),

  UykuHikaye(
    kategori: "Uyku",
    baslik: "Ninni Rüzgarı",
    kisaAciklama: "Rüzgar seni uykuya götürüyor...",
    sure: "4 dk",
    ikon: Icons.air_rounded,
    renkler: [Color(0xFF37474F), Color(0xFF102027)],
    icerik: """Nefes al... ver... al... ver...

Rüzgar esiyor. Hafif, ılık bir rüzgar. Sanki biri seni okşuyor, nazikçe, bir ninni gibi.

Perdeler hafifçe kalkıp indiyor. Yapraklar fısıldıyor.

Rüzgar sana bir şey söylüyor, kelimesiz bir dilde: "Bırak. Bırak hepsini."

Ve sen bırakıyorsun. Bugünü. Yarını. Düşünceleri. Endişeleri.

Hepsi rüzgarla birlikte gidiyor. Uzaklara.

Geride sadece bu an kalıyor. Bu nefes. Bu sessizlik.

Rüzgar devam ediyor. Ninni gibi. Sonsuz, sakin, seni taşıyan.

Gözlerin kapanıyor... kapanıyor... kapandı.
""",
  ),

  UykuHikaye(
    kategori: "Uyku",
    baslik: "Ay Işığı",
    kisaAciklama: "Ayın huzurlu ışığında yüz...",
    sure: "5 dk",
    ikon: Icons.nightlight_rounded,
    renkler: [Color(0xFF1A237E), Color(0xFF000051)],
    icerik: """Gözleri kapat. Derin bir nefes.

Pencerenden ay ışığı giriyor. Gümüşi, yumuşak, sihirli.

O ışık yatağını aydınlatıyor. Üzerini kaplıyor. Tıpkı ince bir örtü gibi.

Ay ışığı soğuk değil. Aksine, tuhaf bir şekilde sıcak. Sanki uzaktaki birinin sevgisi gibi.

Düşün — bu ay milyonlarca insan tarafından görülüyor şu an. Her biri farklı bir yerde, farklı bir dilde, aynı aya bakıyor.

Sen yalnız değilsin. Hiç olmadın.

Ay ışığı seni sallıyor. Tıpkı deniz gibi. Tıpkı rüzgar gibi.

Gözlerin kapanıyor. Ay bekliyor. Sabaha kadar orada olacak.

Onu bilerek, güvenerek uyu.
""",
  ),

  // ══════════════════════════════
  //  İÇ HUZUR
  // ══════════════════════════════

  UykuHikaye(
    kategori: "İç Huzur",
    baslik: "Nefes ve Sessizlik",
    kisaAciklama: "Sadece nefes al, sadece var ol...",
    sure: "4 dk",
    ikon: Icons.self_improvement_rounded,
    renkler: [Color(0xFF6A1B9A), Color(0xFF38006B)],
    icerik: """Dur. Sadece dur.

Bir şey yapman gerekmiyor. Bir yere gitmen gerekmiyor. Kimseye bir şey kanıtlaman gerekmiyor.

Sadece nefes al.

İçine çek... yavaşça... doldur... tut biraz... ve bırak.

Bu nefes seni yaşatıyor. Bu nefes her şey.

Zihnin belki konuşmaya devam ediyor. İzin ver. Düşünceler gelsin ve gitsin. Onları tutmak zorunda değilsin.

Sen o düşünceler değilsin. Sen onları izleyensin. Sakin, sessiz, her zaman orada olan sen.

Bir nefes daha. Ve bir tane daha.

Sessizlik bir boşluk değil. Sessizlik bir doluluk.

İçinde bu huzuru taşı. O hep orada.
""",
  ),

  UykuHikaye(
    kategori: "İç Huzur",
    baslik: "Göl Yüzeyi",
    kisaAciklama: "Zihnin sakin bir göl gibi...",
    sure: "5 dk",
    ikon: Icons.water_rounded,
    renkler: [Color(0xFF004D40), Color(0xFF00251A)],
    icerik: """Gözlerini kapat. Omuzlarını düşür.

Zihninizi bir göl olarak hayal et. Sakin, derin, berrak.

Bazen rüzgar çıkıyor ve yüzey dalgalanıyor. Endişeler, düşünceler, ses. Bu normal.

Ama gölün derinlerine in. Orada her zaman sakinlik var. Yüzeyde ne olursa olsun, derinlerde her şey sessiz.

Sen o derinliksin.

Rüzgar dinginleşiyor. Yüzey yavaşça sakinleşiyor. Kıpırtılar azalıyor... azalıyor...

Göl ayna gibi oluyor. Gökyüzünü yansıtıyor. Yıldızları yansıtıyor.

Sen de bu gece gökyüzünü içinde taşıyarak uyu.

Derin, sakin, berrak.
""",
  ),

  UykuHikaye(
    kategori: "İç Huzur",
    baslik: "Beden Taraması",
    kisaAciklama: "Vücudunun her yerini dinlendir...",
    sure: "6 dk",
    ikon: Icons.accessibility_new_rounded,
    renkler: [Color(0xFF311B92), Color(0xFF1A0040)],
    icerik: """Gözlerini kapat. Yatağına iyice yerleş.

Şimdi ayak parmaklarından başlayalım. Onlara dikkatini ver. Onları hisset. Gevşet.

Ayak tabanların... topuklarınız... baldırlarınız... dizleriniz... Tüm bacakların ağır, sıcak, rahat.

Kalçalarınız yatağa gömülüyor. Karniniz her nefeste yükseliyor alçalıyor. Serbest bırak.

Sırtın yatak tarafından tutuluyor. Her omurga rahatça destekleniyor.

Ellerinin... bileklerinin... kollarının... omuzlarının gerginliği eriyor.

Boynun uzuyor. Çenenin gevşiyor. Alın kasların yumuşuyor.

Bütün vücudun artık ağır ve sıcak. Her nokta dinleniyor.

Sen tamamen buradasın. Tamamen güvende. Tamamen huzurda.

Uyu.
""",
  ),

  UykuHikaye(
    kategori: "İç Huzur",
    baslik: "Kabul",
    kisaAciklama: "Olduğun gibi olman yeterli...",
    sure: "5 dk",
    ikon: Icons.hub_rounded,
    renkler: [Color(0xFF880E4F), Color(0xFF4A148C)],
    icerik: """Derin bir nefes al.

Bu gece sana bir şey hatırlatmak istiyorum.

Mükemmel olmak zorunda değilsin. Her şeyi bilmek zorunda değilsin. Her şeyi çözmek zorunda değilsin.

Sen şu an tam olarak olman gereken yerde, olman gereken şekilde varsın.

Hayat bazen zor. Bazen planlar tutmuyor. Bazen yoruluyorsun.

Bu insani. Bu gerçek. Ve bu kabul edilebilir.

Kendine karşı sert olmayı bırak bu gece. Sadece bu gece. Yarın tekrar bakarsın.

"Ben yeterliyim. Ben değerliyim. Ben seviliyorum."

Bu sözleri içine al. Onlara inan. Onlar gerçek.

Kabul içinde, huzur içinde, sevgi içinde... uyu.
""",
  ),

  UykuHikaye(
    kategori: "İç Huzur",
    baslik: "Işık Kaynağı",
    kisaAciklama: "İçindeki ışığı hisset...",
    sure: "5 dk",
    ikon: Icons.flare_rounded,
    renkler: [Color(0xFFE65100), Color(0xFF4A148C)],
    icerik: """Gözleri kapat. Nefes al.

Göğsünün tam ortasında, kalbinin yanında bir ışık olduğunu hayal et. Küçük ama sıcak. Sarı, altın bir ışık.

Her nefeste biraz büyüyor. Her nefeste biraz daha parlıyor.

Bu ışık senin. Her zaman seninle. Kimse alamaz. Hiçbir zor gün söndüremez.

Bazen örtülüyor, biliyorum. Yorgunluk örtüyor, üzüntü örtüyor. Ama orada. Her zaman orada.

Şimdi o ışığın yavaşça tüm vücuduna yayıldığını hisset. Kollarına... bacaklarına... başının tepesine...

Sen ışıkla doluyorsun.

Bu ışıkla uyu bu gece. Sabah seni aydınlatacak.
""",
  ),
];

// ─── Yardımcı fonksiyon ───────────────────────────────────────────────────────

List<UykuHikaye> kategoriyeGoreGetir(String kategori) =>
    tumHikayeler.where((h) => h.kategori == kategori).toList();

// ─── Hikaye Detay Ekranı ──────────────────────────────────────────────────────

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
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(hikaye.ikon, color: Colors.white70, size: 38),
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
            Text(
              hikaye.icerik,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                height: 2.1,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Hikayeler Sekmesi (Kategorili) ─────────────────────────────────────────

class UykuHikayeleriSekmesi extends StatelessWidget {
  const UykuHikayeleriSekmesi({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: hikayeKategorileri.map((kategori) {
        final hikayeler = kategoriyeGoreGetir(kategori.ad);
        if (hikayeler.isEmpty) return const SizedBox.shrink();
        return _KategoriBloku(kategori: kategori, hikayeler: hikayeler);
      }).toList(),
    );
  }
}

class _KategoriBloku extends StatelessWidget {
  final HikayeKategori kategori;
  final List<UykuHikaye> hikayeler;

  const _KategoriBloku({required this.kategori, required this.hikayeler});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Kategori başlığı
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kategori.renk.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(kategori.ikon, color: kategori.renk, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                kategori.ad,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "${hikayeler.length} hikaye",
                style: const TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
        ),
        // Hikaye kartları
        ...hikayeler.map((h) => _HikayeKarti(hikaye: h)),
        const SizedBox(height: 12),
      ],
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
        MaterialPageRoute(builder: (_) => UykuHikayeDetayEkrani(hikaye: hikaye)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: hikaye.renkler,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: hikaye.renkler.first.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(hikaye.ikon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hikaye.baslik,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      hikaye.kisaAciklama,
                      style: const TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  hikaye.sure,
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white38, size: 12),
            ],
          ),
        ),
      ),
    );
  }
}
