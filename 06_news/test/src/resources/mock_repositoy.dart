import 'dart:async';

import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';

class MockSource implements Source {
  Future<ItemModel> fetchItem(int id) {
    final jsonMap = {
      "id": id,
    };
    final result = ItemModel.fromJson(jsonMap);

    return Future.value(result);
  }

  @override
  Future<List<int>> fetchTopIds() {
    return Future.value([10, 9, 8, 7, 6, 5, 4, 3, 2, 1]);
  }
}

class MockCache implements Source, Cache {
  final cache = Map<int, ItemModel>();

  @override
  Future<int> addItem(ItemModel item) {
    cache[item.id] = item;
    return Future.value(item.id);
  }

  @override
  Future<int> clear() {
    final result = cache.length;
    cache.clear();
    return Future.value(result);
  }

  @override
  Future<ItemModel> fetchItem(int id) {
    return Future.value(cache[id]);
  }

  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }
}
