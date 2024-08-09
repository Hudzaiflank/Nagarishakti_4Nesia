import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAgenda {
  static final DatabaseAgenda instance = DatabaseAgenda._init();
  static Database? _database;

  DatabaseAgenda._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('agenda.db');
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
      CREATE TABLE agenda(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT NOT NULL,
        waktu TEXT NOT NULL,
        lokasi TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertAgenda(Agenda agenda) async {
    final db = await instance.database;
    await db.insert(
      'agenda',
      agenda.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted Agenda: ${agenda.judul}');
  }

  Future<List<Agenda>> getAgenda() async {
    final db = await instance.database;
    final result = await db.query('agenda');
    List<Agenda> agendas = result.map((json) => Agenda.fromMap(json)).toList();

    for (var agenda in agendas) {
      print('Fetched Agenda: ${agenda.judul}');
    }
    return agendas;
  }

  Future<void> updateAgenda(Agenda agenda) async {
    final db = await instance.database;
    await db.update(
      'agenda',
      agenda.toMap(),
      where: 'id = ?',
      whereArgs: [agenda.id],
    );
    print('Updated Agenda: ${agenda.judul}');
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'agenda.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Agenda {
  final int? id;
  final String judul;
  final String waktu;
  final String lokasi;

  Agenda({
    this.id,
    required this.judul,
    required this.waktu,
    required this.lokasi,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'judul': judul,
      'waktu': waktu,
      'lokasi': lokasi,
    };
  }

  static Agenda fromMap(Map<String, Object?> map) {
    return Agenda(
      id: map['id'] as int?,
      judul: map['judul'] as String,
      waktu: map['waktu'] as String,
      lokasi: map['lokasi'] as String,
    );
  }
}