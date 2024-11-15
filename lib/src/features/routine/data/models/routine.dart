import 'dart:convert';

Routine routineFromJson(String str) => Routine.fromJson(json.decode(str));

String routineToJson(Routine data) => json.encode(data.toJson());

class Routine {
  List<String> goal;
  List<Exercise> exercises;

  Routine({
    required this.goal,
    required this.exercises,
  });

  factory Routine.fromJson(Map<String, dynamic> json) => Routine(
        goal: List<String>.from(json["goal"].map((x) => x)),
        exercises: List<Exercise>.from(
            json["exercises"].map((x) => Exercise.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "goal": List<dynamic>.from(goal.map((x) => x)),
        "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
      };
}

class Exercise {
  String name;
  String reps;
  String time;
  List<String> recommendationsExercise;

  Exercise({
    required this.name,
    required this.reps,
    required this.time,
    required this.recommendationsExercise,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        name: json["name"],
        reps: json["reps"],
        time: json["time"],
        recommendationsExercise:
            List<String>.from(json["recommendationsExercise"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "reps": reps,
        "time": time,
        "recommendationsExercise":
            List<dynamic>.from(recommendationsExercise.map((x) => x)),
      };
}
