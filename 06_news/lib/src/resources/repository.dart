import 'dart:async';
import '../models/item_model.dart';

class Repository {
  final List<Source> _sources;

  final List<Cache> _caches;

  Repository(this._sources, this._caches);

  Future<List<int>> fetchTopIds() async {
    return null;
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;

    for (source in _sources) {
      item = await source.fetchItem(id);
      if (item != null) break;
    }

    if (item != null)
      for (var cache in _caches) {
        cache.addItem(item);
      }
    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();

  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
