import 'package:flutter/material.dart';
import 'blocs/top_stories_provider.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TopStoriesProvider(
      child: MaterialApp(
        title: "News!",
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }

  Route onGenerateRoute(RouteSettings settings) {
    print("onGenerateRoute: ${settings.name}");
    return MaterialPageRoute(builder: (context) {
      if (settings.name.startsWith("/news")) {
        var itemId = int.tryParse(
            settings.name.substring(settings.name.lastIndexOf("/") + 1));

        return NewsDetail(itemId);
      } else {
        return NewsList();
      }
    });
  }
}
