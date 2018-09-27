import 'dart:async';
import 'package:flutter/material.dart';
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

  buildBody(bloc) {
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
                return buildTitle(itemSnapshot.data.title);
            }
            return buildLoading();
          },
        );
      },
    );
  }
}
