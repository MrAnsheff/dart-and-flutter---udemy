import 'package:flutter/material.dart';
import 'package:news/src/widgets/news_list_tile_shimmer.dart';
import '../widgets/news_list_tile.dart';

import '../blocs/top_stories_provider.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = TopStoriesProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text(" News!"),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(TopStoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return NewsListTileShimmer();
        }

        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              bloc.fetchItem(snapshot.data[index]);
              return NewsListTile(itemId: snapshot.data[index]);
            });
      },
    );
  }
}
