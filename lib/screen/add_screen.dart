import 'package:drag/modales/d_post.dart';
import 'package:drag/provider/provider_post.dart';
import 'package:drag/screen/navigatoin_bar.dart';
import 'package:flutter/cupertino.dart';

//import 'file:///C:/Users/Alyosfi/AndroidStudioProjects/rebuild_drag/lib/screens/input_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'input_image.dart';

class AddScreen extends StatefulWidget {
  static String routeName = '/AddScreen';

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  var prov = ProviderPost();
  var postId;
  bool _isLoad = false;
  File _imagePath;
  final focusNode = FocusNode();
  var initialVal = {
    'nameUser': '',
    'contentText': '',
    'like': false,
    'image': ''
  };
  var nameUser;
  var contentText;
  bool _isEditLoaded = false;
  final _globalKey = GlobalKey<FormState>();
  var _isp = true;

  void _onSelect(File image) {
    setState(() {
      _imagePath = image;
    });
  }

  var editPost = DPost(
    nameUser: '',
    contentText: '',
    image: null,
  );

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (_isp) {
      prov = Provider.of<ProviderPost>(context, listen: false);
      postId = ModalRoute.of(context).settings.arguments as String;
      if (postId != null) {
        print('post id is $postId');
        setState(() {
          _isEditLoaded = true;
        });
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            initialVal = {
              'nameUser': documentSnapshot.data()['nameUser'],
              'contentText': documentSnapshot.data()['contentText'],
              'like': documentSnapshot.data()['like'],
              'id': documentSnapshot.data()['id'],
              'image': documentSnapshot.data()['image'],
            };
          }
        });
        setState(() {
          _isEditLoaded = false;
        });
      }

      //this way work if we went to push all data from the general screen and it's work
//if(postData.data()!=null){
//  initialVal = {
//            'nameUser': postData.data()['nameUser'],
//            'contentText': postData.data()['contentText'],
//            'like': postData.data()['like'],
//            'id':  postData.data()['id'],
//            'image':  postData.data()['image'],};
//
//}
      _isp = false;
    }
  }

  void submitted(BuildContext context) async {
    var _formValid = _globalKey.currentState.validate();
    if (!_formValid) return;
    if (_imagePath == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('please Pick an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    _globalKey.currentState.save();
    if (postId != null) {
      setState(() {
        _isLoad = true;
      });
      await prov.updatePost(
          editPost.nameUser, editPost.contentText, _imagePath, postId);
      print('in $postId');
      setState(() {
        _isLoad = false;
      });
    } else {
      setState(() {
        _isLoad = true;
      });
      await prov.addPost(editPost.nameUser, editPost.contentText, _imagePath);
      setState(() {
        _isLoad = false;
      });
    }
    Navigator.of(context).pushReplacementNamed(NavigationBar.routeName);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: _isEditLoaded
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _globalKey,
                  child: Container(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 16, top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Center(
                                child: Text(
                                  'Abd Alazeez Alyosfi',
                                  style: TextStyle(
                                      fontSize: 24, color: Color(0XFF5B5B5A)),
                                ),
                              ),
                              SizedBox(
                                width: size.width / 30,
                              ),
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.indigo,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 0.4,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: size.height / 15,
                        ),
                        InputImage(_onSelect, true),
                        SizedBox(
                          height: size.height / 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: TextFormField(
                              initialValue: initialVal['contentText'],
                              onSaved: (val) {
                                editPost = DPost(
                                    image: _imagePath,
                                    nameUser: editPost.nameUser,
                                    contentText: val,
                                    id: editPost.id,
                                    like: editPost.like);
                              },
                              textInputAction: TextInputAction.done,
                              validator: (val) {
                                if (val.isEmpty || val.length < 10)
                                  return 'please enter more than 10 characters';

                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Enter your post',
                                labelStyle: TextStyle(fontSize: 30),
                                hintText: 'please enter more 10 characters ',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 5),
                        ),
                        SizedBox(
                          height: size.height / 15,
                        ),
                        SizedBox(
                          height: size.height / 15,
                          child: Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                RawMaterialButton(
                                  onPressed:()=> submitted(context),
                                  fillColor: Color(0XFFEEF5E6),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 6),
                                    child: _isLoad
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Center(
                                            child: Text(
                                              'POST',
                                              style: TextStyle(
                                                  color: Color(0XFF5B5B5A),
                                                  fontSize: 34),
                                            ),
                                          ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    color: Color(0XFFD5E7BD),
                  ),
                ),
              ),
      ),
    );
  }
}
