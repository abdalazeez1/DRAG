import 'package:flutter/material.dart';

class CenterPost extends StatelessWidget {
  final String contentText;

  CenterPost({this.contentText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(contentText)
//        RichText(
//          text: TextSpan(
//              style: TextStyle(
//                  color: Colors.black,
//                  fontSize: 18,
//                  fontWeight: FontWeight.normal),
//              children: [
//                TextSpan(text: 'i want this mock up ao bad!!'),
//                TextSpan(
//                  text: 'found it',
//                ),
//                TextSpan(
//                    text: 'http://marinad.com.ar',
//                    style: TextStyle(color: Colors.blueAccent)),
////                     TextSpan(
////                         text: 'see Translate',
////                         style: TextStyle(color: Colors.blueAccent)),
//              ]),
//        ),
//        TextButton(onPressed: () {}, child: Text('see translate')),
      ],
    );
  }
}