import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';
import 'dart:async';
import 'package:flutter_social/util/fire_helper.dart';

class MainAppController extends StatefulWidget {
  String uid;
  MainAppController(this.uid);

  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainAppController> {

  StreamSubscription streamListener;

  @override
  void initState() {
    super.initState();
    streamListener = FireHelper().fireUser.document(widget.uid).snapshots().listen((document) {
      print(document.data);
    });
  }

  @override
  void dispose() {
    streamListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold();
  }
}