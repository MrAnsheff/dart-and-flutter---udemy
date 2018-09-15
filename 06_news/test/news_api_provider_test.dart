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
    NewsApiProvider newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) async {
      final jsonMap = {
        "by": "dhouston",
        "descendants": 2,
        "id": 8863,
        "kids": [8952, 8876],
        "score": 111,
        "time": 1175714200,
        "title": "My YC app: Dropbox - Throw away your USB drive",
        "type": "story",
        "url": "http://www.getdropbox.com/u/2/screencast.html"
      };
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(id);

    expect(item.id, 8863);
  });
}
