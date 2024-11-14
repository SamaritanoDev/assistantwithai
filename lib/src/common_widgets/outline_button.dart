import 'package:flutter/material.dart';

class MyOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
 
  const MyOutlinedButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textButtonStyle =
        textTheme.bodyLarge?.copyWith(color: color.tertiary);

    return OutlinedButton.icon(
      onPressed : onPressed, 
      label: Text('Generar contenido', style: textButtonStyle),
      style: OutlinedButton.styleFrom(
        backgroundColor: color.secondary,
        side: BorderSide(color: color.primary),
        minimumSize: const Size(300, 50),
      ),
    );
  }
}
