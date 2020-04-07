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
  static Future<List<Carro>> getCarros(String tipo) async {
    String url =
        'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';
    print("GET: $url");

    final response = await http.get(url);
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

  static Future<ApiResponse<bool>> save(Carro carro, File file) async {
    try {
      if (file != null) {
        ApiResponse<String> response = await UploadService.upload(file);
        if (response.ok) {
          String urlFoto = response.result;
          carro.urlFoto = urlFoto;
        }
      }

      String url = 'https://carros-springboot.herokuapp.com/api/v2/carros';
      if (carro.id != null) {
        url += '/${carro.id}';
      }

      String json = carro.toJsonString();

      final response = await (carro.id == null
          ? http.post(url, body: json)
          : http.put(url, body: json));

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
      String url =
          'https://carros-springboot.herokuapp.com/api/v2/carros/${carro.id}';

      final response = await http.delete(url);

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
