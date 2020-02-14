import 'package:flutter/material.dart';

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
            _text(
              'Login',
              'Digite o seu login',
              controller: loginController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              nextFocus: focusSenha,
              validator: _validateLogin,
            ),
            SizedBox(height: 10),
            _text(
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
            _button("Entrar", _onClickLogin)
          ],
        ),
      ),
    );
  }

  TextFormField _text(
    String label,
    String hint, {
    TextEditingController controller,
    bool password = false,
    TextInputType keyboardType,
    TextInputAction textInputAction,
    FocusNode focusNode,
    FocusNode nextFocus,
    FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      style: TextStyle(
        fontSize: 20,
        color: Colors.red,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
        hintStyle: TextStyle(fontSize: 16),
      ),
      obscureText: password,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      validator: validator,
    );
  }

  Container _button(String text, Function onPressed) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: Colors.red,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        onPressed: onPressed,
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

  void _onClickLogin() {
    // bool formOk = formKey.currentState.validate();

    if (!formKey.currentState.validate()) {
      return;
    }

    String login = loginController.text;
    String senha = senhaController.text;

    print('Login: $login');
    print('Senha: $senha');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
