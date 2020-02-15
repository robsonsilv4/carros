import 'package:flutter/material.dart';

alert(context, String msg) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
            child: AlertDialog(
              title: Text('Carros'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                )
              ],
            ),
            onWillPop: () async => false);
      });
}
