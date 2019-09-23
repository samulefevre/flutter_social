import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/util/fire_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:flutter_social/models/notification.dart';
import 'package:flutter_social/view/tiles/notif_tile.dart';

class NotifPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FireHelper()
          .fireNotif
          .document(me.uid)
          .collection("singleNotif")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snaps) {
        if (!snaps.hasData) {
          return Center(
              child: MyText('Aucune notification',
                  color: pointer, fontSize: 40.0));
        } else {
          List<DocumentSnapshot> documents = snaps.data.documents;
          print(documents.length);
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext ctx, int index) {
              Notif notif = Notif(documents[index]);
              return NotifTile(notif);
            },
          );
        }
      },
    );
  }
}
