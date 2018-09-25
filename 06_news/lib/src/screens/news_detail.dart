import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_provider.dart';
import 'package:news/src/models/item_model.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail(this.itemId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) return Text("Loading...");

        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!snapshot.hasData)
              return Text("Loading...");
            else {
              if (itemSnapshot.data != null)
                return Text(itemSnapshot.data.title);
            }
            return Text("Loading...");
          },
        );
      },
    );
  }
}
