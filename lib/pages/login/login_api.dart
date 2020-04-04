import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_response.dart';
import 'usuario.dart';

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';
      final Map<String, String> headers = {
        'Context-Type': 'application/json',
      };
      final params = {
        'username': login,
        'password': senha,
      };

      final String s = json.encode(params);

      var response = await http.post(url, headers: headers, body: s);

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);
        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse['error']);
    } catch (e, exception) {
      print('Erro no login: $e - $exception');
      return ApiResponse.error(
        'Não foi possível fazer o login',
      );
    }
  }
}
