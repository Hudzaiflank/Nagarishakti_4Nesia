import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseDokumen {
  static final DatabaseDokumen instance = DatabaseDokumen._init();
  static Database? _database;

  DatabaseDokumen._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dokumen.db');
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
      CREATE TABLE dokumen(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        fileUrl TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertDokumen(Dokumen dokumen) async {
    final db = await instance.database;
    final id = await db.insert(
      'dokumen',
      dokumen.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted Dokumen: ${dokumen.title} with id: $id');
    return id;
  }

  Future<List<Dokumen>> getDokumen() async {
    final db = await instance.database;
    final result = await db.query('dokumen');
    List<Dokumen> dokumens = result.map((json) => Dokumen.fromMap(json)).toList();

    for (var dokumen in dokumens) {
      print('Fetched Dokumen: ${dokumen.title}');
    }
    return dokumens;
  }

  Future<int> updateDokumen(Dokumen dokumen) async {
    final db = await instance.database;
    final rowsUpdated = await db.update(
      'dokumen',
      dokumen.toMap(),
      where: 'id = ?',
      whereArgs: [dokumen.id],
    );
    print('Updated Dokumen: ${dokumen.title} with rows affected: $rowsUpdated');
    return rowsUpdated;
  }

  Future<int> deleteDokumen(int id) async {
    final db = await instance.database;
    final rowsDeleted = await db.delete(
      'dokumen',
      where: 'id = ?',
      whereArgs: [id],
    );
    print('Deleted Dokumen with id: $id');
    return rowsDeleted;
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'dokumen.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    await db.close(); 
  }
}

class Dokumen {
  final int? id;
  final String title;
  final String date;
  final String time;
  final String fileUrl;

  Dokumen({
    this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.fileUrl,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'time': time,
      'fileUrl': fileUrl,
    };
  }

  static Dokumen fromMap(Map<String, Object?> map) {
    return Dokumen(
      id: map['id'] as int?,
      title: map['title'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      fileUrl: map['fileUrl'] as String,
    );
  }
}
