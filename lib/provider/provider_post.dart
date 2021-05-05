import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag/modales/d_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProviderPost with ChangeNotifier {
  bool isFavourite;
  bool _isNUll=false;
  bool get isNull{
    return _isNUll;
  }
  ixNull(bool isnull){
    _isNUll=isnull;
    notifyListeners();
  }
  

  final timeNow = DateTime.now().toIso8601String();

  Future<void> addPost(String nameUser, String contentText, File image) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    try {
//      final user = await  FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
//      print('dssssssssssssssssssssssssssssssssssssssssssssssssss');
      final dataUser = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      final ref =
          FirebaseStorage.instance.ref('profile_user').child(timeNow + '.jpg');
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('posts').doc(timeNow).set({
        'id': timeNow,
        'time': Timestamp.now(),
        'image': url,
        'contentText': contentText,
        'nameUser': dataUser['userName'],
        'like': [],
//        'imageUser': user['image'],
        'comment': [],
        'imageUser': dataUser['image']
      });
//      print('after add post aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    } catch (e) {
      print(e);
      print('there are error   here error');
    }
  }

  Future<void> updatePost(
      String nameUser, String contentText, File image, String id) async {
    print(id);
    await FirebaseFirestore.instance.collection('posts').doc(id).update({
      'image': image,
      'contentText': contentText,
      'nameUser': nameUser,
    });
  }

  Future<void> addComment(String comment, String idPost) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final dataUser = await  FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
    await FirebaseFirestore.instance.collection('posts').doc(idPost).update({
      'comment': FieldValue.arrayUnion([
        {
          'comment': comment,
          'create': Timestamp.now(),
          'idUser': currentUser.uid,
          'nameUser': dataUser['userName'],
        }
      ])
    });
  }

  Future addLike(String idPost) async {
    var ref = FirebaseFirestore.instance.collection('posts').doc(idPost);
    var postData = await ref.get();
    var idUser = FirebaseAuth.instance.currentUser.uid;
  print('222222222222222222222222222222222222222222222222222222');
    //method extract index user where id == id  and return index and update information user due to index
    int index = fromMap(postData['like'], idUser);
//  print(postData['like']);
    if (index >= 0) {
//    bool oldLike = await postData['like'][index]['like'];
    print('""""""""""""""""""""""""""""""""""""""""""eeeeeeeeeeeeeeeeeeeeeeeeeee"""""$index');
      await ref.update({
//             'like':FieldValue.delete(),//this delete all array
        'like': FieldValue.arrayRemove([
          {
            'like': true, 'name': postData['nameUser'], 'url': postData['image'],'uid':idUser
          }
        ]),
      });
    } else {
      await ref.update({
        'like': FieldValue.arrayUnion([
          {'like': true, 'name': postData['nameUser'], 'url': postData['image'],'uid':idUser}
        ]),
      });
    }
  }

  int fromMap(var likeData, String currentUserId) {
    int index=-1;
//    print(';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');

    for (int i = 0; i < likeData.length??0; i++) {

//    Like(like: likeData[index]['like'],userId:likeData[index]['like'] );
      if (likeData[i]['uid'] == currentUserId) {
//      print('66666666666666666666666666666666666666666666666666666666666666666666$i');
        index = i;
      }
    }
//  print('indeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeex$index');
    return index;
  }

  Future<bool> getIsFavourite(var likeData, String id) async {
    int re = fromMap(likeData, id);
    bool love = false;
    if (re >= 0) {
      love = false;
    }
    if (re == -1) love = true;
//    print('lovvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvve$love');
    return love;
  }

  final firebase = FirebaseFirestore.instance;
  List<DPost> _dPost = [
//    DPost(
//        nameUser: 'Abd Alazeez Alyosfi',
//        contentText:
//            "hallo i'ma Abd Alazeez Alyosfi   i write hera a demo for post in drag ",
//        image: null,
//        id: "1111",
//        like: 5),
//    DPost(
//        nameUser: 'Mohame mohamed',
//        contentText:
//            "hallo i'ma Abd Alazeez Alyosfi   i write hera a demo for post in drag ",
//        image: null,
//        id: "1111111111111111",
//        like: 5),
  ];

  List<DPost> get dPost {
    return [..._dPost];
  }

//  updateLike(DPost oldPost, int index) {
//    final postID = find(oldPost.id);
//    if (postID != null) {
//      bool like =! (oldPost.like) ;
//      _dPost.removeAt(index);
//      _dPost.insert(
//          index,
//          DPost(
//              id: oldPost.id,
//              image: oldPost.image,
//              contentText: oldPost.contentText,
//              nameUser: oldPost.nameUser,
//              like: like));
//    }
//    notifyListeners();
//  }

//  void updatePost(DPost dpost, String id) {
//    int index = _dPost.indexWhere((element) => id == element.id);
//    _dPost[index] = dpost;
//    notifyListeners();
//  }

  find(String id) {
    return _dPost.firstWhere((element) => element.id == id,
        orElse: () => DPost(
              image: null,
              nameUser: "",
              contentText: "",
            ));
  }

  search(String name) {
    _dPost.forEach((element) {
      if (name.trim().toLowerCase() == element.nameUser.trim().toLowerCase()) {
        return element.id;
      }
      return null;
    });
  }

  delete(String id) {
    _dPost.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
