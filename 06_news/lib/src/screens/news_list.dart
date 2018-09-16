import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/top_stories_provider.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = TopStoriesProvider.of(context);

    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text("News!"),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(TopStoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return FutureBuilder(
              future: bloc.getItem(snapshot.data[index]),
              builder:
                  (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
                if ((snapshot.hasData) && (snapshot.data != null))
                  return Text(snapshot.data.title);
                return Container();
              },
            );
          },
        );
      },
    );
  }
}
