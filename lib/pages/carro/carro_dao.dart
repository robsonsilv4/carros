import 'package:carros/utils/sql/base_dao.dart';

import '../carro/carro.dart';

class CarroDAO extends BaseDAO<Carro> {
  @override
  String get tableName => 'carros';

  @override
  Carro fromJson(Map<String, dynamic> map) {
    return Carro.fromJson(map);
  }

  Future<List<Carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient
        .rawQuery('select * from $tableName where tipo =? ', [tipo]);

    return list.map<Carro>((json) => fromJson(json)).toList();
  }
}
