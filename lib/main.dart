import 'package:assistantwithai/src/constants/colors_enviroments.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(myColorPrimary),
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: const Color(colorSecondary),
        //   secondary: const Color(colorSecondary),
        //   tertiary: const Color(colorTertiary),
        // ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(myColorPrimary),
          title: const Text(
            'RutinaPro',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.photo,
          ),
        ),
        body: const Center(
          child: Text('Rutina Pro'),
        ),
      ),
    );
  }
}
