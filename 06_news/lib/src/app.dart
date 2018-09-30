import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'screens/news_list.dart';
import 'blocs/top_stories_provider.dart';

import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

import 'resources/injector.dart' as injector;

import 'screens/routes.dart' as routes;

class App extends StatelessWidget {
  final router = Router();
  App() {
    // Define home page.
    router.define(
      '/',
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return TopStoriesProvider(child: NewsList());
      }),
    );

    router.define('/news/:itemId', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      final itemId = int.tryParse(params["itemId"][0]);
      if (itemId == null) return null;
      return CommentsProvider(itemId, child: NewsDetail(itemId));
    }));

    injector.setup();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News!",
      // onGenerateRoute: onGenerateRoute,
      onGenerateRoute: router.generator,
    );
  }

  Route onGenerateRoute(RouteSettings settings) {
    if (settings.name.startsWith("/news")) {
      return MaterialPageRoute(builder: (context) {
        var itemId = int.tryParse(
            settings.name.substring(settings.name.lastIndexOf("/") + 1));

        return CommentsProvider(itemId, child: NewsDetail(itemId));
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        return TopStoriesProvider(child: NewsList());
      });
    }
  }
}
