import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseDetailBerita {
  static final DatabaseDetailBerita instance = DatabaseDetailBerita._init();
  static Database? _database;

  DatabaseDetailBerita._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('detailBerita.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    print('Database path: $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE detailBerita(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subtitle TEXT NOT NULL,
        firstImage TEXT NOT NULL,
        firstDescription TEXT NOT NULL,
        secondImage TEXT NOT NULL,
        secondDescription TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertDetailBerita(DetailBerita detailberita) async {
    final db = await instance.database;
    await db.insert(
      'detailBerita',
      detailberita.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted News: ${detailberita.id}');
  }

  Future<List<DetailBerita>> getDetailBerita(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'detailBerita',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    List<DetailBerita> detailberitas = result.map((json) => DetailBerita.fromMap(json)).toList();
    for (var detailberita in detailberitas) {
      print('Fetched News: ${detailberita.id}');
    }
    return detailberitas;
  }

  Future<void> updateDetailBerita(DetailBerita detailberita) async {
    final db = await instance.database;
    await db.update(
      'detailBerita',
      detailberita.toMap(),
      where: 'id = ?',
      whereArgs: [detailberita.id],
    );
    print('Updated News: ${detailberita.id}');
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'detailBerita.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class DetailBerita {
  final int? id;
  final String subtitle;
  final String firstImage;
  final String firstDescription;
  final String secondImage;
  final String secondDescription;

  DetailBerita({
    this.id,
    required this.subtitle,
    required this.firstImage,
    required this.firstDescription,
    required this.secondImage,
    required this.secondDescription,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'subtitle': subtitle,
      'firstImage': firstImage,
      'firstDescription': firstDescription,
      'secondImage': secondImage,
      'secondDescription': secondDescription,
    };
  }

  static DetailBerita fromMap(Map<String, Object?> map) {
    return DetailBerita(
      id: map['id'] as int?,
      subtitle: map['subtitle'] as String,
      firstImage: map['firstImage'] as String,
      firstDescription: map['firstDescription'] as String,
      secondImage: map['secondImage'] as String,
      secondDescription: map['secondDescription'] as String,
    );
  }
}
