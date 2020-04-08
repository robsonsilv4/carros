import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../firebase/firebase_service.dart';
import '../../utils/alert.dart';
import '../../utils/nav.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import '../api_response.dart';
import 'carro.dart';
import 'carro_api.dart';

class CarroFormPage extends StatefulWidget {
  final Carro carro;

  CarroFormPage({this.carro});

  @override
  State<StatefulWidget> createState() => _CarroFormPageState();
}

class _CarroFormPageState extends State<CarroFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final tTipo = TextEditingController();

  int _radioIndex = 0;

  var _showProgress = false;

  File _file;

  Carro get carro => widget.carro;

  // Add validate email function.
  String _validateNome(String value) {
    if (value.isEmpty) {
      return 'Informe o nome do carro.';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    // Copia os dados do carro para o form
    if (carro != null) {
      nomeController.text = carro.nome;
      descricaoController.text = carro.descricao;
      _radioIndex = getTipoInt(carro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          carro != null ? carro.nome : 'Novo Carro',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  _form() {
    return Form(
      key: this._formKey,
      child: ListView(
        children: <Widget>[
          _headerFoto(),
          Text(
            'Clique na imagem para tirar uma foto',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Divider(),
          Text(
            'Tipo',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
          ),
          _radioTipo(),
          Divider(),
          AppText(
            'Nome',
            '',
            controller: nomeController,
            keyboardType: TextInputType.text,
            validator: _validateNome,
          ),
          AppText(
            'Descrição',
            '',
            controller: descricaoController,
            keyboardType: TextInputType.text,
            validator: _validateNome,
          ),
          AppButton(
            'Salvar',
            showProgress: _showProgress,
            onPressed: _onClickSalvar,
          ),
        ],
      ),
    );
  }

  _headerFoto() {
    return InkWell(
      child: _file != null
          ? Image.file(_file, height: 150.0)
          : carro != null
              ? CachedNetworkImage(
                  imageUrl: carro.urlFoto,
                  height: 150.0,
                )
              : Image.asset(
                  'assets/images/camera.png',
                  height: 150.0,
                ),
      onTap: _onClickFoto,
    );
  }

  _radioTipo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          'Clássicos',
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
        ),
        Radio(
          value: 1,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          'Esportivos',
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
        ),
        Radio(
          value: 2,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          'Luxo',
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
        ),
      ],
    );
  }

  void _onClickTipo(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  getTipoInt(Carro carro) {
    switch (carro.tipo) {
      case 'classicos':
        return 0;
      case 'esportivos':
        return 1;
      default:
        return 2;
    }
  }

  String _getTipo() {
    switch (_radioIndex) {
      case 0:
        return 'classicos';
      case 1:
        return 'esportivos';
      default:
        return 'luxo';
    }
  }

  void _onClickFoto() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      FirebaseService.uploadFirebaseStorage(file);

      setState(() {
        this._file = file;
      });
    }
  }

  _onClickSalvar() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    // Cria o carro
    var c = carro ?? Carro();
    c.nome = nomeController.text;
    c.descricao = descricaoController.text;
    c.tipo = _getTipo();

    print('Carro: $c');

    setState(() {
      _showProgress = true;
    });

    print('Salvar o carro $c');

    ApiResponse<bool> response = await CarroApi.save(c, _file);

    if (response.ok) {
      alert(context, 'Carro salvo com sucesso!', callback: () {
        pop(context);
      });
    } else {
      alert(context, response.message);
    }

    setState(() {
      _showProgress = false;
    });

    print('Fim.');
  }
}
