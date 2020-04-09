import 'dart:convert';
import 'dart:io';

import '../../utils/http_helper.dart' as http;
import '../../utils/upload_service.dart';
import '../api_response.dart';
import 'carro.dart';

class TipoCarro {
  static final String classicos = 'classicos';
  static final String esportivos = 'esportivos';
  static final String luxo = 'luxo';
}

class CarroApi {
  static bool fake = true;

  static Future<List<Carro>> getCarros(String tipo, int page) async {
    if (fake) {
      if (page == 0) {
        tipo = 'classicos';
      } else if (page == 1) {
        tipo = 'esportivos';
      } else if (page == 2) {
        tipo = 'luxo';
      } else {
        return [];
      }
    }

    final url =
        'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';

    final response = await http.get(url);

    final json = response.body;

    List list = jsonDecode(json);

    List<Carro> carros = list
        .map<Carro>(
          (map) => Carro.fromJson(map),
        )
        .toList();

    return carros;
  }

  static Future<ApiResponse> save(Carro carro, File file) async {
    try {
      if (file != null) {
        ApiResponse<String> response = await UploadService.upload(file);
        if (response.ok) {
          String urlFoto = response.result;
          carro.urlFoto = urlFoto;
        }
      }

      String url = 'https://carros-springboot.herokuapp.com/api/v1/carros';
      if (carro.id != null) {
        url += '/${carro.id}';
      }

      String json = carro.toJsonString();

      final response = await (carro.id == null
          ? http.post(url, body: json)
          : http.put(url, body: json));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.ok();
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error(message: 'Não foi possível salvar o carro.');
      }

      Map mapResponse = jsonDecode(response.body);

      return ApiResponse.error(message: mapResponse['error']);
    } catch (error) {
      return ApiResponse.error(message: 'Não foi possível salvar o carro.');
    }
  }

  static Future<ApiResponse> delete(Carro carro) async {
    try {
      final url =
          'https://carros-springboot.herokuapp.com/api/v1/carros/${carro.id}';

      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return ApiResponse.ok();
      }

      return ApiResponse.error(message: 'Não foi possível remover o carro.');
    } catch (error) {
      print(error);
      return ApiResponse.error(message: 'Não foi possível remover o carro.');
    }
  }
}
