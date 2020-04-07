import 'package:flutter/material.dart';

import '../carro/carro.dart';
import 'favorito_service.dart';

class FavoritosModel extends ChangeNotifier {
  List<Carro> carros = [];

  Future<List<Carro>> getCarros() async {
    carros = await FavoritoService.getCarros();

    notifyListeners();

    return carros;
  }
}
