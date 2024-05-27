import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final bool isPassword;

  const InputBox({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: Colors.grey[600]!,
            width: 1.5,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.grey[600],
        ),
        floatingLabelStyle: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      validator: validator,
    );
  }
}