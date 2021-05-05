import 'package:drag/provider/provider_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CommentScreen extends StatefulWidget {
  static String routeName = '/commentScreen';

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  bool _isLoadComment = false;
  bool _isP = true;
  String comment;
  final controller = TextEditingController();
//  bool _isNull = false;
  String idPost;
  ProviderPost prov=ProviderPost();


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isP) {
   prov=Provider.of(context,listen: false);

      idPost = ModalRoute.of(context).settings.arguments as String;
      _isP = false;
    }
  }

  Future<void>  sendComment(bool isNull)async{
    if (isNull) {
      setState(() {
        _isLoadComment = true;
      });
      controller.clear();
   await prov.addComment(comment,idPost);

      setState(() {
        _isLoadComment = false;
      });
  }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Comment'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream:FirebaseFirestore.instance.collection('posts').doc(idPost)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      // ignore: non_constant_identifier_names
                      final Docs = snapshot.data;
                      if(Docs.data()['comment'].length==0){
                        return Center(child: Text('no comment add'),);
                      }
//                      print(Docs.data()['comment']);
//                      print(Docs.data()['comment'][0]['comment']);
                      return ListView.builder(
                        itemCount: Docs.data()['comment'].length,
                        itemBuilder: (_, index) =>
//    Text(Docs.data()['comment'][index]['comment'])

                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  child: ListTile(
                                    title: Text(Docs.data()['comment'][index]['nameUser']),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                    ),
                                    subtitle: Text(Docs.data()['comment'][index]['comment']),
                                  ),
                                  elevation: 1,
                                )),
                      );
                    })),
           Consumer<ProviderPost>(builder: (context,pr,child){
             return  Row(
               mainAxisSize: MainAxisSize.min,
               children: [
                 Expanded(
                   child: TextField(
                     onChanged: (val) {

                       if (val.isNotEmpty) pr.ixNull(true);
                       if (val.isEmpty) pr.ixNull(false) ;
                       comment = val;

                     },

                     controller: controller,
                     decoration: InputDecoration(
                       fillColor:Theme.of(context).accentColor,
                         isCollapsed: false,
                         border: OutlineInputBorder(
                             gapPadding: 50,
                             borderRadius: BorderRadius.circular(30,),),filled: true),
                   ),
                 ),
                 _isLoadComment
                     ? Center(child: CircularProgressIndicator(),)
                     : IconButton(
                   icon: Icon(Icons.send,
                       color: pr.isNull
                           ? Colors.indigo
                           : Colors.grey),
                   onPressed: ()=>pr.isNull ? sendComment(pr.isNull) : null,
                 ),
               ],
             );
           })
          ],
        ),
      ),
    );
  }
}
