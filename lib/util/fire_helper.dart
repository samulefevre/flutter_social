import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_social/view/my_material.dart';

class FireHelper {
  //Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String mail, String pwd) async {
    final FirebaseUser user =
        (await _auth.signInWithEmailAndPassword(email: mail, password: pwd))
            .user;
    return user;
  }

  Future<FirebaseUser> createAccount(
      String mail, String pwd, String name, String surname) async {
    final FirebaseUser user =
        (await _auth.createUserWithEmailAndPassword(email: mail, password: pwd))
            .user;
    String uid = user.uid;
    List<dynamic> followers = [];
    List<dynamic> following = [uid];
    Map<String, dynamic> map = {
      keyName: name,
      keySurname: surname,
      keyImageUrl: "",
      keyFollowers: followers,
      keyFollowing: following,
      keyUid: uid
    };
    addUser(uid, map);
    return user;
  }

  logOut() => _auth.signOut();

  //Database
  static final dataInstance = Firestore.instance;
  final fireUser = dataInstance.collection("users");

  addUser(String uid, Map<String, dynamic> map) {
    fireUser.document(uid).setData(map);
  }

  //Storage
}
