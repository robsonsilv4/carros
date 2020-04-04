import 'dart:convert';

import 'package:http/http.dart' as http;

import 'carro.dart';

class TipoCarro {
  static final String classicos = 'classicos';
  static final String esportivos = 'esportivos';
  static final String luxo = 'luxo';
}

class CarroApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    String url = 'http://livrowebservices.com.br/rest/carros/tipo/$tipo';
    print("GET: $url");

    final response = await http.get(url);
    final json = response.body;

    // List<Map<String, dynamic>>
    final list = jsonDecode(json).cast<Map<String, dynamic>>();

    final carros = list
        .map<Carro>(
          (map) => Carro.fromJson(map),
        )
        .toList();

    return carros;
  }
}
