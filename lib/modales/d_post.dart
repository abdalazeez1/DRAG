import 'package:flutter/cupertino.dart';
import 'dart:io';

class DPost {
  String id;
  String nameUser;
  String contentText;
  File image;
  List<Map> like;

  DPost({
   @required this.nameUser,
   @required this.contentText,
   @required this.image,
    this.id,
    this.like,
  });
}
