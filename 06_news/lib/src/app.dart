import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_bloc.dart';
import 'package:news/src/blocs/comments_provider.dart';
import 'blocs/top_stories_provider.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News!",
      onGenerateRoute: onGenerateRoute,
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
