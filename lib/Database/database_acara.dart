import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAcara {
  static final DatabaseAcara instance = DatabaseAcara._init();
  static Database? _database;

  DatabaseAcara._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('acara.db');
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
      CREATE TABLE acara(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        image TEXT NOT NULL,
        title TEXT NOT NULL,
        date TEXT NOT NULL,
        location TEXT NOT NULL,
        description TEXT NOT NULL,
        notification BOOLEAN NOT NULL
      )
    ''');
  }

  Future<void> insertAcara(Acara acara) async {
    final db = await instance.database;
    await db.insert(
      'acara',
      acara.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted Acara: ${acara.title}');
  }

  Future<List<Acara>> getAcara() async {
    final db = await instance.database;
    final result = await db.query('acara');
    List<Acara> events = result.map((json) => Acara.fromMap(json)).toList();
    for (var acara in events) {
      print('Fetched Acara: ${acara.title}');
    }
    return events;
  }

  Future<void> updateAcara(Acara acara) async {
    final db = await instance.database;
    await db.update(
      'acara',
      acara.toMap(),
      where: 'id = ?',
      whereArgs: [acara.id],
    );
    print('Updated Acara: ${acara.title}');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Acara {
  final int? id;
  final String title;
  final String location;
  final String image;
  final String date;
  final String description;
  bool notification;

  Acara({
    this.id,
    required this.title,
    required this.location,
    required this.image,
    required this.date,
    required this.description,
    required this.notification,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'image': image,
      'date': date,
      'description': description,
      'notification': notification ? 1 : 0, 
    };
  }

  static Acara fromMap(Map<String, Object?> map) {
    return Acara(
      id: map['id'] as int?,
      title: map['title'] as String,
      location: map['location'] as String,
      image: map['image'] as String,
      date: map['date'] as String,
      description: map['description'] as String,
      notification: (map['notification'] as int) == 1
    );
  }
}
