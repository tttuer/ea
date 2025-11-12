import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  final String labelText;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final bool obscureText;

  const CustomInputText({
    super.key,
    required this.obscureText,
    required this.labelText,
    this.prefixIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
