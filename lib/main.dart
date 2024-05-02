
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniprojectext/localeString.dart';
import 'package:miniprojectext/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return   GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: const Locale('en','US'),
      title: 'Text Prediction',
      home: const SplashScreen(),
    );
  }
}

