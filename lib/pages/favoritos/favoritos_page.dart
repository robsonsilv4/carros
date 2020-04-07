import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../carro/carro.dart';
import '../carro/carros_listview.dart';
import 'favoritos_model.dart';

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
    FavoritosModel model = Provider.of<FavoritosModel>(context, listen: false);
    model.getCarros();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    FavoritosModel model = Provider.of<FavoritosModel>(context);

    List<Carro> carros = model.carros;

    if (carros.isEmpty) {
      return Center(
        child: Text(
          "Nenhum carro nos favoritos.",
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CarrosListView(carros: carros),
    );
  }

  Future<void> _onRefresh() {
    return Provider.of<FavoritosModel>(context, listen: false).getCarros();
  }
}
