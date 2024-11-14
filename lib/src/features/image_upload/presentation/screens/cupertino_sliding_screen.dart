import 'package:flutter/cupertino.dart';

class CupertinoSlidingScreen extends StatelessWidget {
  const CupertinoSlidingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Sliding Screen'),
      ),
      child: Center(
        child: CupertinoButton.filled(
          child: const Text('Mostrar pantalla deslizable'),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                title: const Text('Desliza hacia abajo para cerrar'),
                message:
                    const Text('Esta es una pantalla deslizable estilo iOS.'),
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Opción 1'),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Opción 2'),
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isDefaultAction: true,
                  child: const Text('Cancelar'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
