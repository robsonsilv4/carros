import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_response.dart';
import '../login/usuario.dart';
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

    return carros;
  }

  static Future<ApiResponse<bool>> save(Carro carro) async {
    try {
      Usuario user = await Usuario.get();

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.token}',
      };

      String url = 'https://carros-springboot.herokuapp.com/api/v2/carros';
      if (carro.id != null) {
        url += '/${carro.id}';
      }

      String json = carro.toJsonString();

      final response = await (carro.id == null
          ? http.post(
              url,
              body: json,
              headers: headers,
            )
          : http.put(
              url,
              body: json,
              headers: headers,
            ));

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map mapResponse = jsonDecode(response.body);

        Carro carro = Carro.fromJson(mapResponse);
        print(carro.id);

        return ApiResponse.ok(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error('Não foi possível salvar o carro');
      }

      Map mapResponse = jsonDecode(response.body);

      return ApiResponse.error(mapResponse['error']);
    } catch (error) {
      print(error);
      return ApiResponse.error('Não foi possível salvar o carro');
    }
  }

  static Future<ApiResponse<bool>> delete(Carro carro) async {
    try {
      Usuario user = await Usuario.get();

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.token}',
      };

      String url =
          'https://carros-springboot.herokuapp.com/api/v2/carros/${carro.id}';

      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        return ApiResponse.ok(true);
      }

      return ApiResponse.error('Não foi possível remover o carro.');
    } catch (error) {
      print(error);
      return ApiResponse.error('Não foi possível remover o carro.');
    }
  }
}
