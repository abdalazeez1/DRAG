import 'package:drag/screen/comment_screen.dart';
import 'package:flutter/material.dart';
import 'button_add_like_post.dart';

class ActionPost extends StatelessWidget {
  final String idPost;
  final String id;

  ActionPost({this.idPost,this.id});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ButtonAddLike(idPost),
        Expanded(
            flex: 1,
            child: Center(
              child: TextButton.icon(
                  style:ButtonStyle(
                      foregroundColor:MaterialStateProperty.all(Colors.indigo)
                  ),
                  onPressed: () {


                    Navigator.of(context).pushNamed(CommentScreen.routeName,arguments: id);

                  }
                  ,icon: Icon(Icons.messenger_outline),
                  label: Text(
                    'comment',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )),
            )),
        Expanded(
            child: Center(
              child: TextButton.icon(
                  style:ButtonStyle(
                      foregroundColor:MaterialStateProperty.all(Colors.indigo)
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.reply_outlined),
                  label: Text(
                    'share',
                    style: TextStyle(fontSize: 14),
                  )),
            )),
      ],
    );
  }
}