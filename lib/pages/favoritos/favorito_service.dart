import '../carro/carro.dart';
import 'favorito.dart';
import 'favorito_dao.dart';

class FavoritoService {
  static favoritar(Carro carro) async {
    Favorito favorito = Favorito.fromCarro(carro: carro);

    final dao = FavoritoDAO();
    final exists = await dao.exists(carro.id);

    if (exists) {
      dao.delete(carro.id);
    } else {
      dao.save(favorito);
    }
  }

  static List<Carro> getCarros() {
    List<Carro> carros = [];
    return carros;
  }
}
