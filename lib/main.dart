import 'package:carros/pages/favoritos/favoritos_bloc.dart';
import 'package:flutter/material.dart';

import 'pages/login/login_page.dart';

final favoritosBloc = FavoritosBloc();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carros',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoginPage(),
    );
  }
}
