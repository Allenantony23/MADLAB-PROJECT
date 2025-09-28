import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/onboarding/splash_screen.dart';
import 'services/theme_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BharatBazaar',
      debugShowCheckedModeBanner: false,
      theme: ThemeService.lightTheme,
      darkTheme: ThemeService.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}