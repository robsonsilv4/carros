import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/favoritos/favoritos_model.dart';
import 'pages/login/splash_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoritosModel>(
          create: (context) => FavoritosModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Carros',
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: SplashPage(),
      ),
    );
  }
}
