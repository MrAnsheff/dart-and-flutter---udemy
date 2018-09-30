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

  void _addItemToCache(ItemModel item) {
    for (var cache in _caches) {
      cache.addItem(item);
    }
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel result;

    result = await _fetchItemFromCaches(id);
    if (result != null) return result;

    result = await _fetchItemFromSources(id);

    if (result != null) _addItemToCache(result);

    return result;
  }

  Future<ItemModel> _fetchItemFromCaches(int id) async {
    ItemModel result;
    for (var cache in _caches) {
      result = await cache.fetchItem(id);
      if (result != null) break;
    }
    return result;
  }

  Future<ItemModel> _fetchItemFromSources(int id) async {
    ItemModel result;
    for (var source in _sources) {
      result = await source.fetchItem(id);
      if (result != null) break;
    }
    return result;
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
  Future<ItemModel> fetchItem(int id);

  Future<int> addItem(ItemModel item);

  Future<int> clear();
}
