import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: MyText("Porfile page"));
  }
}
