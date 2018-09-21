import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import "repository.dart";

class NewsDbProvider implements Source, Cache {
  Database db;
  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
        CREATE TABLE Items
        (
        id INTEGER PRIMARY KEY,
        deleted INTEGER, 
        type TEXT,
        by TEXT,
        time INTEGER,
        text TEXT,
        dead INTEGER, 
        parent INTEGER,
        kids BLOB,
        url TEXT,
        score INTEGER,
        title TEXT,
        descendants INTEGER
        )
        """);
      },
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    return await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    ).then((List<Map<String, dynamic>> onValue) {
      return (onValue.length > 0) ? ItemModel.fromJson(onValue[0]) : null;
    });
  }

  Future<int> addItem(ItemModel item) => db.insert("Items", item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore);

  /// TODO: STORE AND FETCH TOP IDS
  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }

  @override
  void clear() {
    db.delete("Items");
  }
}
