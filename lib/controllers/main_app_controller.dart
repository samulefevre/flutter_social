import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';
import 'dart:async';
import 'package:flutter_social/util/fire_helper.dart';
import 'package:flutter_social/models/user.dart';

class MainAppController extends StatefulWidget {
  String uid;
  MainAppController(this.uid);

  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainAppController> {
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

  write() {}

  @override
  Widget build(BuildContext context) {
    return (user == null)
        ? LoadingScaffold()
        : Scaffold(
            body: Center(child: MyText(user.name, color: baseAccent)),
            floatingActionButton:
                FloatingActionButton(onPressed: write(), child: writeIcon, backgroundColor: pointer, ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            key: _globalKey,
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

  buttonSelected(int index) {
    print(index);
    setState(() {
      this.index = index;
    });
  }
}
