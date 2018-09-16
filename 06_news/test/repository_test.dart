import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/resources/news_db_provider.dart';
import 'package:news/src/resources/repository.dart';
import "dart:convert";
import "package:test/test.dart";
import "package:http/http.dart";
import "package:http/testing.dart";

void main() {
  test('create repository', () async {
    NewsApiProvider apiProvider = NewsApiProvider();
    // NewsDbProvider dbProvider = NewsDbProvider();

    Repository repository = Repository([apiProvider], []);
    ItemModel item = await repository.fetchItem(8863);

    expect(item.id, 8863);
  });
}
