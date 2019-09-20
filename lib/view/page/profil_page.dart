import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:flutter_social/util/fire_helper.dart';
import 'package:flutter_social/delegate/header_delegate.dart';

class ProfilPage extends StatefulWidget {
  final User user;
  ProfilPage(this.user);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<ProfilPage> {
  bool _isMe = false;
  ScrollController controller;
  double expanded = 200.0;
  bool get _showTitle {
    return controller.hasClients &&
        controller.offset > expanded - kToolbarHeight;
  }

  @override
  void initState() {
    super.initState();
    _isMe = (widget.user.uid == me.uid);
    controller = ScrollController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FireHelper().postsFrom(widget.user.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return LoadingCenter();
        } else {
          List<DocumentSnapshot> documents = snapshot.data.documents;
          return CustomScrollView(
            controller: controller,
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: expanded,
                actions: <Widget>[],
                flexibleSpace: FlexibleSpaceBar(
                  title: _showTitle ? MyText(widget.user.surname + " " + widget.user.name ) : MyText(""),
                  background: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: profileImage, fit: BoxFit.cover)),
                    child: Center(
                        child: ProfileImage(
                            urlString: widget.user.imageUrl,
                            size: 75.0,
                            onPressed: null)),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: HeaderDelegate(
                    user: widget.user, callback: () {}, scrolled: _showTitle),
              ),
              SliverList(delegate:
                  SliverChildBuilderDelegate((BuildContext context, index) {
                return ListTile(
                  title: MyText("Nouvelle tile: $index}"),
                );
              }))
            ],
          );
        }
      },
    );
  }
}
