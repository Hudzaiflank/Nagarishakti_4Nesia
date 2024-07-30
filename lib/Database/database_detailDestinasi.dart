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
        deskripsi TEXT NOT NULL,
        gambar TEXT NOT NULL,
        fasilitas TEXT NOT NULL,
        hargaTiket TEXT NOT NULL
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
    print('Inserted Destination: ${detaildestinasi.deskripsi}');
  }

  Future<List<DetailDestinasi>> getDetailDestinasi(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'detailDestinasi',
      where: 'id = ?',
      whereArgs: [id],
    );
    List<DetailDestinasi> detailDestinations = result.map((json) => DetailDestinasi.fromMap(json)).toList();

    detailDestinations.forEach((detaildestinasi) {
      print('Fetched Destination: ${detaildestinasi.deskripsi}');
    });

    return detailDestinations;
  }

  Future<void> updateDetailDestinasi(DetailDestinasi detaildestinasi) async {
    final db = await instance.database;
    await db.update(
      'detailDestinasi',
      detaildestinasi.toMap(),
      where: 'id = ?',
      whereArgs: [detaildestinasi.id],
    );
    print('Updated Destination: ${detaildestinasi.deskripsi}');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class DetailDestinasi {
  final int? id;
  final String deskripsi;
  final String gambar;
  final String fasilitas;
  final String hargaTiket;

  DetailDestinasi({
    this.id,
    required this.deskripsi,
    required this.gambar,
    required this.fasilitas,
    required this.hargaTiket,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'deskripsi': deskripsi,
      'gambar': gambar,
      'fasilitas': fasilitas,
      'hargaTiket': hargaTiket,
    };
  }

  static DetailDestinasi fromMap(Map<String, Object?> map) {
    return DetailDestinasi(
      id: map['id'] as int?,
      deskripsi: map['deskripsi'] as String,
      gambar: map['gambar'] as String,
      fasilitas: map['fasilitas'] as String,
      hargaTiket: map['hargaTiket'] as String,
    );
  }
}
