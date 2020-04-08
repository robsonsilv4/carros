import 'package:flutter/material.dart';

alert(BuildContext context, String message, {Function callback}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        child: AlertDialog(
          title: Text('Carros'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                if (callback != null) {
                  callback();
                }
              },
              child: Text('Ok'),
            )
          ],
        ),
        onWillPop: () async => false,
      );
    },
  );
}
