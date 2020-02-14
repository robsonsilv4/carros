import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final loginController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
      ),
      body: _body(),
    );
  }

  Container _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          _text(
            'Login',
            'Digite o seu login',
            controller: loginController,
          ),
          SizedBox(height: 10),
          _text(
            'Senha',
            'Digite a sua senha',
            password: true,
            controller: senhaController,
          ),
          SizedBox(height: 20),
          _button("Entrar", _onClickLogin)
        ],
      ),
    );
  }

  TextFormField _text(
    String label,
    String hint, {
    TextEditingController controller,
    bool password = false,
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

  void _onClickLogin() {
    String login = loginController.text;
    String senha = senhaController.text;
    print('Login: $login');
    print('Senha: $senha');
  }
}
