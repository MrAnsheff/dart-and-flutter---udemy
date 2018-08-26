import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/image_model.dart';

class App extends StatefulWidget {
  @override
  AppState createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  String url = "https://jsonplaceholder.typicode.com/photos/";

  void fetchImage() async {
    counter++;

    var response = await http.get(url + "$counter");
    var image = ImageModel.fromJson(json.decode(response.body));
    print(image);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(child: Text("$counter")),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: fetchImage,
          ),
          appBar: AppBar(title: Text("Let's see Images!"))),
    );
  }
}
