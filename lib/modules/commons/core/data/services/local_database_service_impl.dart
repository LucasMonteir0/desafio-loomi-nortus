import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

import "../../domain/services/local_databasse_service.dart";

class LocalDatabaseServiceImpl implements LocalDatabaseService {
  static Database? _database;

  @override
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "news_app.db");

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE news_items(
        id INTEGER PRIMARY KEY,
        title TEXT,
        image TEXT,
        categories TEXT,
        publishedAt TEXT,
        summary TEXT,
        authors TEXT
      )
    """);

    await db.execute("""
      CREATE TABLE news_details(
        id INTEGER PRIMARY KEY,
        title TEXT,
        image TEXT,
        categories TEXT,
        publishedAt TEXT,
        newsResume TEXT,
        estimatedReadingTime TEXT,
        authors TEXT,
        description TEXT,
        relatedNews TEXT,
        readAlso TEXT
      )
    """);
  }
}
