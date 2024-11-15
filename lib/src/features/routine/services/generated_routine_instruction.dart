import 'dart:async';
import 'package:assistantwithai/src/constants/assets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeneratedRoutineInstruction {
  Future<String> generatedDataRoutine(Map<String, dynamic> userRoutine) async {
    final model = GenerativeModel(
        model: 'gemini-1.5-pro',
        apiKey: apiKeyValue,
        generationConfig:
            GenerationConfig(responseMimeType: 'application/json'));
    print("userRoutine: $userRoutine");
    //Crea la instrucción
    final prompt =
        'En idioma español, puedes generar una rutina completa en base a estás elecciones que hizo el usuario $userRoutine, '
        'porque eres un entrenador personal de ejericio fisico, genera contenido utilizando este esquema JSON:\n\n'
        'Ordena cada rutina por objetivo goal con su resectivo ejercicio\n'
        'y el camo time que salga en minutos\n'
        'Routine = {"goal": string, "exercises": ["name": String, "reps": String, "time": String, "recommendationsExercise": List<String>]}\n'
        'Return: Array<Routine>';

    final response = await model.generateContent([Content.text(prompt)]);

    final cleanedResponse = _cleanResponse(response.text!);
    print('cleanedResponse: $cleanedResponse');

    return cleanedResponse;
  }

  static String _cleanResponse(String response) {
    final firstCorchete = response.indexOf('[');
    final lastCorchete = response.lastIndexOf(']');
    String recortado = response.substring(firstCorchete, lastCorchete + 1);
    return recortado;
  }
}
