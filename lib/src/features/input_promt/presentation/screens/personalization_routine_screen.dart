import 'dart:typed_data';
import 'package:assistantwithai/src/common_widgets/outline_button.dart';
import 'package:assistantwithai/src/constants/assets.dart';
import 'package:assistantwithai/src/constants/colors_enviroments.dart';
import 'package:assistantwithai/src/features/input_promt/data/models/content_options.dart';
import 'package:assistantwithai/src/features/input_promt/presentation/widgets/image_preview.dart';
import 'package:flutter/material.dart';

class PersonalizationRoutineScreen extends StatefulWidget {
  final List<ContentOptions> contentOptions;
  final Uint8List imageBytes;

  const PersonalizationRoutineScreen({
    super.key,
    required this.contentOptions,
    required this.imageBytes,
  });

  @override
  State<PersonalizationRoutineScreen> createState() =>
      _PersonalizationRoutineScreenState();
}

class _PersonalizationRoutineScreenState
    extends State<PersonalizationRoutineScreen> {
  // Variables para almacenar las selecciones del usuarios
  String? selectedExperienceLevel;
  String? selectedDuration;
  List<String> selectedGoals = [];
  List<String> selectedEquipment = [];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final contentOptions = widget.contentOptions.first;

    final labelStyle = textTheme.bodyLarge
        ?.copyWith(color: color.primary, fontWeight: FontWeight.bold);
    final valueLabelStyle = textTheme.bodyMedium;
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
                    ImagePreview(imageBytes: widget.imageBytes),
                  ],
                ),
                const Text(
                  'Este contenido se ha generado con la IA Generativa de Gemini',
                  style: TextStyle(color: Color(colorSecondary)),
                ),
                Image.asset(personalTraining),
                const SizedBox(height: 20),
                // Nivel de experiencia (DropdownButton)
                Text('Nivel de experiencia', style: labelStyle),
                DropdownButton<String>(
                  value: selectedExperienceLevel,
                  hint: Text("Escojamos el nivel", style: valueLabelStyle),
                  items: contentOptions.experienceLevel.map((String level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(level, style: valueLabelStyle),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedExperienceLevel = value;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Duración deseada de la rutina (ChoiceChip)
                Text('Duración deseada de la rutina', style: labelStyle),
                Wrap(
                  spacing: 10,
                  children: contentOptions.desiredDurationOfTheRoutine
                      .map((String duration) {
                    return ChoiceChip(
                      label: Text(duration, style: valueLabelStyle),
                      selected: selectedDuration == duration,
                      onSelected: (isSelected) {
                        setState(() {
                          selectedDuration = isSelected ? duration : null;
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
                      value: selectedGoals.contains(goal),
                      onChanged: (bool? isChecked) {
                        setState(() {
                          if (isChecked == true) {
                            selectedGoals.add(goal);
                          } else {
                            selectedGoals.remove(goal);
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
                  children: contentOptions.availablePhotoEquipment
                      .map((String equipment) {
                    final isSelected = selectedEquipment.contains(equipment);
                    return SwitchListTile(
                      title: Text(equipment, style: valueLabelStyle),
                      value: isSelected,
                      onChanged: (bool isChecked) {
                        setState(() {
                          if (isChecked) {
                            selectedEquipment.add(equipment);
                          } else {
                            selectedEquipment.remove(equipment);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // Botón para enviar
                Align(
                  alignment: Alignment.center,
                  child: MyOutlinedButton(
                    valueTitle: 'Generar mi rutina con IA',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
