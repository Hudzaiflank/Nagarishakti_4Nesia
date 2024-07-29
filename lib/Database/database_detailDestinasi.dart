import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseDetailDestinasi {
  static final DatabaseDetailDestinasi instance = DatabaseDetailDestinasi._init();
  static Database? _database;

  DatabaseDetailDestinasi._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('detailDestinasi.db');
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
      CREATE TABLE detailDestinasi(
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

  Future<void> insertDetailDestinasi(DetailDestinasi detaildestinasi) async {
    final db = await instance.database;
    await db.insert(
      'detailDestinasi',
      detaildestinasi.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted Destination: ${detaildestinasi.title} with color: ${detaildestinasi.backgroundColor}');
  }

  Future<List<DetailDestinasi>> getDestinasi() async {
    final db = await instance.database;
    final result = await db.query('destinasi');
    List<DetailDestinasi> destinations = result.map((json) => DetailDestinasi.fromMap(json)).toList();

    destinations.forEach((detaildestinasi) {
      print('Fetched Destination: ${detaildestinasi.title} with color: ${detaildestinasi.backgroundColor}');
    });

    return destinations;
  }

  Future<void> updateDetailDestinasi(DetailDestinasi detaildestinasi) async {
    final db = await instance.database;
    await db.update(
      'destinasi',
      detaildestinasi.toMap(),
      where: 'id = ?',
      whereArgs: [detaildestinasi.id],
    );
    print('Updated Destination: ${detaildestinasi.title} with color: ${detaildestinasi.backgroundColor}');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class DetailDestinasi {
  final int? id;
  final String title;
  final String location;
  final String imagePath;
  final int backgroundColor; // Changed to int
  final String savedBy;
  bool bookmark;

  DetailDestinasi({
    this.id,
    required this.title,
    required this.location,
    required this.imagePath,
    required this.backgroundColor, // Changed to int
    required this.savedBy,
    required this.bookmark,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'imagePath': imagePath,
      'backgroundColor': backgroundColor, // Save as integer
      'savedBy': savedBy,
      'bookmark': bookmark ? 1 : 0,
    };
  }

  static DetailDestinasi fromMap(Map<String, Object?> map) {
    return DetailDestinasi(
      id: map['id'] as int?,
      title: map['title'] as String,
      location: map['location'] as String,
      imagePath: map['imagePath'] as String,
      backgroundColor: map['backgroundColor'] as int, // Read as integer
      savedBy: map['savedBy'] as String,
      bookmark: (map['bookmark'] as int) == 1,
    );
  }
}
