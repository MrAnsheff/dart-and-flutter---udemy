import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'widgets/image_list.dart';
import 'models/image_model.dart';

class App extends StatefulWidget {
  @override
  AppState createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  final String url = "https://jsonplaceholder.typicode.com/photos/";
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    counter++;

    var response = await http.get(url + "$counter");
    var image = ImageModel.fromJson(json.decode(response.body));

    setState(() {
      images.add(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ImageList(images),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: fetchImage,
          ),
          appBar: AppBar(title: Text("Let's see Images!"))),
    );
  }
}
