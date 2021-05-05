import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widget/message.dart';
class ChatScreen extends StatefulWidget {
  static String routeName = '/ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  TextEditingController controller = TextEditingController();
  String message;

  sendMessage() async {
    message=controller.text;
    if (controller.text.isEmpty) return;controller.clear();

    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    await FirebaseFirestore.instance.collection('chat').add({
      'time': Timestamp.now(),
      'name': userData['name'],
      'image': userData['image'],
      'message': message,
      'uid':userData['uid']
    });

  }
  var user;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
user=  FirebaseAuth.instance.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat Screen'),
      ),
      body: Container(
        color: Theme.of(context).accentColor,
        child: Column(
          children: [
           Expanded(child:  StreamBuilder(
               stream: FirebaseFirestore.instance
                   .collection('chat')
                   .orderBy('time', descending: true)
                   .snapshots(),
               builder: (_, snapshot) {

                 if (snapshot.connectionState == ConnectionState.waiting)
                   return Center(
                     child: CircularProgressIndicator(),
                   );
                 // ignore: non_constant_identifier_names
                 final Docs = snapshot.data.docs;
                 if(Docs.length==0){
                   return Center(child: Text('no message add yet'),);
                 }
                 return ListView.builder(

                   reverse: true,
                     itemBuilder: (_, index) =>
                     Message(message:Docs[index]['message'],
                         url:Docs[index]['image'],
                     isMe: Docs[index]['uid']==user.uid,),
                     itemCount: Docs.length);
               }),),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(

                      controller: controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.send,
                    ),
                    onPressed: sendMessage)
              ],
            )
          ],
        ),
      ),
    );
  }
}
