import 'package:drag/provider/provider_post.dart';
import 'package:drag/screen/PostScreen.dart';
import 'package:drag/screen/add_screen.dart';
import 'package:drag/screen/comment_screen.dart';
import 'package:drag/screen/navigatoin_bar.dart';
import 'package:drag/screen/profile.dart';
import 'package:drag/screen/sign_screen.dart';
//import 'file:///C:/Users/Alyosfi/AndroidStudioProjects/rebuild_drag/lib/screens/sign_screen.dart';
import './screen/chat_screen.dart';
import 'package:drag/screen/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider.value(

      value: ProviderPost(),
      builder: (ctx,child)=>
          MaterialApp(
            routes: {
              AddScreen.routeName: (_) => AddScreen(),
              PostScreen.routeNAme: (_) => PostScreen(),
              SearchScreen.routeName:(_)=>SearchScreen(),
              SignScreen.routeName:(_)=>SignScreen(),
//              InfoScreen.routeName:(_)=>InfoScreen(),
              ProfileScreen.routeName:(_)=>ProfileScreen(),
              ChatScreen.routeName:(_)=>ChatScreen(),
              NavigationBar.routeName:(_)=>NavigationBar(),
              CommentScreen.routeName:(_)=>CommentScreen(),

            },
            theme: ThemeData(
              primaryColor: Color(0XFFEEF5E6),
              accentColor:  Color(0XFFD5E7BD),


            ),
            home:
            StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx,snapshot){
            if(snapshot.hasData){
             return NavigationBar();
               }
                 return SignScreen();
              },
            ),
          ),
    )
  );
}
