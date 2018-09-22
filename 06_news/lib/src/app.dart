import 'package:flutter/material.dart';
import 'blocs/top_stories_provider.dart';
import 'screens/news_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TopStoriesProvider(
      child: MaterialApp(
        title: "News!",
        // home: NewsList(),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) {
            return NewsList();
          });
        },
      ),
    );
  }
}
