import 'package:assistantwithai/src/constants/colors_enviroments.dart';
import 'package:assistantwithai/src/features/image_upload/presentation/screens/image_upload_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // colorSchemeSeed: const Color(myColorPrimary),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(colorSecondary),
          primary: const Color(myColorPrimary),
          secondary: const Color(colorSecondary),
          tertiary: const Color(colorTertiary),
        ),
      ),
      home: const Imageuploadscreen(),
    );
  }
}
