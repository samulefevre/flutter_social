import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_social/view/my_material.dart';

import 'controllers/main_app_controller.dart';
import 'controllers/log_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          canvasColor: Colors.transparent,
          primaryColor: base,
          accentColor: baseAccent),
      home: _handleAuth(),
    );
  }

  Widget _handleAuth() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        return (!snapshot.hasData)
            ? LogController()
            : MainAppController(snapshot.data.uid);
      },
    );
  }
}
