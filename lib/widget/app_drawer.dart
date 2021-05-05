import 'package:drag/screen/PostScreen.dart';
import 'package:drag/screen/add_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

        child: Column(
      children: [
        AppBar(
          elevation: 6,
backgroundColor: Color(0XFFEEF5E6),
           automaticallyImplyLeading: true,
           title: Text('Drag'),
         ),

        Divider(),
        Center(
          child: ListTile(
            trailing: Icon(Icons.navigate_next),
            shape: Border.all(width: 2, color: Theme.of(context).primaryColor),
            title: Text('General Screen'),
            leading: Icon(
              Icons.public,
              color: Theme.of(context).primaryColor,
            ),
            contentPadding: EdgeInsets.all(10),
            onTap: (){
              Navigator.of(context).pushNamed(PostScreen.routeNAme);
            },
          ),
        ),
        Center(
          child: ListTile(
            trailing: Icon(Icons.navigate_next),
            shape: Border.all(width: 2, color: Theme.of(context).primaryColor),
            title: Text('Add Screen'),
            leading: Icon(
              Icons.edit_outlined,
              color: Theme.of(context).primaryColor,
            ),
            contentPadding: EdgeInsets.all(10),
            onTap: (){
              Navigator.of(context).pushNamed(AddScreen.routeName);
            },
          ),
        ),
        Center(
          child: ListTile(
            trailing: Icon(Icons.edit_outlined),
            shape: Border.all(width: 2, color: Theme.of(context).primaryColor),
            title: Text('Logout'),
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).primaryColor,
            ),
            contentPadding: EdgeInsets.all(10),
            onTap: (){
           FirebaseAuth.instance.signOut();
            },
          ),
        ),
      ],
    ));
  }
}
