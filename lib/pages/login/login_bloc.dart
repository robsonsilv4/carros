import 'dart:async';

import '../api_response.dart';
import '../carro/simple_bloc.dart';
import 'login_api.dart';
import 'usuario.dart';

class LoginBloc {
  final buttonBloc = SimpleBloc<bool>();

  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    buttonBloc.add(true);
    ApiResponse response = await LoginApi.login(login, senha);
    buttonBloc.add(false);
    return response;
  }

  void dispose() {
    buttonBloc.dispose();
  }
}
