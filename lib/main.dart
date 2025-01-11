import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eksunav/screens/home_screen.dart';
import 'package:eksunav/screens/location_screen.dart';
import 'package:eksunav/screens/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC9ZRhjD7wGYPMF1A_jzDnRzNVuFHtfWYk",
            authDomain: "eksunav-8d8fd.firebaseapp.com",
            projectId: "eksunav-8d8fd",
            storageBucket: "eksunav-8d8fd.firebasestorage.app",
            messagingSenderId: "161728297127",
            appId: "1:161728297127:web:e54e655a13e486bbd18382",
            measurementId: "G-1CF23ZJNV5"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EksuNav',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home', // The default screen to open
      routes: {
        '/home': (context) => const HomeScreen(),
        '/location': (context) => const LocationScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
