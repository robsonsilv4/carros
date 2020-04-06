import 'package:carros/utils/sql/base_dao.dart';

import '../carro/carro.dart';

class CarroDAO extends BaseDAO<Carro> {
  @override
  String get tableName => 'carro';

  @override
  Carro fromJson(Map<String, dynamic> map) {
    return Carro.fromJson(map);
  }

  Future<List<Carro>> findAllByTipo(String tipo) async {
    return query('select * from $tableName where tipo =? ', [tipo]);
  }
}
