import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  final String message;

  TextError({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: Colors.red,
          fontSize: 22,
        ),
      ),
    );
  }
}
