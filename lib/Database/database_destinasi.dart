import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseDestinasi {
  static final DatabaseDestinasi instance = DatabaseDestinasi._init();
  static Database? _database;

  DatabaseDestinasi._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('destinasi.db');
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
      CREATE TABLE destinasi(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        location TEXT NOT NULL,
        imagePath TEXT NOT NULL,
        backgroundColor INTEGER NOT NULL,
        savedBy TEXT NOT NULL,
        bookmark BOOLEAN NOT NULL
      )
    ''');
  }

  Future<void> insertDestinasi(Destinasi destinasi) async {
    final db = await instance.database;
    await db.insert(
      'destinasi',
      destinasi.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted Destination: ${destinasi.title} with color: ${destinasi.backgroundColor}');
  }

  Future<List<Destinasi>> getDestinasi() async {
    final db = await instance.database;
    final result = await db.query('destinasi');
    List<Destinasi> destinations = result.map((json) => Destinasi.fromMap(json)).toList();

    for (var destinasi in destinations) {
      print('Fetched Destination: ${destinasi.title} with color: ${destinasi.backgroundColor}');
    }

    return destinations;
  }

  Future<void> updateDestinasi(Destinasi destinasi) async {
    final db = await instance.database;
    await db.update(
      'destinasi',
      destinasi.toMap(),
      where: 'id = ?',
      whereArgs: [destinasi.id],
    );
    print('Updated Destination: ${destinasi.title} with color: ${destinasi.backgroundColor}');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Destinasi {
  final int? id;
  final String title;
  final String location;
  final String imagePath;
  final int backgroundColor; 
  final String savedBy;
  bool bookmark;

  Destinasi({
    this.id,
    required this.title,
    required this.location,
    required this.imagePath,
    required this.backgroundColor, 
    required this.savedBy,
    required this.bookmark,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'imagePath': imagePath,
      'backgroundColor': backgroundColor, 
      'savedBy': savedBy,
      'bookmark': bookmark ? 1 : 0,
    };
  }

  static Destinasi fromMap(Map<String, Object?> map) {
    return Destinasi(
      id: map['id'] as int?,
      title: map['title'] as String,
      location: map['location'] as String,
      imagePath: map['imagePath'] as String,
      backgroundColor: map['backgroundColor'] as int, 
      savedBy: map['savedBy'] as String,
      bookmark: (map['bookmark'] as int) == 1,
    );
  }
}
