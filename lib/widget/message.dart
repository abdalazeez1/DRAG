import 'package:flutter/material.dart';
// ignore: must_be_immutable
class Message extends StatelessWidget {
  String url;
   String message ;
final bool isMe;
  Message({this.url, this.message,this.isMe});

  @override
  Widget build(BuildContext context) {
    return
      ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(url),

        ),
        title: Text(message),
      );
  }
}
