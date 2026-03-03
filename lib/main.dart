import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ozellikler/ana_sayfa/gorunum/ana_yapi.dart';
import 'ozellikler/giris/gorunum/giris_ekrani.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAWVYLnRTZPJNlQmGB_cNYFEzO-hwqvKTQ",
        appId: "1:618664986823:android:9d6a66a9a0041ba7a996e2",
        messagingSenderId: "618664986823",
        projectId: "maditasyon-uygulamasi",
        storageBucket: "maditasyon-uygulamasi.firebasestorage.app",
        authDomain: "maditasyon-uygulamasi.firebaseapp.com",
      ),
    );
    runApp(const MaditasyonUygulamasi());
  } catch (e) {
    print("FIREBASE BASLATMA HATASI: $e");
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Başlatma Hatası: $e")),
      ),
    ));
  }
}

class MaditasyonUygulamasi extends StatelessWidget {
  const MaditasyonUygulamasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maditasyon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Montserrat',
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const AnaYapi();
          }
          return const GirisEkrani();
        },
      ),
    );
  }
}
