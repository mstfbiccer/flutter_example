import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'products.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE visited_products (id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
    );
  }

  Future<void> insertProduct(int id, String name) async {
    final db = await database;
    await db.insert(
      'visited_products',
      {'id': id, 'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getVisitedProducts() async {
    final db = await database;
    return db.query('visited_products', orderBy: 'id DESC', limit: 5);
  }

  Future<void> clearVisitedProducts() async {
    final db = await database;
    await db.delete('visited_products');
  }
}
