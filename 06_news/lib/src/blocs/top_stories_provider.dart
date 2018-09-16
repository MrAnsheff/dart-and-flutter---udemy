import 'package:flutter/material.dart';
import "top_stories_bloc.dart";

class TopStoriesProvider extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  final TopStoriesBloc bloc;

  TopStoriesProvider({Key key, Widget child})
      : bloc = TopStoriesBloc(),
        super(key: key, child: child);

  static TopStoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TopStoriesProvider)
            as TopStoriesProvider)
        .bloc;
  }
}
