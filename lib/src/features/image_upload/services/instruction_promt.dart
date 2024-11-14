import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:assistantwithai/src/constants/assets.dart';
import 'package:assistantwithai/src/features/image_upload/data/models/image_upload.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Instruction {
  Future<String> generatedContendRequeriments(ImageUpload view) async {
    final model =
        GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKeyValue);

    if (view.file == null) {
      return "No se ha seleccionado ningún archivo";
    }

    final PlatformFile file = view.file!;
    Uint8List? imageBytes;

    // En lugar de usar el path, obtenemos los bytes directamente
    if (file.bytes != null) {
      imageBytes = file.bytes;
    } else {
      // Esto es solo para plataformas que soportan paths
      final imageFile = File(file.path!);
      imageBytes = await imageFile.readAsBytes();
    }

    if (imageBytes == null) {
      return "Error al procesar la imagen";
    }
    //Crea la instrucción
    final prompt = TextPart(
        'En idioma español puedes generar contenido, porque eres un entrenador personal de ejericio fisico, y en base a está imagen, que es un equipo de ejericio para entrenar, genera contenido utilizando este esquema JSON:\n\n'
        'Y para el campo availablePhotoEquipment lista los equipos que hay en la imagen o foto.\n'
        'ContentOptions = {"idContentOptions": string, "exerciseGoal": List<String>, "experienceLevel": List<String>, "desiredDurationOfTheRoutine": List<String>, "availablePhotoEquipment": List<String>}\n'
        'Return: Array<ContentOptions>'
        );

   // Crea el DataPart usando los bytes
    final imageParts = [DataPart('image/png', imageBytes)];

    // Respuesta del gemini
    final response = await model.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);

    final cleanedResponse = _cleanResponse(response.text!);
    return cleanedResponse;
  }

  static String _cleanResponse(String response) {
    final firstCorchete = response.indexOf('[');
    final lastCorchete = response.lastIndexOf(']');
    String recortado = response.substring(firstCorchete, lastCorchete + 1);
    return recortado;
  }
}
