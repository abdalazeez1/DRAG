
import 'package:drag/provider/provider_post.dart';
import 'package:drag/widget/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  bool _isLoad=false;
  DocumentSnapshot userData;
  User user;
  bool _isP=true;
  var  prov=ProviderPost();
  @override
  void didChangeDependencies()async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(_isP){
      setState(() {
        _isLoad=true;
      });
      prov=Provider.of(context,listen: false);
      user=FirebaseAuth.instance.currentUser;
      userData= await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      _isP=false;
      setState(() {
        _isLoad=false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.black87,

      endDrawer: AppDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0XFF5B5B5A)),
        backgroundColor: Color(0XFFEEF5E6),
        leading: Icon(Icons.person_pin,color:  Color(0XFF5B5B5A),),
        title: Text(
          'Person',
          style: TextStyle(fontSize: 30, color:  Color(0XFF5B5B5A)),
        ),
      ),
      body:_isLoad?Center(child: CircularProgressIndicator(),): Container(
        color: Color(0XFFD5E7BD),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadWidget(
              image: NetworkImage(userData['image']),
              name: userData['name'],
            ),
            Divider(
              color: Colors.grey,
              height: 40,
              thickness: 0.3,
            ),
            Info(email: user.email ,
            username:userData['userName'] ,),

          ],
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  final String email;
  final String username;


  Info({this.email, this.username});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:  Color(0XFFEEF5E6),
             child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
      Padding(padding: EdgeInsets.only(left: 8,top: 4),child:  Text(
        'other information',
        style: TextStyle(
            color: Color(0XFF42ADA8),
            fontWeight: FontWeight.bold),
      ),),
       Divider(
         color: Colors.blueGrey,
         thickness: 2,
         height: 10,
       ),
       SizedBox(
         height: 8,
       ),
       Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           MoreInf(
             text: 'email :',
             infoUser: email,
           ),
           MoreInf(
             text: 'User Name :',
             infoUser:username,
           ),
           MoreInf(
             text: 'Age :',
             infoUser: '18',
           ),
           MoreInf(
             text: 'Education :',
             infoUser: 'Collectors',
           ),
           MoreInf(
             text: 'Address :',
             infoUser: 'Syria',
           ),
         ],
       )
     ],
             ),
           );
  }
}

class HeadWidget extends StatelessWidget {
  final NetworkImage image;
final String name;

  HeadWidget({this.image,this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
//          backgroundColor: Colors.white60,
          backgroundImage: image??null,
          radius: 40,
        ),
        SizedBox(
          width: 34,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 24, color:  Color(0XFF5B5B5A)),
        )
      ],
    );
  }
}

class MoreInf extends StatelessWidget {
  final String text;
  final String infoUser;

  MoreInf({this.text, this.infoUser});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 8,bottom: 4),child: Row(

      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 16, color: Color(0XFF42ADA8)),
        ),
//        SizedBox(
//          width: 24,
//        ),
        Spacer(),
        Text(infoUser, style: TextStyle(fontSize: 16, color: Color(0XFF5B5B5A))),
        Spacer(

        )
      ],
    ),);
  }
}
