import 'package:flutter/material.dart';

import '../../utils/nav.dart';
import '../carro/home_page.dart';
import '../favoritos/database_helper.dart';
import '../login/login_page.dart';
import 'usuario.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future futureA = DatabaseHelper.getInstance().db;
    Future futureB = Future.delayed(Duration(seconds: 3));
    Future<Usuario> futureC = Usuario.get();

    Future.wait([
      futureA,
      futureB,
      futureC,
    ]).then((List values) {
      Usuario user = values[2];

      if (user != null) {
        push(context, HomePage(), replace: true);
      }

      push(context, LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade200,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
