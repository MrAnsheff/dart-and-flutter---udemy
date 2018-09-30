import 'dart:async';

import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../widgets/news_list_tile_shimmer.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int depth;
  final int itemId;

  Comment(this.itemId) : depth = 0;
  Comment._reply(this.itemId, this.depth);

  buildText(String text) {
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.all(5.0),
        child: Text(
          text,
          textAlign: TextAlign.justify,
        ));
  }

  buildLoading() {
    return NewsListTileShimmer(leftMargin: depth * 16.0);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    if (bloc == null) return Container();

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
              if (itemSnapshot.data != null) {
                final children = <Widget>[
                  ListTile(
                    title: buildText(itemSnapshot.data.text ?? ""),
                    subtitle: itemSnapshot.data.by == ""
                        ? Text("Deleted")
                        : Text("by: ${itemSnapshot.data.by}"),
                    contentPadding: EdgeInsets.only(
                      right: 16.0,
                      left: depth * 16.0,
                    ),
                  ),
                  Divider(),
                ];
                itemSnapshot.data.kids.forEach((kid) {
                  children.add(Comment._reply(kid, depth + 1));
                });

                return Column(
                  children: children,
                );
              }
            }
            return buildLoading();
          },
        );
      },
    );
  }
}
