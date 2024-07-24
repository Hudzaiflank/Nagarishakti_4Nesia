import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseIntegration {
  static final DatabaseIntegration instance = DatabaseIntegration._init();
  static Database? _database;

  DatabaseIntegration._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('integrations.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE integrations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        link_API TEXT NOT NULL,
        nama_daerah TEXT NOT NULL,
      )
    ''');
  }

  Future<void> insertIntegration(Integration integration) async {
    final db = await instance.database;
    await db.insert(
      'integrations',
      integration.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Integration>> getIntegrations() async {
    final db = await instance.database;
    final result = await db.query('integrations');
    return result.map((json) => Integration.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Integration {
  final int? id;
  final String linkAPI;
  final String namaDaerah;

  Integration({
    this.id,
    required this.linkAPI,
    required this.namaDaerah,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'link_API': linkAPI,
      'nama_daerah': namaDaerah,
    };
  }

  static Integration fromMap(Map<String, Object?> map) {
    return Integration(
      id: map['id'] as int?,
      linkAPI: map['link_API'] as String,
      namaDaerah: map['nama_daerah'] as String,
    );
  }

  @override
  String toString() {
    return 'Integration{id: $id, linkAPI: $linkAPI, namaDaerah: $namaDaerah}';
  }
}
