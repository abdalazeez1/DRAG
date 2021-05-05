import 'package:flutter/material.dart';
class Swap extends StatelessWidget {
  final Function swap;
  final bool isLogin;

  Swap({this.swap,this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed:() =>swap(true),
            child: Text(
              'Login',
              style: isLogin
                  ? TextStyle(
                fontSize: 14,
                color:Color(0XFF42ADA8),
              )
                  : TextStyle(
                  fontSize: 14, color: Colors.grey),
            )),
        TextButton(
            onPressed:( )=>swap(false),
            child: Text(
              'SignUP',
              style: !isLogin
                  ? TextStyle(
                fontSize: 14,
                color:Color(0XFF42ADA8),
              )
                  : TextStyle(
                  fontSize: 14, color: Colors.grey),
            )),
      ],
    );
  }
}