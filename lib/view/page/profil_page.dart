import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/view/my_material.dart';

class ProfilPage extends StatefulWidget {
  User user;
  ProfilPage(this.user);

  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: MyText("Porfile page"));
  }
}
