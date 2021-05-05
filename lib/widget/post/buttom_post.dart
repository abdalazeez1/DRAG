import 'package:drag/screen/comment_screen.dart';
import 'package:drag/screen/screen_like.dart';
import 'package:flutter/material.dart';
class ButtonPost extends StatelessWidget {
  final String id;

  ButtonPost({this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey[300],
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LikeScreen(id)));
            },
            child:    Row(
              children: [
                IconButton(
                  onPressed: (){},
                  icon: Icon(               Icons.thumb_up_alt_outlined,
                  ),               color: Colors.blue,
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                Icon(
                  Icons.tag_faces,
                  color: Colors.amber,
                ),
                Text(
                  '1,035',
                  style: TextStyle(color: Colors.deepPurple),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(
                  CommentScreen.routeName,
                  arguments: id);
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Text(
                            'write some thing...',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Spacer(),
                          Icon(
                            Icons.tag_faces,
                            size: 20,
                          ),
                          Icon(Icons.camera_alt_outlined, size: 20),
                          Icon(Icons.gif_rounded, size: 20),
                          Icon(Icons.tab_sharp, size: 20),
                        ],
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}