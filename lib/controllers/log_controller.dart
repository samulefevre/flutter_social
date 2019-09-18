import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';

class LogController extends StatefulWidget {
  _LogState createState() => _LogState();
}

class _LogState extends State<LogController> {
  PageController _pageController;
  TextEditingController _mail;
  TextEditingController _pwd;
  TextEditingController _name;
  TextEditingController _surname;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _mail = TextEditingController();
    _pwd = TextEditingController();
    _name = TextEditingController();
    _surname = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _mail.dispose();
    _pwd.dispose();
    _name.dispose();
    _surname.dispose();
    super.dispose();
  }

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
                    PaddingWith(
                      widget: MenuTwoItems(
                          item1: "Connexion",
                          item2: "Création",
                          pageController: _pageController),
                      top: 20.0,
                      bottom: 20.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        children: <Widget>[logView(0), logView(1)],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget logView(int index) {
    return Column(
      children: <Widget>[
        PaddingWith(
          widget: Card(
            elevation: 7.5,
            color: white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: listItems((index == 0)),
                )),
          ),
          top: 15.0,
          bottom: 15.0,
          left: 20.0,
          right: 20.0,
        ),
        PaddingWith(
          widget: Card(
            elevation: 7.5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            child: Container(
              width: 300.0,
              height: 50.0,
              decoration: Mygradient(
                  startColor: baseAccent,
                  endColor: base,
                  radius: 25.0,
                  horizontal: true),
              child: FlatButton(
                onPressed: () {},
                child: Text((index == 0) ? "Se connecter" : "Créer un compte"),
              ),
            ),
          ),
          top: 15.0,
          bottom: 15.0,
        ),
      ],
    );
  }

  List<Widget> listItems(bool exists) {
    List<Widget> list = [];
    if (!exists) {
      list.add(MyTextField(
        controller: _surname,
        hint: "Entrez votre prénom",
      ));
      list.add(MyTextField(
        controller: _name,
        hint: "Entrez votre nom",
      ));
    }
    list.add(MyTextField(
      controller: _mail,
      hint: "Entrez votre adresse mail",
      type: TextInputType.emailAddress,
    ));
    list.add(MyTextField(
      controller: _pwd,
      hint: "Entrez votre mot de passe",
      obscure: true,
    ));
    return list;
  }
}
