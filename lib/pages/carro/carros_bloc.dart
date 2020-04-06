import 'package:carros/pages/carro/simple_bloc.dart';

import 'carro.dart';
import 'carro_api.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {
  Future<List<Carro>> fetch({String tipo}) async {
    try {
      List<Carro> carros = await CarroApi.getCarros(tipo);
      add(carros);
      return carros;
    } catch (error, exception) {
      addError(error);
      throw exception;
    }
  }
}
