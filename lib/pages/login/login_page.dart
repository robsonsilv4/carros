import 'package:flutter/material.dart';

import '../../utils/alert.dart';
import '../../utils/nav.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import '../api_response.dart';
import '../carro/home_page.dart';
import 'login_api.dart';
import 'usuario.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();

  final focusSenha = FocusNode();

  bool _showProgress = false;

  @override
  void initState() {
    super.initState();

    Future<Usuario> future = Usuario.get();
    future.then((Usuario user) {
      if (user != null) {
        setState(() {
          // Lembrar login ao sair
          // _loginController.text = user.login;

          push(context, HomePage(), replace: true);
        });
      }
    });
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
              controller: _loginController,
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
              controller: _senhaController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: focusSenha,
              validator: _validateSenha,
            ),
            SizedBox(height: 20),
            AppButton(
              "Entrar",
              showProgress: _showProgress,
              onPressed: _onClickLogin,
            ),
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

    String login = _loginController.text;
    String senha = _senhaController.text;

    print('Login: $login');
    print('Senha: $senha');

    setState(() {
      _showProgress = true;
    });

    ApiResponse response = await LoginApi.login(login, senha);

    if (response.ok) {
      Usuario user = response.result;
      print('$user');
      push(
        context,
        HomePage(),
        replace: true,
      );
    } else {
      alert(context, response.msg);
    }

    setState(() {
      _showProgress = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
