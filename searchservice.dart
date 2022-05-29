import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByTitle(String searchField) {
    return FirebaseFirestore.instance
        .collection('news')
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
