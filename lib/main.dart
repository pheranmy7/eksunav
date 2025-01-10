import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:eksunav/screens/home_screen.dart';
import 'package:eksunav/screens/location_screen.dart';
import 'package:eksunav/screens/profile_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Simulate some initialization logic (e.g., loading configuration, etc.)
  await Future.delayed(
      const Duration(seconds: 2)); // Simulated initialization delay

  // Remove the splash screen
  FlutterNativeSplash.remove();
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
