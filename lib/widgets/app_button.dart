import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final showProgress;

  AppButton(
    this.text, {
    this.onPressed,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: Colors.red,
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
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
}
