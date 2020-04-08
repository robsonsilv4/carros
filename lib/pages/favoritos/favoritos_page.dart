import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/text_error.dart';
import '../carro/carro.dart';
import '../carro/carros_listview.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<QuerySnapshot>(
      stream: FavoritoService().stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError(message: 'Não foi possível buscar os carros');
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data.documents.map(
          (document) {
            return Carro.fromJson(document.data);
          },
        ).toList();

        return CarrosListView(carros: carros);
      },
    );
  }
}
