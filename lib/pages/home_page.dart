import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
      ),
      body: Center(
        child: Text(
          'Robson',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
