import 'package:flutter/material.dart';

import '../utils/alert.dart';
import '../utils/nav.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text.dart';
import 'api_response.dart';
import 'home_page.dart';
import 'login_api.dart';
import 'usuario.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final loginController = TextEditingController();
  final senhaController = TextEditingController();

  final focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              'Login',
              'Digite o seu login',
              controller: loginController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              nextFocus: focusSenha,
              validator: _validateLogin,
            ),
            SizedBox(height: 10),
            AppText(
              'Senha',
              'Digite a sua senha',
              password: true,
              controller: senhaController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: focusSenha,
              validator: _validateSenha,
            ),
            SizedBox(height: 20),
            AppButton(
              "Entrar",
              onPressed: _onClickLogin,
            )
          ],
        ),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return 'Digite o login';
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return 'Digite a senha';
    }

    if (text.length < 3) {
      return 'A senha precisa ter no mínimo 3 caracteres';
    }
    return null;
  }

  void _onClickLogin() async {
    // bool formOk = formKey.currentState.validate();

    if (!formKey.currentState.validate()) {
      return;
    }

    String login = loginController.text;
    String senha = senhaController.text;

    print('Login: $login');
    print('Senha: $senha');

    ApiResponse response = await LoginApi.login(login, senha);

    if (response.ok) {
      Usuario user = response.result;
      print('$user');
      push(context, HomePage());
    } else {
      alert(context, response.msg);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
