import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future push(context, page) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}
