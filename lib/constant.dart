import 'package:flutter/material.dart';
// ignore: non_constant_identifier_names
final TextStyle KtextStyle=TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  foreground: Paint()..shader=LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors:  [
      Colors.amber[800],
      Colors.yellow,
      Colors.white
    ],
  ).createShader(Rect.fromLTWH(30, 50, 80, 80),),

);

// ignore: non_constant_identifier_names
final TextStyle KtextStyleButton=TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
foreground: Paint()..shader=LinearGradient(
begin: Alignment.topRight,
end: Alignment.bottomLeft,
colors:  [
Colors.amber[800],
Colors.yellow,
Colors.white
],
).createShader(Rect.fromLTWH(70, 4000, 150,200),));
// ignore: non_constant_identifier_names
final TextStyle KtextStyleProfile=TextStyle(
    color: Colors.purple[900],
    fontSize: 20);