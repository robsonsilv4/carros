import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import '../../firebase/firebase_service.dart';
import '../../utils/alert.dart';
import '../../utils/nav.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import '../api_response.dart';
import '../cadastro/cadastro_page.dart';
import '../carro/home_page.dart';
import 'login_bloc.dart';
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

  final _bloc = LoginBloc();

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
            StreamBuilder<bool>(
              stream: _bloc.buttonBloc.stream,
              initialData: false,
              builder: (context, snapshot) {
                return AppButton(
                  "Entrar",
                  showProgress: snapshot.data,
                  onPressed: _onClickLogin,
                );
              },
            ),
            Container(
              height: 46.0,
              margin: EdgeInsets.only(top: 20.0),
              child: GoogleSignInButton(
                onPressed: () => _onClickGoole(),
              ),
            ),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: _onClickCadastrar,
                child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
              ),
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

    String login = _loginController.text;
    String senha = _senhaController.text;

    print('Login: $login');
    print('Senha: $senha');

    ApiResponse response = await _bloc.login(login, senha);

    if (response.ok) {
      Usuario user = response.result;
      print('$user');
      push(
        context,
        HomePage(),
        replace: true,
      );
    } else {
      alert(context, response.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  _onClickGoole() async {
    final service = FirebaseService();
    ApiResponse response = await service.loginGoogle();

    if (response.ok) {
      push(context, HomePage(), replace: true);
    }

    alert(context, response.message);
  }

  void _onClickCadastrar() {
    push(context, CadastroPage(), replace: true);
  }
}
