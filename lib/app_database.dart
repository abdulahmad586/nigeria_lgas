import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  factory AppDatabase() => _instance;
  AppDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, 'nga_wards.db3');

    bool exists = await File(dbPath).exists();

    if (!exists) {
      print('Copying prebuilt database from assets...');
      ByteData data = await rootBundle.load('assets/database.db3');
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes, flush: true);
    } else {
      print('Database already exists at $dbPath');
    }

    return await openDatabase(dbPath);
  }

  /// Get all rows from a table
  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    final db = await database;
    return await db.query(tableName);
  }

  /// Get a specific row by ID
  Future<Map<String, dynamic>?> queryById(String tableName, int id) async {
    final db = await database;
    final results = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

  /// Run any raw SELECT query
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<Object?>? args]) async {
    final db = await database;
    return await db.rawQuery(sql, args);
  }
}
