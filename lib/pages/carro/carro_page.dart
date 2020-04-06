import 'package:flutter/material.dart';

import '../../widgets/text.dart';
import 'carro.dart';
import 'loripsum_api.dart';

class CarroPage extends StatefulWidget {
  final Carro carro;

  CarroPage({@required this.carro});

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final LoripsumBloc _loripsumBloc = LoripsumBloc();

  @override
  void initState() {
    super.initState();
    _loripsumBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: _onClickPopupMenu,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'Editar',
                  child: Text('Editar'),
                ),
                PopupMenuItem(
                  value: 'Deletar',
                  child: Text('Deletar'),
                ),
                PopupMenuItem(
                  value: 'Compartilhar',
                  child: Text('Compartilhar'),
                ),
              ];
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          Image.network(widget.carro.urlFoto),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(widget.carro.nome, fontSize: 20.0, bold: true),
            text(widget.carro.tipo, fontSize: 16.0),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 40.0,
              ),
              onPressed: _onClickFavorito,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 40.0,
              ),
              onPressed: _onClickCompartilhar,
            ),
          ],
        ),
      ],
    );
  }

  _onClickPopupMenu(String value) {
    switch (value) {
      case 'Editar':
        print('Editar');
        break;
      case 'Deletar':
        print('Deletar');
        break;
      case 'Compartilhar':
        print('Compartilhar');
        break;
    }
  }

  _onClickMapa() {}

  _onClickVideo() {}

  void _onClickFavorito() {}

  void _onClickCompartilhar() {}

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        text(widget.carro.descricao, fontSize: 16.0, bold: true),
        SizedBox(height: 20.0),
        StreamBuilder<String>(
          stream: _loripsumBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return text(
              snapshot.data,
              fontSize: 16.0,
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _loripsumBloc.dispose();
  }
}
