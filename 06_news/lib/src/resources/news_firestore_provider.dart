import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/item_model.dart';

import 'repository.dart';

class NewsFirestoreProvider implements Cache {
  final String _path = 'news';
  final Firestore _firestore = Firestore.instance;

  @override
  Future<int> addItem(ItemModel item) {
    print("NewsFirestoreProvider.addItem");
    _firestore.runTransaction((Transaction transactionHandler) async {
      return _firestore
          .collection(_path)
          .document(item.id.toString())
          .setData(item.toMap());
    });
    return null;
  }

  @override
  Future<int> clear() {
    var totalDeleted = 0;
    _firestore.runTransaction((Transaction transactionHandler) async {
      await _firestore
          .collection(_path)
          .snapshots()
          .forEach((querySnapshot) async {
        totalDeleted = querySnapshot.documents.length;

        querySnapshot.documents.forEach((DocumentSnapshot doc) {
          doc.reference.delete();
        });
      });
    });
    return Future.value(totalDeleted);
  }

  @override
  Future<ItemModel> fetchItem(int id) {
    return _firestore
        .collection(_path)
        .document(id.toString())
        .get()
        .then((itemSnapshot) {
      if (itemSnapshot.data != null)
        return ItemModel.fromJson(itemSnapshot.data);
    });
  }
}
