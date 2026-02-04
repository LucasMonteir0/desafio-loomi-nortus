import "package:sqflite/sqflite.dart";

abstract class LocalDatabaseService {
  Future<Database> get database;
}
