import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../carro/carro.dart';
import '../carro/carro_dao.dart';
import 'favorito.dart';
import 'favorito_dao.dart';
import 'favoritos_model.dart';

class FavoritoService {
  static Future<bool> favoritar(BuildContext context, Carro carro) async {
    Favorito favorito = Favorito.fromCarro(carro: carro);

    final dao = FavoritoDAO();
    final exists = await dao.exists(carro.id);

    if (exists) {
      dao.delete(carro.id);
      Provider.of<FavoritosModel>(context, listen: false).getCarros();
      return false;
    } else {
      dao.save(favorito);
      Provider.of<FavoritosModel>(context, listen: false).getCarros();
      return true;
    }
  }

  static Future<List<Carro>> getCarros() async {
    List<Carro> carros = await CarroDAO().query(
      'select * from carro c, favorito f where c.id = f.id',
    );
    return carros;
  }

  static Future<bool> isFavorito(Carro carro) async {
    final dao = FavoritoDAO();
    bool exists = await dao.exists(carro.id);
    return exists;
  }
}
