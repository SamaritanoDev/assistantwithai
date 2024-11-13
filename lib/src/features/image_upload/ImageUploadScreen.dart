import 'package:assistantwithai/src/constants/colors_enviroments.dart';
import 'package:flutter/material.dart';

class Imageuploadscreen extends StatelessWidget {
  const Imageuploadscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(myColorPrimary),
        title: const Text(
          'RutinaPro: Generador de Rutina',
        ),
      ),
      body: const Center(
        child: Text('Imageuploadscreen'),
      ),
    );
  }
}
