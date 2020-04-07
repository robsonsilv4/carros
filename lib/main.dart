import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/favoritos/favoritos_bloc.dart';
import 'pages/login/login_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FavoritosBloc>(
          create: (context) => FavoritosBloc(),
          dispose: (context, bloc) => bloc.dispose(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Carros',
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: LoginPage(),
      ),
    );
  }
}
