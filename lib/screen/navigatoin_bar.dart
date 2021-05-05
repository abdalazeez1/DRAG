import 'package:drag/screen/PostScreen.dart';
import 'package:drag/screen/profile.dart';
import 'package:drag/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import './chat_screen.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';

import 'add_screen.dart';



class NavigationBar extends StatefulWidget {
  static String routeName='/NavigationName';
  final titles = ['Main', 'Search', 'Edit', 'Chat', 'Profile'];
  final colors = [Colors.red, Colors.purple, Colors.teal, Colors.green, Colors.cyan];
  final pages=[PostScreen(), SearchScreen(), AddScreen(),ChatScreen(),ProfileScreen()];
  final icons = [
    CupertinoIcons.home,
    CupertinoIcons.search,
    Icons.edit,
    Icons.near_me_sharp,
    CupertinoIcons.profile_circled
  ];

  NavigationBar({Key key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);

    _pageController = PageController(
        initialPage: 0,
        keepPage: false,
        viewportFraction: 1.0
    );
    _pageController.addListener(handlePageChange);

    super.initState();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification && scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: NotificationListener<ScrollNotification>(
          // ignore: missing_return
          onNotification: (scrollNotification) {
            checkUserDragging(scrollNotification);

          },
          child: PageView(
            controller: _pageController,
            children: widget.pages.map((c) => c).toList(),
            onPageChanged: (page) {
            },
          ),
        ),
        bottomNavigationBar: BubbledNavigationBar(
          controller: _menuPositionController,
          initialIndex: 0,
          itemMargin: EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: Colors.white,
          defaultBubbleColor: Colors.blue,
          onTap: (index) {
            _pageController.animateToPage(
                index,
                curve: Curves.easeInOutQuad,
                duration: Duration(milliseconds: 500)
            );
          },
          items: widget.titles.map((title) {
            var index = widget.titles.indexOf(title);
            var color = widget.colors[index];
            return BubbledNavigationBarItem(
              icon: getIcon(index, color),
              activeIcon: getIcon(index, Colors.white),
              bubbleColor: color,
              title: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            );
          }).toList(),
        )
    );
  }

  Padding getIcon(int index, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Icon(widget.icons[index], size: 30, color: color),
    );
  }
}