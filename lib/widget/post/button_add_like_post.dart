import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag/provider/provider_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonAddLike extends StatefulWidget {
  final idPost;

  ButtonAddLike(this.idPost);

  @override
  _ButtonAddLikeState createState() => _ButtonAddLikeState();
}

class _ButtonAddLikeState extends State<ButtonAddLike> {
  var ref;

  var prov = ProviderPost();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    prov = Provider.of<ProviderPost>(context, listen: false);
  }

  bool _idLoad = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.idPost)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Expanded(child: Center(
              child: CircularProgressIndicator(),
            ));
          }

          return _idLoad
              ? Expanded(child: Center(
            child: CircularProgressIndicator(),
          ))
              :
          Expanded(
              child: Center(
                child: TextButton.icon(
                  onPressed: addLike,
                  label:
                  Text('like ${snapshot.data.data()['like'].length ?? 0} ', style: TextStyle(fontSize: 14)),
                  icon: Icon(
                    Icons.thumb_up_alt_outlined,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ));
        });
  }

  Future<void> addLike() async {
    setState(() {
      _idLoad = true;
    });
    await prov.addLike(widget.idPost);
    setState(() {
      _idLoad = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}