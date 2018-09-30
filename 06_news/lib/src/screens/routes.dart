import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../blocs/top_stories_provider.dart';
import '../blocs/comments_provider.dart';
import 'news_detail.dart';
import 'news_list.dart';

var _homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return TopStoriesProvider(child: NewsList());
});

var _newsDetailHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  final itemId = int.tryParse(params["itemId"][0]);
  return CommentsProvider(itemId, child: NewsDetail(itemId));
});

void setup(Router router) {
  router.notFoundHandler = _homeHandler;
  router.define(
    '/',
    handler: _homeHandler,
  );

  router.define(
    '/news/:itemId',
    handler: _newsDetailHandler,
  );
}
