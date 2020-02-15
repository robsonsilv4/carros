import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginApi {
  static Future<bool> login(String login, String senha) async {
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

    String nome = mapResponse['nome'];
    String email = mapResponse['email'];

    print('Nome: $nome');
    print('Email: $email');

    return true;
  }
}
