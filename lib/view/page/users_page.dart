import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: MyText("Liste d'utilisateurs"));
  }
}
