import 'dart:convert';

import 'package:carros/pages/favoritos/carro_dao.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

import 'carro.dart';

class TipoCarro {
  static final String classicos = 'classicos';
  static final String esportivos = 'esportivos';
  static final String luxo = 'luxo';
}

class CarroApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario user = await Usuario.get();

    final Map<String, String> headers = {
      'Context-Type': 'application/json',
      'Authorization': 'Bearer ${user.token}',
    };
    print(headers);

    String url =
        'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';
    print("GET: $url");

    final response = await http.get(url, headers: headers);
    final json = response.body;

    // List<Map<String, dynamic>>
    List list = jsonDecode(json);

    List<Carro> carros = list
        .map<Carro>(
          (map) => Carro.fromJson(map),
        )
        .toList();

    final dao = CarroDAO();
    // carros.forEach(dao.save);
    carros.forEach((carro) => dao.save(carro));

    return carros;
  }
}
