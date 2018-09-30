import 'package:flutter/material.dart';

class NewsListTileShimmer extends StatelessWidget {
  final double leftMargin;

  const NewsListTileShimmer({this.leftMargin = 0.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildBox(),
          subtitle: buildBox(),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }

  Widget buildBox() {
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: leftMargin),
    );
  }
}
