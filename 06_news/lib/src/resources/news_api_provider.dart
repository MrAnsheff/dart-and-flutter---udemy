import 'dart:async';

import "package:http/http.dart" show Client;
import 'dart:convert';

import '../models/item_model.dart';

final _root = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    return await client.get("$_root/topstories.json").then((response) {
      return List<int>.from(json.decode(response.body));
    });
  }

  Future<ItemModel> fetchItem(int id) async {
    return await client.get("$_root/item/$id.json").then((response) {
      return ItemModel.fromJson(json.decode(response.body));
    });
  }
}
