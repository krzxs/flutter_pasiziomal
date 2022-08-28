import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {Key? key, required this.controller, this.onSubmitted, this.focusNode})
      : super(key: key);

  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Wpisz składnik...',
        hintStyle: const TextStyle(
          color: lightGray,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: darkGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: primary,
            width: 2.0,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      ),
      cursorColor: primary,
      style: const TextStyle(
        color: black,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.send,
    );
  }
}
