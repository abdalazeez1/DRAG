import 'package:flutter/material.dart';

class Title1 extends StatefulWidget {
  final Size size;

  Title1(this.size);

  @override
  _Title1State createState() => _Title1State();
}

class _Title1State extends State<Title1> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation curve;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    curve = CurvedAnimation(parent: _controller, curve: Curves.easeInQuint);
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Container(
      alignment: Alignment.center,
      height: widget.size.height / 5,
      width: widget.size.width,
      child: SlideTransition(
          position: curve
              .drive(Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))),
          child:
          Text('DRAG', style: TextStyle(color: Colors.grey, fontSize: 90))),
    );
  }
}