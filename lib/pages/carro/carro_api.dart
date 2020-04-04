import 'dart:convert';

import 'package:http/http.dart' as http;

import 'carro.dart';

class CarroApi {
  static Future<List<Carro>> getCarros() async {
    final url = 'https://carros-springboot.herokuapp.com/api/v1/carros/';
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
