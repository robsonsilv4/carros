import 'package:flutter/material.dart';

import '../../widgets/text.dart';
import 'carro.dart';

class CarroPage extends StatelessWidget {
  final Carro carro;

  CarroPage({@required this.carro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
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
          Image.network(carro.urlFoto),
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
            text(carro.nome, fontSize: 20.0, bold: true),
            text(carro.tipo, fontSize: 16.0),
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
        text(carro.descricao, fontSize: 16.0, bold: true),
        SizedBox(height: 20.0),
        text(
          'Mussum Ipsum, cacilds vidis litro abertis. Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis. Praesent vel viverra nisi. Mauris aliquet nunc non turpis scelerisque, eget. A ordem dos tratores não altera o pão duris. Nullam volutpat risus nec leo commodo, ut interdum diam laoreet. Sed non consequat odio. In elementis mé pra quem é amistosis quis leo. Manduma pindureta quium dia nois paga. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Pra lá , depois divoltis porris, paradis. Diuretics paradis num copo é motivis de denguis. Sapien in monti palavris qui num significa nadis i pareci latim. Aenean aliquam molestie leo, vitae iaculis nisl.',
          fontSize: 16.0,
        ),
      ],
    );
  }
}
