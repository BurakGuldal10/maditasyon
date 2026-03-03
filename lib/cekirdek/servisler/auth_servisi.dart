import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthServisi {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '618664986823-puchk9mu2ltn8l8p62qdk9r88s3v6lor.apps.googleusercontent.com',
  );

  Stream<User?> get kullaniciDurumu => _auth.authStateChanges();

  User? get mevcutKullanici => _auth.currentUser;

  Future<User?> googleIleGiris() async {
    if (kIsWeb) {
      final provider = GoogleAuthProvider();
      final UserCredential sonuc = await _auth.signInWithPopup(provider);
      return sonuc.user;
    }

    final GoogleSignInAccount? googleKullanici = await _googleSignIn.signIn();
    if (googleKullanici == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleKullanici.authentication;

    final OAuthCredential kimlikBilgisi = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential sonuc =
        await _auth.signInWithCredential(kimlikBilgisi);
    return sonuc.user;
  }

  Future<void> cikisYap() async {
    if (kIsWeb) {
      await _auth.signOut();
      return;
    }
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
