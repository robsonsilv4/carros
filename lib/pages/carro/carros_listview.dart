import 'package:flutter/material.dart';

import 'carro.dart';
import 'carro_api.dart';

class CarrosListView extends StatefulWidget {
  final String tipo;

  const CarrosListView({@required this.tipo});

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  Widget _body() {
    return FutureBuilder(
      future: CarroApi.getCarros(widget.tipo),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Não foi possível buscar os carros.',
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          List<Carro> carros = snapshot.data;
          return _listView(carros);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _listView(List<Carro> carros) {
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
                          onPressed: () {},
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
}