import 'package:carros/widgets/drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  Center _body() {
    return Center(
      child: Text(
        'Robson',
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
