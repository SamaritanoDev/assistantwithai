import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImagePreviewScreen extends StatelessWidget {
  final Uint8List imageBytes;

  const ImagePreviewScreen({
    super.key,
    required this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      imageBytes,
      fit: BoxFit.contain,
      height: 100,
    );
  }
}
