import 'dart:async';
import '../models/item_model.dart';

class Repository {
  final List<Source> _sources;

  final List<Cache> _caches;

  Repository(this._sources, this._caches);

  Future<List<int>> fetchTopIds() async {
    List<int> result;
    Source source;

    for (source in _sources) {
      result = await source.fetchTopIds();
      if (result != null) break;
    }
    return result;
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;

    for (source in _sources) {
      item = await source.fetchItem(id);
      if (item != null) break;
    }

    if (item != null)
      for (var cache in _caches) {
        if (cache != source) {
          cache.addItem(item);
        }
      }
    return item;
  }

  clearCache() async {
    for (var cache in _caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();

  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);

  Future<int> clear();
}
