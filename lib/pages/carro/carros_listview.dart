import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../utils/nav.dart';
import 'carro.dart';
import 'carro_page.dart';

class CarrosListView extends StatelessWidget {
  final List<Carro> carros;
  final ScrollController scrollController;
  final bool showProgress;

  CarrosListView({
    @required this.carros,
    this.scrollController,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: ListView.builder(
        controller: scrollController,
        itemCount: showProgress ? carros.length + 1 : carros.length,
        itemBuilder: (context, index) {
          if (showProgress && carros.length == index) {
            return Center(
              child: Container(
                height: 100.0,
                child: CircularProgressIndicator(),
              ),
            );
          }

          Carro carro = carros[index];

          return InkWell(
            onTap: () => _onClickCarro(
              context: context,
              carro: carro,
            ),
            onLongPress: () => _onLongClickCarro(
              context: context,
              carro: carro,
            ),
            child: Card(
              color: Colors.grey.shade100,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: carro.urlFoto ??
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
                            onPressed: () {
                              _onClickShare();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

  _onLongClickCarro({BuildContext context, Carro carro}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                carro.nome,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Detalhes'),
              onTap: () {
                // pop(context);
                _onClickCarro(
                  context: context,
                  carro: carro,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Compartilhar'),
              onTap: () {
                // pop(context);
                _onClickShare(
                  context: context,
                  carro: carro,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _onClickShare({BuildContext context, Carro carro}) {
    print(carro.nome);
    Share.share(carro.urlFoto);
  }
}
