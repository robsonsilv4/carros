import 'dart:convert';

import 'package:carros/pages/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<Usuario> login(String login, String senha) async {
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

    final user = Usuario.fromJson(mapResponse);

    return user;
  }
}
