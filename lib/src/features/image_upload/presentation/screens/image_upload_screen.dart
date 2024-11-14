import 'package:assistantwithai/src/common_widgets/image_custom.dart';
import 'package:assistantwithai/src/constants/constants.dart';
import 'package:assistantwithai/src/features/image_upload/image_upload.dart';
import 'package:assistantwithai/src/features/input_promt/data/models/content_options.dart';
import 'package:assistantwithai/src/features/input_promt/presentation/screens/personalization_routine_screen.dart';
import 'package:assistantwithai/src/utils/image_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Imageuploadscreen extends StatelessWidget {
  const Imageuploadscreen({super.key});

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
  List<ContentOptions> contendOptions = [];

  final ImageUpload imageUpload = ImageUpload();

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final file = result.files.first;
      // Obtener los bytes de la imagen utilizando la función en utils.dart
      final imageBytes = await getImageBytes(file);

      if (imageBytes != null) {
        setState(() {
          imageUpload.fileBytes = imageBytes;
          debugPrint(
              "imageUpload del setState de Imageuploadscreen: ${imageUpload.fileBytes}");
        });

        // Navegar a la pantalla de vista previa con los bytes de la imagen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PersonalizationRoutineScreen(
              imageBytes: imageBytes,
            ),
          ),
        );
      } else {
        debugPrint("No se pudieron obtener los bytes de la imagen.");
      }
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
