import '../../utils/network.dart';
import '../favoritos/carro_dao.dart';
import 'carro.dart';
import 'carro_api.dart';
import 'simple_bloc.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {
  Future<List<Carro>> fetch({String tipo}) async {
    try {
      bool networkOn = await isNetworkon();

      if (!networkOn) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }

      List<Carro> carros = await CarroApi.getCarros(tipo);
      if (carros.isNotEmpty) {
        final dao = CarroDAO();
        // carros.forEach(dao.save);
        carros.forEach((carro) => dao.save(carro));
      }
      add(carros);
      return carros;
    } catch (error, exception) {
      addError(error);
      throw exception;
    }
  }
}
