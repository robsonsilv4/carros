import '../carro/carro.dart';
import '../carro/simple_bloc.dart';
import 'favorito_service.dart';

class FavoritosBloc extends SimpleBloc<List<Carro>> {
  Future<List<Carro>> fetch() async {
    try {
      List<Carro> carros = await FavoritoService.getCarros();
      add(carros);
      return carros;
    } catch (error, exception) {
      addError(error);
      throw exception;
    }
  }
}
