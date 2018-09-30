import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../blocs/top_stories_provider.dart';
import 'news_detail.dart';
import 'news_list.dart';

var homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return TopStoriesProvider(child: NewsList());
});
