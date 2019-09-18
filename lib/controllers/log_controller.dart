import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';

class LogController extends StatefulWidget {
  _LogState createState() => _LogState();
}

class _LogState extends State<LogController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height >= 650.0)
                  ? MediaQuery.of(context).size.height
                  : 650.0,
              decoration: Mygradient(startColor: base, endColor: baseAccent),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    PaddingWith(widget: Image(image: logoImage, height: 100.0)),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
