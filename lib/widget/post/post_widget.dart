import 'package:flutter/material.dart';

import 'action_post.dart';
import 'buttom_post.dart';
import 'center_post.dart';
import 'header_post.dart';
class PostWidget extends StatelessWidget {
  final String nameUser;
  final String id;
  final String contentText;
  final String imageUser;
  final String image;
  final int index;

  PostWidget(
      {this.nameUser,
        this.id,
        this.contentText,
        this.imageUser,
        this.index,
        this.image});

  @override
  Widget build(BuildContext context) {
//    var Size =MediaQuery.of(context).size;
    return Container(
      color: Color(0XFFEEF5E6),
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 10),
      child: Column(
        children: [
          HeaderPost(
            id: id,
            imageUser: imageUser,
            nameuser: nameUser,
          ),
          SizedBox(
            height: 15,
          ),
          CenterPost(
            contentText: contentText,
          ),
          Card(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              color: Colors.indigo,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            elevation: 8,
          ),
          ActionPost(
            id: id,
            idPost: id,
          ),
          ButtonPost(
            id: id,
          )
        ],
      ),
    );
  }
}