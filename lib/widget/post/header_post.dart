import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag/screen/add_screen.dart';
import 'package:flutter/material.dart';

class HeaderPost extends StatelessWidget {
  final String imageUser;
  final String nameuser;
  final String id;
  const HeaderPost({ this.nameuser,this.imageUser,this.id}) ;
  @override
  Widget build(BuildContext context) {
    return Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: imageUser==null?AssetImage('assets/images.png'): NetworkImage(imageUser),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nameuser,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  'today at 19:33',
                  style: TextStyle(
                      color: Colors.blueGrey, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.public,
                  size: 14,
                )
              ],
            )
          ],
        ),
        Spacer(),
        PopupMenuButton(

            onSelected: (val) async {
              if (val == 'edit') {
                Navigator.of(context).pushReplacementNamed(
                    AddScreen.routeName,
                    arguments: id);
              }
              if (val == 'delete') {
                await FirebaseFirestore.instance
                    .collection('posts')
                    .doc(id)
                    .delete();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child:Row(children: [ Icon(Icons.delete,color: Colors.red,),Text('delete',style: TextStyle(color: Colors.red),)],),

                value: 'delete',
              ),
              PopupMenuItem(
                child:Row(children: [ Icon(Icons.edit,color: Colors.purple,),Text('edit',style: TextStyle(color: Colors.purple),)],),
                value: 'edit',
              ),
            ]),
      ],
    );
  }
}