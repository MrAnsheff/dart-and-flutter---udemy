import 'package:flutter/material.dart';

void main() {
  var app = MaterialApp(
    home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text("+"),
          onPressed: () => print("Hi there!"),
        ),
        appBar: AppBar(title: Text("Let's see Images!"))),
  );

  runApp(app);
}
