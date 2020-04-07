import 'package:flutter/material.dart';

import '../../main.dart';
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
    favoritosBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: favoritosBloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError(
            message: 'Não foi possível buscar os carros.',
          );
        }

        if (snapshot.hasData) {
          List<Carro> carros = snapshot.data;
          return RefreshIndicator(
            child: CarrosListView(carros: carros),
            onRefresh: _onRefresh,
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return favoritosBloc.fetch();
  }
}
