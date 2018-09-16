import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/news_api_provider.dart';
import '../resources/news_db_provider.dart';
import '../resources/repository.dart';

class TopStoriesBloc {
  Repository _repository;

  final _topIds = PublishSubject<List<int>>();
  Observable<List<int>> get topIds => _topIds.stream;

  final _items = BehaviorSubject<int>();
  Function(int) get fetchItems => _items.sink.add;

  TopStoriesBloc() {
    final _dbProvider = NewsDbProvider();
    _repository = Repository([_dbProvider, NewsApiProvider()], [_dbProvider]);
  }

  void fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  Future<ItemModel> getItem(int id) async {
    return await _repository.fetchItem(id);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  void dispose() {
    _topIds.close();
    _items.close();
  }
}
