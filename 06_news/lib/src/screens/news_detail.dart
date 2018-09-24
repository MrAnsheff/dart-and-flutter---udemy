import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_provider.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;
  NewsDetail(this.itemId);

  @override
  Widget build(BuildContext context) {
    // final bloc = CommentsProvider.of(context);
    // bloc.fetchItemWithComments(itemId);

    return CommentsProvider(
      itemId,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detail"),
        ),
        body: Text("Details screen. Item $itemId"),
      ),
    );
  }
}
