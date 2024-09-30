import 'dart:async';

import 'package:house_rent/data/datasource/constants/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  Database? _db;

  final Completer<Database> _dbCompleter = Completer();

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    _dbCompleter.complete(_db);
    return _db!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), Constants.tenant);
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE ${Constants.tenantDb} (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,tenantName TEXT, advance INTEGER,timestamp INTEGER)',
        );
        await db.execute(
          'CREATE TABLE ${Constants.readingDb} (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, tenantName TEXT,tenantId INTEGER, timestamp INTEGER, unit INTEGER, total INTEGER, reading INTEGER)',
        );
      },
      version: 1,
    );
  }
}
