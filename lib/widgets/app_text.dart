import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String label;
  final String hint;
  final bool password;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final FormFieldValidator<String> validator;

  AppText(
    this.label,
    this.hint, {
    this.password = false,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: 20,
        color: Colors.red,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
        hintStyle: TextStyle(fontSize: 16),
        /* border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ), */
      ),
      obscureText: password,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      validator: validator,
    );
  }
}
