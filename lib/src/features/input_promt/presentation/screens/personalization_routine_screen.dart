import 'dart:typed_data';
import 'package:assistantwithai/src/common_widgets/loading_custom.dart';
import 'package:assistantwithai/src/common_widgets/outline_button.dart';
import 'package:assistantwithai/src/constants/assets.dart';
import 'package:assistantwithai/src/constants/colors_enviroments.dart';
import 'package:assistantwithai/src/features/input_promt/data/models/content_options.dart';
import 'package:assistantwithai/src/features/input_promt/presentation/widgets/image_preview.dart';
import 'package:assistantwithai/src/features/routine/data/models/routine.dart';
import 'package:assistantwithai/src/features/routine/presentation/screens/routine_screen.dart';
import 'package:assistantwithai/src/features/routine/services/generated_routine_instruction.dart';
import 'package:flutter/material.dart';

class PersonalizationRoutineScreen extends StatelessWidget {
  final List<ContentOptions> contentOptions;
  final Uint8List imageBytes;

  const PersonalizationRoutineScreen({
    super.key,
    required this.contentOptions,
    required this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleLarge?.copyWith(
      color: const Color(colorSecondary),
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('RotinePro IA'),
        backgroundColor: const Color(myColorPrimary),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Personaliza tu Rutina', style: titleStyle),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'para este equipo de entrenamiento',
                        style: titleStyle,
                      ),
                    ),
                    ImagePreview(imageBytes: imageBytes),
                  ],
                ),
                const Text(
                  'Este contenido se ha generado con la IA Generativa de Gemini',
                  style: TextStyle(color: Color(colorSecondary)),
                ),
                Image.asset(personalTraining),
                const SizedBox(height: 20),
                _FormersonalizationRoutine(contentOptions: contentOptions),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormersonalizationRoutine extends StatefulWidget {
  final List<ContentOptions> contentOptions;
  const _FormersonalizationRoutine({
    required this.contentOptions,
  });

  @override
  State<_FormersonalizationRoutine> createState() =>
      __FormersonalizationRoutineState();
}

class __FormersonalizationRoutineState
    extends State<_FormersonalizationRoutine> {
  // Nueva instancia para almacenar las selecciones
  ContentOptions userSelection = ContentOptions(
    idContentOptions: '',
    exerciseGoal: [],
    experienceLevel: [],
    desiredDurationOfTheRoutine: [],
    availablePhotoEquipment: [],
  );
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.bodyLarge
        ?.copyWith(color: color.primary, fontWeight: FontWeight.bold);
    final valueLabelStyle = textTheme.bodyMedium;

    final contentOptions = widget.contentOptions.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nivel de experiencia (DropdownButton)
        Text('Nivel de experiencia', style: labelStyle),
        DropdownButton<String>(
          value: userSelection.experienceLevel.isEmpty
              ? null
              : userSelection.experienceLevel.first,
          hint: Text("Escojamos el nivel", style: valueLabelStyle),
          items: contentOptions.experienceLevel.map((String level) {
            return DropdownMenuItem(
              value: level,
              child: Text(level, style: valueLabelStyle),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              userSelection.experienceLevel = [value ?? ''];
            });
          },
        ),
        const SizedBox(height: 20),

        // Duración deseada de la rutina (ChoiceChip)
        Text('Duración deseada de la rutina', style: labelStyle),
        Wrap(
          spacing: 10,
          children:
              contentOptions.desiredDurationOfTheRoutine.map((String duration) {
            return ChoiceChip(
              label: Text(duration, style: valueLabelStyle),
              selected:
                  userSelection.desiredDurationOfTheRoutine.contains(duration),
              onSelected: (isSelected) {
                setState(() {
                  userSelection.desiredDurationOfTheRoutine =
                      isSelected ? [duration] : [];
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Objetivos del ejercicio (CheckboxListTile)
        Text('Objetivos del ejercicio', style: labelStyle),
        Column(
          children: contentOptions.exerciseGoal.map((String goal) {
            return CheckboxListTile(
              title: Text(goal, style: valueLabelStyle),
              value: userSelection.exerciseGoal.contains(goal),
              onChanged: (bool? isChecked) {
                setState(() {
                  if (isChecked == true) {
                    userSelection.exerciseGoal.add(goal);
                  } else {
                    userSelection.exerciseGoal.remove(goal);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Equipos disponibles (SwitchListTile)
        Text('Equipos disponibles', style: labelStyle),
        Column(
          children:
              contentOptions.availablePhotoEquipment.map((String equipment) {
            final isSelected =
                userSelection.availablePhotoEquipment.contains(equipment);
            return SwitchListTile(
              title: Text(equipment, style: valueLabelStyle),
              value: isSelected,
              onChanged: (bool isChecked) {
                setState(() {
                  if (isChecked) {
                    userSelection.availablePhotoEquipment.add(equipment);
                  } else {
                    userSelection.availablePhotoEquipment.remove(equipment);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        if (isLoading) const LoadingCustom(),
        // Botón para enviar
        Align(
          alignment: Alignment.center,
          child: MyOutlinedButton(
            valueTitle: 'Generar mi rutina con IA',
            onPressed: () {
              _submitForm();
            },
          ),
        ),
      ],
    );
  }

  void _submitForm() async {
    setState(() {
      isLoading = true; // Activa el indicador de carga
    });

    final routineConfirmated = userSelection.toJson();
    final instrucion = GeneratedRoutineInstruction();

    // Llamada asíncrona para obtener el JSON de la rutina
    await instrucion.generatedDataRoutine(routineConfirmated);

    setState(() {
      isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RoutineScreen(
            routine: Routine(
              goal: userSelection.exerciseGoal,
              exercises: [],
            ),
          );
        },
      ),
    );
  }
}
