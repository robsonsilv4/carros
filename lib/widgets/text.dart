import 'package:flutter/material.dart';

Text text(
  String string, {
  double fontSize = 16,
  color = Colors.black,
  bold = false,
}) {
  return Text(
    string ?? '',
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
