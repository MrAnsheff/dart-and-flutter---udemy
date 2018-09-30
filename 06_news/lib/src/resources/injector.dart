import 'package:kiwi/kiwi.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';
import "repository.dart";

part 'injector.g.dart';

abstract class Injector {
  void configure() {
    _configureFactories();
    _configureInstances();
  }

  void _configureInstances() {
    Container().registerInstance(
      Repository([
        NewsApiProvider(),
      ], [
        NewsDbProvider(),
      ]),
    );
  }

  @Register.factory(NewsApiProvider)
  void _configureFactories();
}

void setup() {
  _$Injector().configure();
}
