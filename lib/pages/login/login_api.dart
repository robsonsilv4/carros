import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_response.dart';
import 'usuario.dart';

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      final url = 'https://carros-springboot.herokuapp.com/api/v2/login';

      final Map<String, String> headers = {
        'Context-Type': 'application/json',
      };

      final params = {
        'username': login,
        'password': senha,
      };

      final String string = jsonEncode(params);

      final response = await http.post(
        url,
        headers: headers,
        body: string,
      );

      Map mapResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);

        user.save();

        return ApiResponse.ok(result: user);
      }

      return ApiResponse.error(message: mapResponse['error']);
    } catch (e) {
      return ApiResponse.error(
        message: 'Não foi possível fazer o login',
      );
    }
  }
}
