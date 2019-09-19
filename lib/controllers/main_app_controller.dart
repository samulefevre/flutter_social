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
  StreamSubscription streamListener;
  User user;

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
    return (user == null) ? LoadingScaffold() : Scaffold(body: Center(child: MyText(user.name, color: baseAccent)));
  }
}
