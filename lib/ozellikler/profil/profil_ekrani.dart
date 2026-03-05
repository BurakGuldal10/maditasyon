import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../cekirdek/servisler/auth_servisi.dart';
import '../../cekirdek/servisler/yerel_depo_servisi.dart';
import '../../veri/modeller/gunluk_modeli.dart';
import '../../veri/modeller/uyku_modeli.dart';

// ── Renk Paleti ──────────────────────────────────────────────────────────────
const _bg   = Color(0xFFEEF4FF);   // çok açık mavi arka plan
const _pur  = Color(0xFF1A73E8);   // ana mavi
const _teal = Color(0xFF06B6D4);   // cyan-teal
const _gold = Color(0xFFFFB300);
const _text = Color(0xFF0F172A);   // koyu lacivert metin
const _gri  = Color(0xFF64748B);   // mavi-gri
const _sari = Color(0xFFFFB300);

// ════════════════════════════════════════════════════════════════════════════
// ANA PROFİL EKRANI
// ════════════════════════════════════════════════════════════════════════════

class ProfilEkrani extends StatefulWidget {
  const ProfilEkrani({super.key});
  @override
  State<ProfilEkrani> createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani>
    with SingleTickerProviderStateMixin {
  final _depo = YerelDepoServisi();
  final _auth = AuthServisi();

  List<GunlukKaydi> _gunlukler = [];
  List<UykuKaydi>   _uykular   = [];
  bool _yukleniyor = true;

  late AnimationController _glowCtrl;
  late Animation<double>   _glowAnim;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 8, end: 26).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );
    _yukle();
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    super.dispose();
  }

  Future<void> _yukle() async {
    final g = await _depo.gunlukKayitlariniGetir();
    final u = await _depo.uykuKayitlariniGetir();
    if (mounted) setState(() { _gunlukler = g; _uykular = u; _yukleniyor = false; });
  }

  List<UykuKaydi> get _ruayalar =>
      _uykular.where((u) => u.not != null && u.not!.isNotEmpty).toList();

  void _git(Widget s) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => s));

  // ─── BUILD ──────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: _bg,
      body: _yukleniyor
          ? Center(child: CircularProgressIndicator(color: _pur))
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _header(user)),
                SliverToBoxAdapter(child: _statSatiri()),
                SliverToBoxAdapter(
                  child: _bolum(
                    gradient: const [Color(0xFF1A73E8), Color(0xFF60A5FA)],
                    emoji: "📔", baslik: "Zihin Günlüğü",
                    sayac: _gunlukler.length,
                    onTumunu: () => _git(_GunlukListesiSayfasi(kayitlar: _gunlukler)),
                    icerik: _gunlukOzeti(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _bolum(
                    gradient: const [Color(0xFF0F3460), Color(0xFF0EA5E9)],
                    emoji: "🌙", baslik: "Uyku & Rüya Notları",
                    sayac: _uykular.length,
                    onTumunu: () => _git(_UykuListesiSayfasi(kayitlar: _uykular)),
                    icerik: _uykuOzeti(),
                  ),
                ),
                SliverToBoxAdapter(child: _rozetler()),
                SliverToBoxAdapter(child: _cikisBtn()),
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
    );
  }

  // ─── HEADER ─────────────────────────────────────────────────────────────
  Widget _header(User? user) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF1454A0), Color(0xFF2F80ED)],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(42)),
      ),
      child: Stack(
        children: [
          // Dekoratif daireler
          Positioned(top: -30, right: -30,
            child: _dekorDaire(140, Colors.white.withOpacity(0.07))),
          Positioned(top: 60, left: -40,
            child: _dekorDaire(100, Colors.white.withOpacity(0.05))),
          Positioned(bottom: 10, right: 50,
            child: _dekorDaire(60, Colors.white.withOpacity(0.08))),
          Positioned(bottom: -20, left: 30,
            child: _dekorDaire(80, Colors.white.withOpacity(0.06))),

          // İçerik
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 36),
              child: Column(
                children: [
                  // Çıkış butonu
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => _cikisOnayla(context),
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: const Icon(Icons.logout_rounded, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Parlayan avatar
                  AnimatedBuilder(
                    animation: _glowAnim,
                    builder: (_, child) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.35),
                            blurRadius: _glowAnim.value,
                            spreadRadius: _glowAnim.value / 5,
                          ),
                        ],
                      ),
                      child: child,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3.5),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : null,
                        backgroundColor: Colors.white.withOpacity(0.25),
                        child: user?.photoURL == null
                            ? const Icon(Icons.person_rounded, size: 50, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    user?.displayName ?? 'Meditasyon Yolcusu',
                    style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w900,
                      color: Colors.white, letterSpacing: -0.5,
                    ),
                  ),
                  if (user?.email != null) ...[
                    const SizedBox(height: 4),
                    Text(user!.email!,
                        style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.75))),
                  ],
                  const SizedBox(height: 22),

                  // Header istatistik satırı
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.25)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _headerStat("${_gunlukler.length}", "Günlük", "📔"),
                        _dikey(),
                        _headerStat("${_uykular.length}", "Uyku", "🌙"),
                        _dikey(),
                        _headerStat("${_ruayalar.length}", "Rüya", "✨"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dekorDaire(double r, Color c) =>
      Container(width: r, height: r, decoration: BoxDecoration(shape: BoxShape.circle, color: c));

  Widget _headerStat(String deger, String etiket, String emoji) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(deger, style: const TextStyle(
            fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white)),
        Text(etiket, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8))),
      ],
    );
  }

  Widget _dikey() =>
      Container(width: 1, height: 50, color: Colors.white.withOpacity(0.3));

  // ─── İSTATİSTİK KARTLARI ────────────────────────────────────────────────
  Widget _statSatiri() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
      child: Row(
        children: [
          Expanded(child: _gradyanKart(
            "Kayıt\nGünlüğü", _gunlukler.length, Icons.auto_stories_rounded,
            const [Color(0xFF2193B0), Color(0xFF6DD5FA)],
          )),
          const SizedBox(width: 12),
          Expanded(child: _gradyanKart(
            "Uyku\nKaydı", _uykular.length, Icons.bedtime_rounded,
            const [Color(0xFF1A73E8), Color(0xFF64B5F6)],
          )),
          const SizedBox(width: 12),
          Expanded(child: _gradyanKart(
            "Rüya\nNotu", _ruayalar.length, Icons.auto_awesome_rounded,
            const [Color(0xFF0EA5E9), Color(0xFF38BDF8)],
          )),
        ],
      ),
    );
  }

  Widget _gradyanKart(String baslik, int sayi, IconData ikon, List<Color> renkler) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: renkler, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: renkler[0].withOpacity(0.45),
            blurRadius: 18, offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), shape: BoxShape.circle),
            child: Icon(ikon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 8),
          Text("$sayi", style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
          Text(baslik, textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.88), height: 1.3)),
        ],
      ),
    );
  }

  // ─── BÖLÜM KAPSAYICI ────────────────────────────────────────────────────
  Widget _bolum({
    required List<Color> gradient,
    required String emoji,
    required String baslik,
    required int sayac,
    required VoidCallback onTumunu,
    required Widget icerik,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık satırı
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gradient[0].withOpacity(0.12), gradient[1].withOpacity(0.04)],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: gradient[0].withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Text("$emoji ", style: const TextStyle(fontSize: 20)),
                Text(baslik, style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: _text)),
                if (sayac > 0) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradient),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text("$sayac",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ],
                const Spacer(),
                if (sayac > 0)
                  GestureDetector(
                    onTap: onTumunu,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradient),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: gradient[0].withOpacity(0.4),
                              blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: const Text("Tümünü Gör →",
                          style: TextStyle(
                              fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          icerik,
        ],
      ),
    );
  }

  // ─── GÜNLÜK ÖZETİ ───────────────────────────────────────────────────────
  Widget _gunlukOzeti() {
    if (_gunlukler.isEmpty) return _bosHal("Henüz günlük kaydı yok 🌱\nGünlük sekmesinden bugünü kaydet.");
    return Column(children: _gunlukler.take(2).map(_gunlukKarti).toList());
  }

  Widget _gunlukKarti(GunlukKaydi k) {
    final renk = _moodRenk(k.ruhHali);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: renk.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          // Sol renkli çubuk
          Container(
            width: 5,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [renk, renk.withOpacity(0.4)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
            ),
          ),
          const SizedBox(width: 14),
          Text(_moodEmoji(k.ruhHali), style: const TextStyle(fontSize: 34)),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(k.ruhHali,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15, color: _text)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: renk.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(_tarihStr(k.tarih),
                            style: TextStyle(fontSize: 10, color: renk, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  if (k.not.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(k.not,
                        maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: _gri, height: 1.4)),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
    );
  }

  // ─── UYKU ÖZETİ ─────────────────────────────────────────────────────────
  Widget _uykuOzeti() {
    if (_uykular.isEmpty) return _bosHal("Henüz uyku kaydı yok 🌙\nUyku Takibi sekmesinden ekle.");
    return Column(children: _uykular.take(2).map(_uykuKarti).toList());
  }

  Widget _uykuKarti(UykuKaydi k) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: const Color(0xFF6A82FB).withOpacity(0.2),
              blurRadius: 16, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        children: [
          // Gradient başlık şeridi
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF0A1628), Color(0xFF1454A0)]),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                const Text("🌙", style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text(_tarihStr(k.tarih),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                const Spacer(),
                ...List.generate(5, (i) => Icon(
                  i < k.kalitePuani ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: i < k.kalitePuani ? _sari : Colors.white24, size: 16)),
              ],
            ),
          ),
          // Detaylar
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(spacing: 8, runSpacing: 6, children: [
                  _cip(Icons.bedtime_rounded, k.yatisSaati, const Color(0xFF6A82FB)),
                  _cip(Icons.wb_sunny_rounded, k.uyanmaSaati, const Color(0xFFFF8E53)),
                  _cip(Icons.access_time_rounded, k.sureBilgisi, _teal),
                ]),
                if (k.not != null && k.not!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome_rounded, size: 13, color: Color(0xFF38BDF8)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(k.not!,
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 11, color: _gri, fontStyle: FontStyle.italic)),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── ROZETLER ───────────────────────────────────────────────────────────
  Widget _rozetler() {
    final list = [
      {"isim": "3 Gün Seri",   "ikon": Icons.local_fire_department_rounded, "k": _gunlukler.length >= 3,
       "g": const [Color(0xFF2193B0), Color(0xFF6DD5FA)]},
      {"isim": "Gece Kuşu",    "ikon": Icons.dark_mode_rounded,             "k": _uykular.isNotEmpty,
       "g": const [Color(0xFF0F3460), Color(0xFF1A73E8)]},
      {"isim": "Rüyacı",       "ikon": Icons.auto_awesome_rounded,           "k": _ruayalar.isNotEmpty,
       "g": const [Color(0xFF5B86E5), Color(0xFF36D1DC)]},
      {"isim": "Farkındalık",  "ikon": Icons.self_improvement_rounded,       "k": _gunlukler.length >= 7,
       "g": const [Color(0xFF1A73E8), Color(0xFF60A5FA)]},
      {"isim": "Erken Kalkan", "ikon": Icons.wb_sunny_rounded,               "k": false,
       "g": const [Color(0xFF0EA5E9), Color(0xFF38BDF8)]},
      {"isim": "Odak Ustası",  "ikon": Icons.center_focus_strong_rounded,    "k": false,
       "g": const [Color(0xFF2563EB), Color(0xFF7C3AED)]},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Row(children: [
            const Text("🏅 ", style: TextStyle(fontSize: 20)),
            const Text("Başarılar",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _text)),
          ]),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 14, crossAxisSpacing: 12, childAspectRatio: 0.82,
            ),
            itemBuilder: (_, i) {
              final r = list[i];
              final k = r["k"] as bool;
              final g = r["g"] as List<Color>;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutBack,
                decoration: BoxDecoration(
                  gradient: k
                      ? LinearGradient(colors: g, begin: Alignment.topLeft, end: Alignment.bottomRight)
                      : null,
                  color: k ? null : const Color(0xFFDCEBFF),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: k
                      ? [BoxShadow(color: g[0].withOpacity(0.45), blurRadius: 16, offset: const Offset(0, 6))]
                      : [],
                  border: k ? Border.all(color: Colors.white.withOpacity(0.4), width: 1.5) : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: k ? Colors.white.withOpacity(0.25) : const Color(0xFFC8DCFF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(r["ikon"] as IconData,
                          color: k ? Colors.white : const Color(0xFFB0A8CC), size: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(r["isim"] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: k ? FontWeight.bold : FontWeight.normal,
                            color: k ? Colors.white : const Color(0xFF7BAAD4),
                            height: 1.3)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─── ÇIKIŞ ──────────────────────────────────────────────────────────────
  Widget _cikisBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: GestureDetector(
        onTap: () => _cikisOnayla(context),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)]),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(color: const Color(0xFFFF416C).withOpacity(0.45),
                  blurRadius: 18, offset: const Offset(0, 8)),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text("Çıkış Yap",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  // ─── BOŞ HAL ────────────────────────────────────────────────────────────
  Widget _bosHal(String mesaj) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x18000000), blurRadius: 14, offset: Offset(0, 4))],
      ),
      child: Column(
        children: [
          const Icon(Icons.inbox_rounded, size: 38, color: Color(0xFF93C5FD)),
          const SizedBox(height: 10),
          Text(mesaj,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: _gri, height: 1.6)),
        ],
      ),
    );
  }

  // ─── ÇIKIŞ ONAYI ────────────────────────────────────────────────────────
  void _cikisOnayla(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        title: const Text("Çıkış Yap",
            style: TextStyle(fontWeight: FontWeight.bold, color: _text)),
        content: const Text("Hesabından çıkmak istediğine emin misin?",
            style: TextStyle(color: _gri)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("İptal", style: TextStyle(color: _gri)),
          ),
          TextButton(
            onPressed: () { Navigator.pop(ctx); _auth.cikisYap(); },
            child: const Text("Çıkış Yap",
                style: TextStyle(color: Color(0xFFFF416C), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// TAM GÜNLÜK LİSTESİ SAYFASI
// ════════════════════════════════════════════════════════════════════════════

class _GunlukListesiSayfasi extends StatelessWidget {
  final List<GunlukKaydi> kayitlar;
  const _GunlukListesiSayfasi({required this.kayitlar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Zihin Günlüğü",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A73E8), Color(0xFF60A5FA)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          kayitlar.isEmpty
              ? const SliverFillRemaining(
                  child: Center(
                    child: Text("Henüz kayıt yok", style: TextStyle(color: _gri, fontSize: 15)),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => _kart(kayitlar[i]),
                      childCount: kayitlar.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _kart(GunlukKaydi k) {
    final renk = _moodRenk(k.ruhHali);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(color: renk.withOpacity(0.22), blurRadius: 18, offset: const Offset(0, 7)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık şeridi
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [renk.withOpacity(0.15), renk.withOpacity(0.04)]),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            ),
            child: Row(
              children: [
                Text(_moodEmoji(k.ruhHali), style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(k.ruhHali,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16, color: _text)),
                    Text(_tarihStr(k.tarih),
                        style: TextStyle(fontSize: 11, color: renk, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          // Not içeriği
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
            child: k.not.isNotEmpty
                ? Text(k.not,
                    style: const TextStyle(fontSize: 14, color: _text, height: 1.7))
                : const Text("Not eklenmemiş.",
                    style: TextStyle(fontSize: 13, color: _gri, fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// TAM UYKU LİSTESİ SAYFASI
// ════════════════════════════════════════════════════════════════════════════

class _UykuListesiSayfasi extends StatelessWidget {
  final List<UykuKaydi> kayitlar;
  const _UykuListesiSayfasi({required this.kayitlar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Uyku & Rüya Kayıtları",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0A1628), Color(0xFF1454A0)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          kayitlar.isEmpty
              ? const SliverFillRemaining(
                  child: Center(
                    child: Text("Henüz kayıt yok", style: TextStyle(color: _gri, fontSize: 15)),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => _kart(kayitlar[i]),
                      childCount: kayitlar.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _kart(UykuKaydi k) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(color: Color(0x306A82FB), blurRadius: 18, offset: Offset(0, 7)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gece gradyan başlık
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF0A1628), Color(0xFF1454A0)]),
              borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
            ),
            child: Row(
              children: [
                const Text("🌙", style: TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Text(_tarihStr(k.tarih),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                const Spacer(),
                ...List.generate(5, (i) => Icon(
                  i < k.kalitePuani ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: i < k.kalitePuani ? _sari : Colors.white24, size: 17)),
              ],
            ),
          ),
          // Detaylar
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(spacing: 8, runSpacing: 8, children: [
                  _cip(Icons.bedtime_rounded, k.yatisSaati, const Color(0xFF6A82FB)),
                  _cip(Icons.wb_sunny_rounded, k.uyanmaSaati, const Color(0xFFFF8E53)),
                  _cip(Icons.access_time_rounded, k.sureBilgisi, _teal),
                  _cip(Icons.emoji_events_rounded, k.kaliteMetni, _gold),
                ]),
                if (k.not != null && k.not!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const Divider(color: Color(0xFFF0ECFF), height: 1),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.auto_awesome_rounded, size: 16,
                          color: Color(0xFF38BDF8)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(k.not!,
                            style: const TextStyle(
                                fontSize: 13, color: _text, height: 1.7,
                                fontStyle: FontStyle.italic)),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// ORTAK YARDIMCILAR
// ════════════════════════════════════════════════════════════════════════════

String _moodEmoji(String ruhHali) {
  const m = {'Mutlu': '😊', 'Huzurlu': '😌', 'Normal': '😐', 'Üzgün': '😔', 'Stresli': '🤯'};
  return m[ruhHali] ?? '📝';
}

Color _moodRenk(String ruhHali) {
  const m = {
    'Mutlu':   Color(0xFF43E97B),
    'Huzurlu': Color(0xFF38F9D7),
    'Normal':  Color(0xFF6A82FB),
    'Üzgün':   Color(0xFF6C63FF),
    'Stresli': Color(0xFFFC466B),
  };
  return m[ruhHali] ?? const Color(0xFF7C4DFF);
}

String _tarihStr(DateTime t) {
  const ay = ['Oca','Şub','Mar','Nis','May','Haz','Tem','Ağu','Eyl','Eki','Kas','Ara'];
  return "${t.day} ${ay[t.month - 1]} ${t.year}";
}

Widget _cip(IconData ikon, String metin, Color renk) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: renk.withOpacity(0.12),
      borderRadius: BorderRadius.circular(11),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(ikon, size: 13, color: renk),
      const SizedBox(width: 5),
      Text(metin, style: TextStyle(fontSize: 11, color: renk, fontWeight: FontWeight.w600)),
    ]),
  );
}
