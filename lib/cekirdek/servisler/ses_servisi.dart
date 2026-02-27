import 'package:just_audio/just_audio.dart';

class SesServisi {
  static final SesServisi _instance = SesServisi._internal();
  factory SesServisi() => _instance;
  SesServisi._internal();

  final AudioPlayer _player = AudioPlayer();
  final AudioPlayer _arkaPlanPlayer = AudioPlayer(); // Doğa sesleri için ayrı player

  // İnternet üzerinden bir ses çal
  Future<void> urlCal(String url, {bool loop = false}) async {
    try {
      await _player.setUrl(url);
      if (loop) await _player.setLoopMode(LoopMode.one);
      _player.play();
    } catch (e) {
      print("Ses çalma hatası: $e");
    }
  }

  // Doğa sesleri (Loop)
  Future<void> dogaSesiCal(String url) async {
    try {
      await _arkaPlanPlayer.setUrl(url);
      await _arkaPlanPlayer.setLoopMode(LoopMode.one);
      _arkaPlanPlayer.play();
    } catch (e) {
      print("Doğa sesi çalma hatası: $e");
    }
  }

  Future<void> durdur() async {
    await _player.stop();
    await _arkaPlanPlayer.stop();
  }

  Future<void> duraklat() async {
    await _player.pause();
    await _arkaPlanPlayer.pause();
  }

  Future<void> devamEt() async {
    _player.play();
    _arkaPlanPlayer.play();
  }

  Stream<Duration?> get pozisyonStream => _player.positionStream;
  Stream<Duration?> get toplamSureStream => _player.durationStream;
  Stream<bool> get caliyorMuStream => _player.playingStream;
}
