import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag/widget/post/post_widget.dart';
import 'package:flutter/material.dart';
import 'add_screen.dart';

class PostScreen extends StatefulWidget {
  static String routeNAme = '/generalScreen';

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
//    final prov=Provider.of<ProviderPost>(context,listen: false);
//    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Color(0XFFD5E7BD),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AddScreen.routeName);
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.deepPurpleAccent,
                borderOnForeground: true,
                child: Container(
                  color: Color(0XFFEEF5E6),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 32),
                            child: Text(
                              'Add New Post',
                              style: TextStyle(
                                  color: Color(0XFF5B5B5A), fontSize: 24),
                            ),
                          ),
                          Divider(
                            indent: 20,
                            color: Color(0XFF5B5B5A),
                            thickness: 1,
                            endIndent: 20,
                          )
                        ],
                      )),
                      CircleAvatar(
                        backgroundColor: Colors.indigo,
                        radius: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.indigo,
                        ),
                      );

                    // ignore: non_constant_identifier_names
                    final Docs = snapshot.data.docs;
//    print(Docs.length);
//    print(';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Docs');
                    if (Docs.length == 0) {
                      return Center(
                        child: Text('no Data yet \'add image\''),
                      );
                    }

                    return ListView.builder(
                      itemCount: Docs.length,
                      itemBuilder: (ctx, index) => PostWidget(
                        nameUser: Docs[index]['nameUser'],
                        id: Docs[index]['id'],
                        contentText: Docs[index]['contentText'],
                        image: Docs[index]['image'],
//                  like: Docs[index]['like'],
                        imageUser: Docs[index]['imageUser'],
                        index: index,
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}


