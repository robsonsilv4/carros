import 'package:flutter/material.dart';

import 'carro.dart';

class CarroPage extends StatelessWidget {
  final Carro carro;

  CarroPage({@required this.carro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Image.network(carro.urlFoto),
    );
  }
}
