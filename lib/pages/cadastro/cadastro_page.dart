import 'package:flutter/material.dart';

import '../../firebase/firebase_service.dart';
import '../../utils/alert.dart';
import '../../utils/nav.dart';
import '../carro/home_page.dart';
import '../login/login_page.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _tNome = TextEditingController();
  final _tEmail = TextEditingController();
  final _tSenha = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _progress = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _tNome,
            validator: _validateNome,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22,
            ),
            decoration: InputDecoration(
              labelText: 'Nome',
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              hintText: 'Digite o seu nome',
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _tEmail,
            validator: _validateLogin,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22,
            ),
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              hintText: 'Digite o seu email',
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _tSenha,
            validator: _validateSenha,
            obscureText: true,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22,
            ),
            decoration: InputDecoration(
              labelText: 'Senha',
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              hintText: 'Digite a sua Senha',
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            height: 46,
            margin: EdgeInsets.only(top: 20),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: _progress
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
              onPressed: () {
                _onClickCadastrar(context);
              },
            ),
          ),
          Container(
            height: 46,
            margin: EdgeInsets.only(top: 20),
            child: RaisedButton(
              color: Colors.white,
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 22,
                ),
              ),
              onPressed: () {
                _onClickCancelar(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  String _validateNome(String text) {
    if (text.isEmpty) {
      return 'Informe o nome';
    }

    return null;
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return 'Informe o email';
    }

    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return 'Informe a senha';
    }
    if (text.length <= 2) {
      return 'Senha precisa ter mais de 2 números';
    }

    return null;
  }

  _onClickCancelar(context) {
    push(context, LoginPage(), replace: true);
  }

  _onClickCadastrar(context) async {
    String nome = _tNome.text;
    String email = _tEmail.text;
    String senha = _tSenha.text;

    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _progress = true;
    });

    final service = FirebaseService();
    final response = await service.cadastrar(nome, email, senha);

    if (response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.message);
    }

    setState(() {
      _progress = false;
    });
  }
}
