import 'package:flutter/material.dart';

import '../../utils/nav.dart';
import 'carro.dart';
import 'carro_page.dart';

class CarrosListView extends StatelessWidget {
  final List<Carro> carros;

  CarrosListView({@required this.carros});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          Carro carro = carros[index];

          return Card(
            color: Colors.grey.shade100,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      carro.urlFoto ??
                          'http://www.livroandroid.com.br/livro/carros/esportivos/BMW.png',
                      width: 150.0,
                    ),
                  ),
                  Text(
                    carro.nome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    carro.nome,
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonBarTheme(
                    data: ButtonBarTheme.of(context),
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickCarro(
                            context: context,
                            carro: carro,
                          ),
                        ),
                        FlatButton(
                          child: const Text('COMPARTILHAR'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro({BuildContext context, Carro carro}) {
    push(context, CarroPage(carro: carro));
  }
}
