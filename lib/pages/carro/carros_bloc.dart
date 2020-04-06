import 'dart:async';

import 'carro.dart';
import 'carro_api.dart';

class CarrosBloc {
  final _streamController = StreamController<List<Carro>>();

  Stream<List<Carro>> get stream => _streamController.stream;

  fetch({String tipo}) async {
    try {
      List<Carro> carros = await CarroApi.getCarros(tipo);
      _streamController.add(carros);
    } catch (error) {
      _streamController.addError(error);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
