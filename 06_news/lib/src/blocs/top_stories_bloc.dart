import 'dart:async';
import 'package:kiwi/kiwi.dart';
import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';

class TopStoriesBloc {
  Repository _repository;

  final _topIds = PublishSubject<List<int>>();
  Observable<List<int>> get topIds => _topIds.stream;

  final _items = PublishSubject<int>();
  Function(int) get fetchItem => _items.sink.add;

  final BehaviorSubject<Map<int, Future<ItemModel>>> _itemsOutput =
      BehaviorSubject<Map<int, Future<ItemModel>>>();
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  TopStoriesBloc() {
    final container = Container();
    _repository = container<Repository>();

    _items.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
    return ids;
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  void dispose() {
    _topIds.close();
    _itemsOutput.close();
    _items.close();
  }

  clearCache() {
    return _repository.clearCache();
  }
}
