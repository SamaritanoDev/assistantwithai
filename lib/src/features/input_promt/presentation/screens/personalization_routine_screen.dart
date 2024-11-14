import 'dart:typed_data';
import 'package:assistantwithai/src/common_widgets/outline_button.dart';
import 'package:assistantwithai/src/features/image_upload/data/models/image_upload.dart';
import 'package:assistantwithai/src/features/image_upload/services/instruction_promt.dart';
import 'package:assistantwithai/src/features/input_promt/data/models/content_options.dart';
import 'package:assistantwithai/src/features/input_promt/presentation/widgets/sliding_rotine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalizationRoutineScreen extends StatefulWidget {
  final Uint8List imageBytes;
  // final PlatformFile file;
  const PersonalizationRoutineScreen({
    super.key,
    required this.imageBytes,
    // required this.file,
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
    debugPrint(
        "imageUpload desde PersonalizationRoutineScreen: ${imageUpload.fileBytes}");

    // Imprimir los valores de contendOptions
    for (var option in contendOptions) {
      debugPrint("idContentOptions: ${option.idContentOptions}");
      ("exerciseGoal: ${option.exerciseGoal}");
      ("experienceLevel: ${option.experienceLevel}");
      ("desiredDurationOfTheRoutine: ${option.desiredDurationOfTheRoutine}");
      ("availablePhotoEquipment: ${option.availablePhotoEquipment}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personaliza tu Rutina'),
        backgroundColor: color.primary,
      ),
      body: Center(
        child: Column(
          children: [
            Image.memory(
              widget.imageBytes,
              fit: BoxFit.contain,
              height: 300,
            ),
            const SizedBox(height: 30),
            MyOutlinedButton(
              onPressed: () {
                // _generatedContendPersonalizationRoutine();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const SlidingRoutine(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
