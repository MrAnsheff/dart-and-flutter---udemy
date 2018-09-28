import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/news_list_tile_shimmer.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final Future<ItemModel> comment;
  Comment(this.comment);

  buildText(String text) {
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.all(5.0),
        child: Text(
          text,
          textAlign: TextAlign.justify,
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: comment,
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return NewsListTileShimmer();
        }

        final item = snapshot.data;

        final children = <Widget>[
          ListTile(
            title: buildText(item.text ?? ""),
            subtitle: item.by == "" ? Text("Deleted") : Text("by: ${item.by}"),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: 16.0,
            ),
          ),
          Divider(),
        ];

        return Column(
          children: children,
        );
      },
    );
  }
}
