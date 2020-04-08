import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/nav.dart';
import '../../utils/sql/database_helper.dart';
import '../carro/home_page.dart';
import '../login/login_page.dart';

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
    Future<FirebaseUser> futureC = FirebaseAuth.instance.currentUser();

    Future.wait([
      futureA,
      futureB,
      futureC,
    ]).then((List values) {
      FirebaseUser user = values[2];

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
}
