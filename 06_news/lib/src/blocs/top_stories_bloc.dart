import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/news_api_provider.dart';
import '../resources/news_db_provider.dart';
import '../resources/repository.dart';

class TopStoriesBloc {
  final _topIds = PublishSubject<List<int>>();
  Observable<List<int>> get topIds => _topIds.stream;

  Repository _repository;

  TopStoriesBloc() {
    final _dbProvider = NewsDbProvider();
    _repository = Repository([_dbProvider, NewsApiProvider()], [_dbProvider]);
  }

  void fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  void dispose() {
    _topIds.close();
  }
}
