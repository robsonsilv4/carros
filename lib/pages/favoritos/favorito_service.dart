import '../../main.dart';
import '../carro/carro.dart';
import '../carro/carro_dao.dart';
import 'favorito.dart';
import 'favorito_dao.dart';

class FavoritoService {
  static Future<bool> favoritar(Carro carro) async {
    Favorito favorito = Favorito.fromCarro(carro: carro);

    final dao = FavoritoDAO();
    final exists = await dao.exists(carro.id);

    if (exists) {
      dao.delete(carro.id);
      favoritosBloc.fetch();
      return false;
    } else {
      dao.save(favorito);
      favoritosBloc.fetch();
      return true;
    }
  }

  static Future<List<Carro>> getCarros() async {
    List<Carro> carros = await CarroDAO().query(
      'select * from carro c, favorito f where c.id = f.id',
    );
    return carros;
  }

  static Future<bool> isFavorite(Carro carro) async {
    final dao = FavoritoDAO();
    final exists = await dao.exists(carro.id);
    return exists;
  }
}
