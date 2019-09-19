import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';
import 'dart:async';
import 'package:flutter_social/util/fire_helper.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/view/page/feed_page.dart';
import 'package:flutter_social/view/page/new_post_page.dart';
import 'package:flutter_social/view/page/notif_page.dart';
import 'package:flutter_social/view/page/profil_page.dart';
import 'package:flutter_social/view/page/users_page.dart';

class MainAppController extends StatefulWidget {
  final String uid;
  MainAppController(this.uid);

  @override
  _MainAppControllerState createState() => _MainAppControllerState();
}

class _MainAppControllerState extends State<MainAppController> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  StreamSubscription streamListener;
  User user;
  int index = 0;

  @override
  void initState() {
    super.initState();
    streamListener = FireHelper()
        .fireUser
        .document(widget.uid)
        .snapshots()
        .listen((document) {
      setState(() {
        user = User(document);
      });
    });
  }

  @override
  void dispose() {
    streamListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (user == null)
        ? LoadingScaffold()
        : Scaffold(
            body: showPage(),
            floatingActionButton: FloatingActionButton(
              onPressed: write,
              child: writeIcon,
              backgroundColor: pointer,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            key: _globalKey,
            backgroundColor: base,
            bottomNavigationBar: BottomBar(items: [
              BarItem(
                  icon: homeIcon,
                  onPressed: (() => buttonSelected(0)),
                  selected: (index == 0)),
              BarItem(
                  icon: friendsIcon,
                  onPressed: (() => buttonSelected(1)),
                  selected: (index == 1)),
              Container(width: 0, height: 0),
              BarItem(
                  icon: notifIcon,
                  onPressed: (() => buttonSelected(2)),
                  selected: (index == 2)),
              BarItem(
                  icon: profilIcon,
                  onPressed: (() => buttonSelected(3)),
                  selected: (index == 3))
            ]),
          );
  }

  write() {
    _globalKey.currentState.showBottomSheet((builder) => NewPost());
  }

  buttonSelected(int index) {
    print(index);
    setState(() {
      this.index = index;
    });
  }

  Widget showPage() {
    switch (index) {
      case 0:
        return FeedPage(user);
      case 1:
        return UsersPage(user);
      case 2:
        return NotifPage(user);
      default:
        return ProfilPage(user);
    }
  }
}
