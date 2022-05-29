import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String url;
  final String category;
  final String title;
  final int id;

  bool isFavorite;

  News.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : this.url = snapshot['url'],
        this.category = snapshot['category'],
        this.title = snapshot['title'],
        this.isFavorite = snapshot['isBookmarked'],
        this.id = snapshot['id'];
}
