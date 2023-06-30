import 'dart:io';

import 'package:hacker_news/src/models/item_model.dart';
import '../resources/repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider implements Source, Cache {
  Database? newsDb;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'item9.db');

    newsDb = await openDatabase(
      path,
      version: 2,
      onCreate: (Database database, int version) {
        database.execute("""
        CREATE TABLE Items 
        (
          by TEXT,
          descendants INTEGER,
          id INTEGER PRIMARY KEY,
          kids BLOB,
          score INTEGER,
          text TEXT,
          time INTEGER,
          title TEXT,
          type TEXT,
          url TEXT
        )
        """);
      },
    );
  }

  /// Todo - store and fetch top ids
  @override
  Future<List<int>?> fetchTopIds() async {
    return null;
  }

  @override
  Future<ItemModel?> fetchItem({required int id}) async {
    final dataMap = await newsDb!.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    if (dataMap.isNotEmpty) {
      return ItemModel.fromDb(dataMap.first);
    }
    return null;
  }

  @override
  Future<int> addItem({required ItemModel itemModel}) {
    /// Fixing db conflict method 1
    return newsDb!.insert(
      "Items",
      itemModel.toMapForDatabase(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    // return newsD!.insert(
    //   "Items",
    //   itemModel.toMapForDatabase(),
    // );
  }

  @override
  Future<int> clearCache() {
    return newsDb!.delete("Items");
  }
}

final newsDbProvider = NewsDbProvider();
