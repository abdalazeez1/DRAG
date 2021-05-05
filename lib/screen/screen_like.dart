import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikeScreen extends StatefulWidget {
  final String idPost;
  static String routeName = '/LikeScreen';

  LikeScreen(this.idPost);

  @override
  _LikeScreenState createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Like Screen'),
      ),
      body: Container(
    child: FutureBuilder(
    future: FirebaseFirestore.instance.collection('posts').doc(widget.idPost).get(),

    builder: (_,snapshot){
    if(snapshot.connectionState==ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
    return ListView.builder(
      itemBuilder: (_,index)=>Padding(
        padding:EdgeInsets.all(8),
        child: ListTile(
          title: Text(snapshot.data.data()['like'][index]['name'])
          ,leading:CircleAvatar(
            backgroundImage: NetworkImage(snapshot.data.data()['like'][index]['url'])),
        ),
      ),

      itemCount: snapshot.data.data()['like'].length??0,
    );

    },
    )
    ),
    );
  }
}
