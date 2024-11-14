import 'dart:convert';
import 'dart:typed_data';
import 'package:assistantwithai/src/common_widgets/outline_button.dart';
import 'package:assistantwithai/src/constants/colors_enviroments.dart';
import 'package:assistantwithai/src/features/image_upload/data/models/image_upload.dart';
import 'package:assistantwithai/src/features/image_upload/services/instruction_promt.dart';
import 'package:assistantwithai/src/features/input_promt/data/models/content_options.dart';
import 'package:assistantwithai/src/features/input_promt/presentation/widgets/sliding_rotine.dart';
import 'package:flutter/material.dart';

class PersonalizationRoutineScreen extends StatefulWidget {
  final Uint8List imageBytes;

  const PersonalizationRoutineScreen({
    super.key,
    required this.imageBytes,
  });

  @override
  State<PersonalizationRoutineScreen> createState() =>
      _PersonalizationRoutineScreenState();
}

class _PersonalizationRoutineScreenState
    extends State<PersonalizationRoutineScreen> {
  bool isLoading = false;
  List<ContentOptions> contendOptions = [];
  final ImageUpload imageUpload = ImageUpload(fileBytes: Uint8List(0));
  final instruction = Instruction();

  Future<void> _generatedContendPersonalizationRoutine() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Obtener la respuesta del promt
      final cleanedResponse =
          await instruction.generatedContendRequeriments(widget.imageBytes);

      // Decodificar el JSON recibido
      final List<dynamic> jsonData = jsonDecode(cleanedResponse);

      debugPrint("cleanedResponse: $cleanedResponse");

      setState(() {
        contendOptions =
            jsonData.map((item) => ContentOptions.fromJson(item)).toList();
        isLoading = false; // Detener el indicador de progreso
      });

      // Mostrar el modal solo si se cargaron los datos correctamente
      if (contendOptions.isNotEmpty) {
        _showCustomizationModal();
      }
    } catch (e) {
      // Manejar error y detener el indicador de progreso
      setState(() {
        isLoading = false;
      });

      debugPrint("Error generando el contenido: $e");

      // Mostrar un mensaje de error al usuario
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Hubo un problema al generar la rutina. Por favor, intenta de nuevo más tarde.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }

  void _showCustomizationModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SlidingRoutine(
        contentOptions: contendOptions,
        imageBytes: widget.imageBytes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Personaliza tu Rutina'),
        backgroundColor: const Color(myColorPrimary),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(
              widget.imageBytes,
              fit: BoxFit.contain,
              height: 300,
            ),
            const SizedBox(height: 30),
            isLoading
                ? CircularProgressIndicator(color: color.secondary)
                : const SizedBox(),
            const SizedBox(height: 30),
            MyOutlinedButton(
              onPressed: () {
                _generatedContendPersonalizationRoutine();
              },
            ),
          ],
        ),
      ),
    );
  }
}
