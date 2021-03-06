import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/alert.dart';
import '../../utils/nav.dart';
import '../../widgets/text.dart';
import '../api_response.dart';
import '../favoritos/favorito_service.dart';
import 'carro.dart';
import 'carro_api.dart';
import 'carro_form_page.dart';
import 'loripsum_api.dart';
import 'mapa_page.dart';
import 'video_page.dart';

class CarroPage extends StatefulWidget {
  final Carro carro;

  CarroPage({@required this.carro});

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final LoripsumBloc _loripsumBloc = LoripsumBloc();

  Color color = Colors.grey;

  Carro get carro => widget.carro;

  @override
  void initState() {
    super.initState();

    FavoritoService().isFavorito(carro).then(
      (bool favorito) {
        setState(() {
          color = favorito ? Colors.red : Colors.grey;
        });
      },
    );

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
            onPressed: () => _onClickMapa(context),
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () => _onClickVideo(context),
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
          CachedNetworkImage(
            imageUrl: widget.carro.urlFoto ??
                'http://www.livroandroid.com.br/livro/carros/esportivos/BMW.png',
          ),
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
                color: color,
                size: 40.0,
              ),
              onPressed: () => _onClickFavorito(),
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
        push(
          context,
          CarroFormPage(carro: carro),
        );
        break;
      case 'Deletar':
        deletar();
        break;
      case 'Compartilhar':
        print('Compartilhar');
        break;
    }
  }

  _onClickMapa(BuildContext context) {
    if (carro.latitude != null && carro.longitude != null) {
      push(context, MapaPage(carro: carro));
    }

    alert(context, 'Este carro não possuí coordenadas.');
  }

  _onClickVideo(context) {
    if (carro.urlVideo != null && carro.urlVideo.isNotEmpty) {
      // launch(carro.urlVideo);
      push(context, VideoPage(carro: carro));
    }

    alert(context, 'Este carro não possuí um vídeo.');
  }

  void _onClickFavorito() async {
    bool favorito = await FavoritoService().favoritar(carro);
    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

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

  void deletar() async {
    ApiResponse<bool> response = await CarroApi.delete(carro);

    if (response.ok) {
      alert(context, 'Carro removido com sucesso!', callback: () {
        pop(context);
      });
    } else {
      alert(context, response.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _loripsumBloc.dispose();
  }
}
