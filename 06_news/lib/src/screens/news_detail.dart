import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/comment.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail(this.itemId);

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    if (bloc == null)
      return Container();
    else
      return Scaffold(
        appBar: AppBar(
          title: Text("Detail"),
        ),
        body: buildBody(bloc),
      );
  }

  buildLoading() {
    return Text("Loading... $itemId");
  }

  buildTitle(String title) {
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.all(5.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) return buildLoading();

        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!snapshot.hasData)
              return buildLoading();
            else {
              if (itemSnapshot.data != null)
                return ListView(
                  children: [
                    buildTitle(itemSnapshot.data.title),
                    buildAuthor(itemSnapshot.data.by),
                    buildComments(itemSnapshot.data.kids ?? [], snapshot.data),
                  ],
                );
            }
            return buildLoading();
          },
        );
      },
    );
  }

  buildComments(List kids, Map<int, Future<ItemModel>> cache) {
    final result = kids.map<Widget>((kid) {
      return Comment(kid);
    }).toList();

    return Column(
      children: result,
    );
  }

  buildAuthor(String author) {
    return Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 15.0),
        child: Text(
          author == "" ? "Deleted" : "by: $author",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
