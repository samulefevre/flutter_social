import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';

class NotifPage extends StatefulWidget {
  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: MyText("Notif page"));
  }
}
