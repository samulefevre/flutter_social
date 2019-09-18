import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';

class MenuTwoItems extends StatelessWidget {
  final String item1;
  final String item2;
  final PageController pageController;

  MenuTwoItems(
      {@required this.item1,
      @required this.item2,
      @required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50,
      decoration: BoxDecoration(
          color: pointer,
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: CustomPaint(
        painter: MyPainter(pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[itemButton(item1), itemButton(item2)],
        ),
      ),
    );
  }

  Expanded itemButton(String name) {
    return Expanded(
        child: FlatButton(
            child: Text(name),
            onPressed: () {
              int page = (pageController.page == 0) ? 1 : 0;
              pageController.animateToPage(page,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            }));
  }
}
