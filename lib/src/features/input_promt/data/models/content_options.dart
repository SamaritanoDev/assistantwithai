class ContentOptions {
  String idContentOptions;
  List<String> exerciseGoal;
  List<String> experienceLevel;
  List<String> desiredDurationOfTheRoutine;
  List<String> availablePhotoEquipment;

  ContentOptions({
    required this.idContentOptions,
    required this.exerciseGoal,
    required this.experienceLevel,
    required this.desiredDurationOfTheRoutine,
    required this.availablePhotoEquipment,
  });

  factory ContentOptions.fromJson(Map<String, dynamic> json) => ContentOptions(
        idContentOptions: json["idContentOptions"],
        exerciseGoal: List<String>.from(json["exerciseGoal"].map((x) => x)),
        experienceLevel:
            List<String>.from(json["experienceLevel"].map((x) => x)),
        desiredDurationOfTheRoutine: List<String>.from(
            json["desiredDurationOfTheRoutine"].map((x) => x)),
        availablePhotoEquipment:
            List<String>.from(json["availablePhotoEquipment"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "idContentOptions": idContentOptions,
        "exerciseGoal": List<dynamic>.from(exerciseGoal.map((x) => x)),
        "experienceLevel": List<dynamic>.from(experienceLevel.map((x) => x)),
        "desiredDurationOfTheRoutine":
            List<dynamic>.from(desiredDurationOfTheRoutine.map((x) => x)),
        "availablePhotoEquipment":
            List<dynamic>.from(availablePhotoEquipment.map((x) => x)),
      };
}
