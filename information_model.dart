import 'package:cloud_firestore/cloud_firestore.dart';

class Info {
  final String url;
  final String title;
  final String desc;

  Info.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : this.url = snapshot['url'],
        this.title = snapshot['title'],
        this.desc = snapshot['desc'];
}
