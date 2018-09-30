import 'package:news/src/models/item_model.dart';

import 'package:news/src/resources/repository.dart';
import "package:test/test.dart";

import 'mock_repositoy.dart';

void main() {
  test('create empty repository', () async {
    Repository repository = Repository([], []);
    ItemModel item = await repository.fetchItem(8863);
    expect(item, null);
  });

  group('test repository cache', () {
    test('fetch item from empty cache', () async {
      final repository = Repository([], [MockCache()]);
      ItemModel item = await repository.fetchItem(1);

      expect(item, null);
    });

    test('saving to cache', () async {
      var cache = MockCache();
      final repository = Repository([MockSource()], [cache]);

      ItemModel item = await repository.fetchItem(1);
      ItemModel cacheResult = await cache.fetchItem(1);

      expect(item.id, cacheResult.id);
    });

    test('clearing cache', () async {
      var cache = MockCache();
      final repository = Repository([MockSource()], [cache]);
      await repository.fetchItem(1);
      repository.clearCache();

      ItemModel result = await cache.fetchItem(1);
      expect(result, null);
    });
  });
}
