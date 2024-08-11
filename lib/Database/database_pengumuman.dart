import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabasePengumuman {
  static final DatabasePengumuman instance = DatabasePengumuman._init();
  static Database? _database;

  DatabasePengumuman._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pengumuman.db');
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
      CREATE TABLE pengumuman(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        title TEXT NOT NULL,
        subtitle TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertPengumuman(Pengumuman pengumuman) async {
    final db = await instance.database;
    await db.insert(
      'pengumuman',
      pengumuman.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted Announcement: ${pengumuman.title}');
  }

  Future<List<Pengumuman>> getPengumuman() async {
    final db = await instance.database;
    final result = await db.query('pengumuman');
    List<Pengumuman> pengumumans = result.map((json) => Pengumuman.fromMap(json)).toList();

    for (var pengumuman in pengumumans) {
      print('Fetched Announcement: ${pengumuman.title}');
    }

    return pengumumans;
  }

  Future<void> updatePengumuman(Pengumuman pengumuman) async {
    final db = await instance.database;
    await db.update(
      'pengumuman',
      pengumuman.toMap(),
      where: 'id = ?',
      whereArgs: [pengumuman.id],
    );
    print('Updated Announcement: ${pengumuman.title}');
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pengumuman.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Pengumuman {
  final int? id;
  final String date;
  final String title;
  final String subtitle;

  Pengumuman({
    this.id,
    required this.date,
    required this.title,
    required this.subtitle,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'subtitle': subtitle,
    };
  }

  static Pengumuman fromMap(Map<String, Object?> map) {
    return Pengumuman(
      id: map['id'] as int?,
      date: map['date'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
    );
  }
}
