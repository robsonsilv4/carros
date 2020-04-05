import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/nav.dart';
import 'carro.dart';
import 'carro_api.dart';
import 'carro_page.dart';

class CarrosListView extends StatefulWidget {
  final String tipo;

  const CarrosListView({@required this.tipo});

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<Carro> carros;

  final _streamController = StreamController<List<Carro>>();

  @override
  bool get wantKeepAlive => true;

  _loadCarros() async {
    List<Carro> carros = await CarroApi.getCarros(widget.tipo);
    _streamController.add(carros);
  }

  @override
  void initState() {
    super.initState();

    _loadCarros();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _streamController.stream,
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
                          onPressed: () => _onClickCarro(carro: carro),
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

  _onClickCarro({Carro carro}) {
    push(context, CarroPage(carro: carro));
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }
}
