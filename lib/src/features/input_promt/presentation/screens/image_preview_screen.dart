import 'dart:typed_data';
import 'package:assistantwithai/src/common_widgets/outline_button.dart';
import 'package:flutter/material.dart';

class ImagePreviewScreen extends StatelessWidget {
  final Uint8List imageBytes;
  final VoidCallback onPressed;

  const ImagePreviewScreen({
    super.key,
    required this.imageBytes,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.memory(
            imageBytes,
            fit: BoxFit.contain,
            height: 300,
          ),
          const SizedBox(height: 30),
          MyOutlinedButton(
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
