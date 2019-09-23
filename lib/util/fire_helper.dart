import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_social/models/post.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
    List<dynamic> followers = [uid];
    List<dynamic> following = [];
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

  Stream<QuerySnapshot> postsFrom(String uid) =>
      fireUser.document(uid).collection("posts").snapshots();

  addUser(String uid, Map<String, dynamic> map) {
    fireUser.document(uid).setData(map);
  }

  modifyUser(Map<String, dynamic> data) {
    fireUser.document(me.uid).updateData(data);
  }

  modifyPicture(File file) {
    StorageReference ref = storageUser.child(me.uid);
    addImage(file, ref).then((finalised) {
      Map<String, dynamic> data = {keyImageUrl: finalised};
      modifyUser(data);
    });
  }

  addFollow(User other) {
    if (me.following.contains(other.uid)) {
      me.ref.updateData({
        keyFollowing: FieldValue.arrayRemove([other.uid])
      });
      other.ref.updateData({
        keyFollowers: FieldValue.arrayRemove([me.uid])
      });
    } else {
      me.ref.updateData({
        keyFollowing: FieldValue.arrayUnion([other.uid])
      });
      other.ref.updateData({
        keyFollowers: FieldValue.arrayUnion([me.uid])
      });
    }
  }

  addLike(Post post) {
    if (post.likes.contains(me.uid)) {
      post.ref.updateData({
        keyLikes: FieldValue.arrayRemove([me.uid])
      });
    } else {
      post.ref.updateData({
        keyLikes: FieldValue.arrayUnion([me.uid])
      });
    }
  }

  addPost(String uid, String text, File file) {
    int date = DateTime.now().millisecondsSinceEpoch.toInt();
    List<dynamic> likes = [];
    List<dynamic> comments = [];
    Map<String, dynamic> map = {
      keyUid: uid,
      keyLikes: likes,
      keyComments: comments,
      keyDate: date
    };
    if (text != null && text != "") map[keyText] = text;
    if (file != null) {
      StorageReference ref = storagePosts.child(uid).child(date.toString());
      addImage(file, ref).then((finalised) {
        String imageUrl = finalised;
        map[keyImageUrl] = imageUrl;
        fireUser.document(uid).collection("posts").document().setData(map);
      });
    } else {
      fireUser.document(uid).collection("posts").document().setData(map);
    }
  }

  addComment(DocumentReference ref, String text) {
    Map<dynamic, dynamic> map = {
      keyUid: me.uid,
      keyText: text,
      keyDate: DateTime.now().millisecondsSinceEpoch.toInt()
    };
    ref.updateData({
      keyComments: FieldValue.arrayUnion([map])
    });
  }

  //Storage
  static final storageInstance = FirebaseStorage.instance.ref();
  final storageUser = storageInstance.child("users");
  final storagePosts = storageInstance.child("posts");

  Future<dynamic> addImage(File file, StorageReference ref) async {
    StorageUploadTask task = ref.putFile(file);
    StorageTaskSnapshot snapshot = await task.onComplete;
    Future<dynamic> urlString = snapshot.ref.getDownloadURL();
    return urlString;
  }
}
