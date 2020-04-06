import 'package:carros/utils/sql/base_dao.dart';

import 'favorito.dart';

class FavoritoDAO extends BaseDAO<Favorito> {
  @override
  Favorito fromJson(Map<String, dynamic> map) {
    return null;
  }

  @override
  String get tableName => 'favorito';
}
