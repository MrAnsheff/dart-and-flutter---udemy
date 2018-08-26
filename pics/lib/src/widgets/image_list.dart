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
        return Container(
            margin: EdgeInsets.all(20.0),
            child: Image.network(images[index].url));
      },
    );
  }
}
