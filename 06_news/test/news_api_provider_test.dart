import 'package:news/main.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/news_api_provider.dart';
import "dart:convert";
import "package:test/test.dart";
import "package:http/http.dart";
import "package:http/testing.dart";

void main() {
  test('FetchTopIds returns a list of ids', () async {
    NewsApiProvider newsApiProvider = NewsApiProvider();
    final ids = await newsApiProvider.fetchTopIds();
    expect(ids, isInstanceOf<List<int>>());
  });

  test("Mocked FetchTopIds", () async {
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4, 5]), 200);
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4, 5]);
  });

  test("fetchItem returns an ItemModel", () async {
    final id = 8863;
    NewsApiProvider newsApiProvider = NewsApiProvider();

    final item = await newsApiProvider.fetchItem(id);
    expect(item, isInstanceOf<ItemModel>());
  });
}
