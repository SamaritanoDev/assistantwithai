import 'dart:async';
import 'dart:typed_data';
import 'package:assistantwithai/src/constants/assets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class InstructionPersonalizationRoutine {
  Future<String> generatedDataPersonalizationRoutine(Uint8List imageBytes) async {
    final model =
        GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKeyValue);

    //Crea la instrucción
    final prompt = TextPart(
        'En idioma español puedes genera un único contenido, porque eres un entrenador personal de ejericio fisico, y en base a está imagen, que es un equipo de ejericio para entrenar, genera contenido utilizando este esquema JSON:\n\n'
        'Y para el campo availablePhotoEquipment lista los equipos que hay en la imagen o foto.\n'
        'Y para el campo experienceLevel que sea más de unnivel.\n'
        'ContentOptions = {"idContentOptions": string, "exerciseGoal": List<String>, "experienceLevel": List<String>, "desiredDurationOfTheRoutine": List<String>, "availablePhotoEquipment": List<String>}\n'
        'Return: Array<ContentOptions>');

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
    print("recortado: $recortado");
    return recortado;
  }
}
