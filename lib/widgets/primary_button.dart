import 'package:flutter/material.dart';

import '../constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primary),
        overlayColor: MaterialStateProperty.all(darkGray.withOpacity(0.2)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 56.0, vertical: 12.0)),
      ),
      onPressed: onPressed,
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: black,
          letterSpacing: 1.1,
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
