//import 'package:drag/screen/navigatoin_bar.dart';
//import 'package:drag/widget/input_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag/screen/PostScreen.dart';
import 'package:drag/widget/swap_widget.dart';
import 'package:drag/widget/title_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'input_image.dart';

class SignScreen extends StatefulWidget {
  static String routeName = '/AuthScreen';

  @override
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
File imageFile;
  bool _isLoad = false;
  String email;
  String name;
  String password;
  String userName;
  String confirmPassword;
  bool _isLogin = true;
  final _globalKey = GlobalKey<FormState>();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusUserName = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusPassword.dispose();
    _focusUserName.dispose();
    _focusEmail.dispose();
  }

  void _swap(bool val) {
    setState(() {
      _isLogin = val;
    });
  }

  onselectimage(File image) {

    setState(() {
      imageFile = image;
    });
  }

  void _submit(BuildContext context) async {
    final valid = _globalKey.currentState.validate();
    if (imageFile == null
        &&!_isLogin
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('please Pick an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (!valid) return;
    _globalKey.currentState.save();
    try {
      setState(() {
        _isLoad = true;
      });
      if (_isLogin) {

        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        final result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref('profile_user')
            .child(result.user.uid + '.jpg');
        await ref.putFile(File(imageFile.path));
        final url = await ref.getDownloadURL();
        final currentUser = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(result.user.uid)
            .set({
          'email': email,
          'userName': userName,
          'image': url,
          'name': name,
          'uid': currentUser.uid
        });
      }
      Navigator.pushNamed(context, PostScreen.routeNAme);
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee###$e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please enter valid email')));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0XFFd5e7bd),
              Color(0XFF42ada8),
            ],
            tileMode: TileMode.repeated,
            stops: [0.2, 0.7],
          )),
          child: Column(
            children: [
              SizedBox(
                height: size.height / 16,
              ),
              Title1(size),

              Swap(swap:_swap,isLogin: _isLogin,),
              SizedBox(height: size.height/20,),
              buildStack(size, context)
            ],
          ),
        ),
      ),
    ));
  }

  Stack buildStack(Size size, BuildContext context) {
    return Stack(
              overflow: Overflow.visible,
              children: [
                Form(
                  key: _globalKey,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.bounceOut,
                    width: size.width / 3 * 2,
                    height:
                        !_isLogin ? size.height / 2 * 1.1 : size.height / 2.4,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height / 20,
                            ),
                            Text(
                              !_isLogin ? 'SignUP' : 'LogIN',
                              style: TextStyle(
                                  color: Color(0XFF707070),
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                            ),
                          if(!_isLogin)  Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusEmail);
                                },
                                key: ValueKey('name'),
                                validator: (val) {
                                  if (val.isEmpty || val.length < 4)
                                    return "please enter more 4 characters";
                                  return null;
                                },
                                onSaved: (val) {
                                  name = val;
                                },
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    InputDecoration(labelText: 'name'),
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                focusNode: _focusEmail,
                                validator: (val) {
                                  if (!val.contains('@'))
                                    return "please enter valid email";
                                  return null;
                                },
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusUserName);
                                },
                                onSaved: (val) {
                                  email = val;
                                },
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    InputDecoration(labelText: 'email'),
                              ),
                            ),),
                            if(!_isLogin)  Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  focusNode: _focusUserName,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_focusPassword);
                                  },
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  onSaved: (val) {
                                    userName = val;
                                  },
                                  validator: (val) {
                                    if (val.isEmpty || val.length < 4)
                                      return "please enter least 4 character";
                                    return null;
                                  },
                                  decoration:
                                      InputDecoration(labelText: 'UserName'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  focusNode: _focusPassword,
                                  onFieldSubmitted: (_) {
                                    _submit(context);
                                  },
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                  onSaved: (val) {
                                    password = val;
                                  },
                                  validator: (val) {
                                    if (val.isEmpty || val.length < 7)
                                      return "please enter least 7 character";
                                    return null;
                                  },
                                  decoration:
                                      InputDecoration(labelText: ' Password'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height / 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child:TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all( Color(0XFF42ADA8),)
                                    ),
                                    onPressed: () => _submit(context),
                                    child: _isLoad?CircularProgressIndicator(): Text(
                                        !_isLogin ? 'Register' : 'LogIn',
                                    style: TextStyle(color: Theme.of(context).accentColor),),
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          if(!_isLogin) InputImage(onselectimage,false),
              ],
            );
  }


}



