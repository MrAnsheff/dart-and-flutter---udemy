import 'package:flutter/material.dart';
import "../models/image_model.dart";

class ImageList extends StatelessWidget {
  final List<ImageModel> images;
  ImageList(List<ImageModel> imageList) : images = imageList ?? [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return buildImage(images[index]);
      },
    );
  }

  Widget buildImage(ImageModel image) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          children: <Widget>[Image.network(image.url), Text(image.title)],
        ));
  }
}
