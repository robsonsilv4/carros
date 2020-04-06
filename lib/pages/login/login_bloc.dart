import 'dart:async';

import '../api_response.dart';
import 'login_api.dart';
import 'usuario.dart';

class LoginBloc {
  final _streamController = StreamController<bool>();

  Stream<bool> get stream => _streamController.stream;

  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    _streamController.add(true);
    ApiResponse response = await LoginApi.login(login, senha);
    _streamController.add(false);
    return response;
  }

  void dispose() {
    _streamController.close();
  }
}
