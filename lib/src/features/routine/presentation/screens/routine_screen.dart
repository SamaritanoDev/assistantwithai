import 'package:assistantwithai/src/constants/constants.dart';
import 'package:assistantwithai/src/features/routine/data/models/routine.dart';
import 'package:flutter/material.dart';

class RoutineScreen extends StatelessWidget {
  final Routine routine;
  const RoutineScreen({
    super.key,
    required this.routine,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Tu rutina de ejercicio"),
        backgroundColor: const Color(myColorPrimary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tus Objetivos:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(routine.goal),
              avatar: const Icon(Icons.check_circle, color: Colors.green),
              backgroundColor: Colors.blue.shade100,
            ),
            const SizedBox(height: 16),
            const Divider(),
            const Text(
              "Ejercicios:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: routine.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = routine.exercises[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ExpansionTile(
                      leading:
                          const Icon(Icons.fitness_center, color: Colors.blue),
                      title: Text(
                        exercise.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text("Repeticiones: ${exercise.reps}"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.timer, color: Colors.green),
                                  const SizedBox(width: 8),
                                  Text("Tiempo estimado: ${exercise.time}"),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Recomendaciones:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8.0,
                                children: exercise.recommendationsExercise
                                    .map((recommendation) {
                                  return Chip(
                                    avatar: const Icon(Icons.lightbulb,
                                        color: Colors.orange),
                                    label: Text(recommendation),
                                    backgroundColor: Colors.orange.shade100,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            ElevatedButton.icon(
              onPressed: () {
                // Acción al finalizar la rutina
              },
              icon: const Icon(Icons.check),
              label: const Text("Completar Rutina"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
