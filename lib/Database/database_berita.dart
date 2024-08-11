import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseBerita {
  static final DatabaseBerita instance = DatabaseBerita._init();
  static Database? _database;

  DatabaseBerita._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('berita.db');
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
      CREATE TABLE berita(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        image TEXT NOT NULL,
        title TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertBerita(Berita berita) async {
    final db = await instance.database;
    await db.insert(
      'berita',
      berita.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted News: ${berita.title}');
  }

  Future<List<Berita>> getBerita() async {
    final db = await instance.database;
    final result = await db.query('berita');
    List<Berita> beritas = result.map((json) => Berita.fromMap(json)).toList();

    for (var berita in beritas) {
      print('Fetched News: ${berita.title}');
    }

    return beritas;
  }

  Future<void> updateBerita(Berita berita) async {
    final db = await instance.database;
    await db.update(
      'berita',
      berita.toMap(),
      where: 'id = ?',
      whereArgs: [berita.id],
    );
    print('Updated News: ${berita.title}');
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'berita.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Berita {
  final int? id;
  final String image;
  final String title;

  Berita({
    this.id,
    required this.image,
    required this.title,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
    };
  }

  static Berita fromMap(Map<String, Object?> map) {
    return Berita(
      id: map['id'] as int?,
      image: map['image'] as String,
      title: map['title'] as String,
    );
  }
}
