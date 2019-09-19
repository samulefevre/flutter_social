import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';

class NewPost extends StatefulWidget {

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    return Container(color: base, height: MediaQuery.of(context).size.height - 100.0,);
  }
}