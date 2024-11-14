import 'dart:typed_data';
import 'package:assistantwithai/src/common_widgets/image_custom.dart';
import 'package:assistantwithai/src/constants/assets.dart';
import 'package:assistantwithai/src/constants/colors_enviroments.dart';
import 'package:assistantwithai/src/features/image_upload/data/models/content_options.dart';
import 'package:assistantwithai/src/features/image_upload/data/models/image_upload.dart';
import 'package:assistantwithai/src/features/image_upload/presentation/screens/image_preview_screen.dart';
import 'package:assistantwithai/src/features/image_upload/presentation/widgets/Option_Custom.dart';
import 'package:assistantwithai/src/features/image_upload/services/instruction_promt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Imageuploadscreen extends StatefulWidget {
  const Imageuploadscreen({super.key});

  @override
  State<Imageuploadscreen> createState() => _ImageuploadscreenState();
}

class _ImageuploadscreenState extends State<Imageuploadscreen> {
  bool isLoading = false;
  String? fileName;
  PlatformFile? pickedFile;
  Uint8List? selectedImageBytes;
  List<ContentOptions> contendOptions = [];

  final instruction = Instruction();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final myName =
        textTheme.labelLarge?.copyWith(color: const Color(colorPrimary));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(myColorPrimary),
        title: const Text(
          'RutinaPro: Generador de Rutina',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              const ImageCustom(imagePath: fitnessApp),
              const _Contend(),
              const SizedBox(height: 10),
              //opciones
              const _OptionsBadges(),
              const Spacer(),
              Text('Hecho por Lesly Samaritano | Flutterina Studio',
                  style: myName),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionsBadges extends StatefulWidget {
  const _OptionsBadges();

  @override
  State<_OptionsBadges> createState() => _OptionsBadgesState();
}

class _OptionsBadgesState extends State<_OptionsBadges> {
  bool isLoading = false;
  String? fileName;
  PlatformFile? pickedFile;
  Uint8List? selectedImageBytes;
  List<ContentOptions> contendOptions = [];

  final instruction = Instruction();
  final imageUpload = ImageUpload();

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        imageUpload.file = result.files.first;
        debugPrint("result: $result");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OptionCustom(
          icon: Icons.photo,
          label: 'Escoger de Galeria',
          onPressed: _selectFile,
        ),
        const SizedBox(width: 80),
        OptionCustom(
          icon: Icons.photo_camera,
          label: 'Tomar Foto',
          onPressed: () {},
        ),
      ],
    );
  }
}

class _Contend extends StatelessWidget {
  const _Contend();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final titleStyle =
        textTheme.headlineSmall?.copyWith(color: color.secondary);
    final subtitleStyle = textTheme.titleMedium;
    final subtitleBoldStyle =
        textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);

    return Column(
      children: [
        Text('Sube una Foto de tu Equipo', style: titleStyle),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            text: 'Toma o selecciona una foto del ',
            style: subtitleStyle,
            children: [
              TextSpan(text: 'equipo de ejercicio ', style: subtitleBoldStyle),
              TextSpan(text: 'que tienes disponible.', style: subtitleStyle),
            ],
          ),
        ),
      ],
    );
  }
}
