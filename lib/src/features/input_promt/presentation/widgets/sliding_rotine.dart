import 'dart:typed_data';
import 'package:assistantwithai/src/features/input_promt/presentation/widgets/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:assistantwithai/src/features/input_promt/data/models/content_options.dart';

class SlidingRoutine extends StatefulWidget {
  final List<ContentOptions> contentOptions;
  final Uint8List imageBytes;

  const SlidingRoutine({
    super.key,
    required this.contentOptions,
    required this.imageBytes,
  });

  @override
  State<SlidingRoutine> createState() => _SlidingRoutineState();
}

class _SlidingRoutineState extends State<SlidingRoutine> {
  // Variables para almacenar las selecciones del usuario
  String? selectedExperienceLevel;
  String? selectedDuration;
  List<String> selectedGoals = [];
  List<String> selectedEquipment = [];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final contentOptions = widget.contentOptions.first;
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    final labelStyle = textTheme.bodyLarge
        ?.copyWith(color: color.primary, fontWeight: FontWeight.bold);
    final valueLabelStyle = textTheme.bodyMedium;

    return Container(
      padding: const EdgeInsets.all(20),
      height: height * 0.9,
      width: width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //encabezado
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                const Text(
                  'Personaliza tu Rutina',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'para este equipo de entrenamiento',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ImagePreview(imageBytes: widget.imageBytes),
              ],
            ),
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
              child: OutlinedButton(
                onPressed: () {
                  _submitForm();
                },
                child: const Text('Guardar Rutina'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    // Aquí puedes manejar el envío de datos
    debugPrint('Nivel de experiencia: $selectedExperienceLevel');
    debugPrint('Duración deseada: $selectedDuration');
    debugPrint('Objetivos seleccionados: $selectedGoals');
    debugPrint('Equipos seleccionados: $selectedEquipment');

    // Puedes mostrar un diálogo de confirmación al usuario
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rutina Personalizada'),
        content: Text(
          'Tu rutina ha sido personalizada con éxito.\n'
          'Nivel de experiencia: $selectedExperienceLevel\n'
          'Duración: $selectedDuration\n'
          'Objetivos: ${selectedGoals.join(', ')}\n'
          'Equipos: ${selectedEquipment.join(', ')}',
        ),
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
