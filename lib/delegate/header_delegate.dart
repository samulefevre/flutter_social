import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/view/my_widgets/constants.dart';
import 'package:flutter_social/view/my_widgets/my_text.dart';
import 'package:flutter_social/view/my_widgets/profile_image.dart';
//import 'package:flutter_social/view/my_material.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  User user;
  VoidCallback callback;
  bool scrolled;

  HeaderDelegate(
      {@required this.user, @required this.callback, @required this.scrolled});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      padding: EdgeInsets.all(10.0),
      color: baseAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          (scrolled)
              ? Container(width: 0.0, height: 0.0)
              : MyText("${user.surname} ${user.name}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ProfileImage(urlString: null, onPressed: null),
              MyText((user.description == null)
                  ? ('Aucune description')
                  : user.description)
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.0,
            color: base,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InkWell(
                child: MyText("Followers: ${user.followers.length}"),
              ),
              InkWell(
                child: MyText("Following: ${user.following.length - 1}"),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => (scrolled) ? 150.0 : 200.0;

  @override
  double get minExtent => (scrolled) ? 150.0 : 200.0;

  @override
  bool shouldRebuild(HeaderDelegate oldDelegate) =>
      scrolled != oldDelegate.scrolled || user != oldDelegate.user;
}
