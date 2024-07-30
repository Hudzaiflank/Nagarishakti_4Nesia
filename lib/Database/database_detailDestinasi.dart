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
    print('Table detailDestinasi created');
  }

  Future<void> insertDetailDestinasi(DetailDestinasi detaildestinasi) async {
    final db = await instance.database;
    await db.insert(
      'detailDestinasi',
      detaildestinasi.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DetailDestinasi>> getDetailDestinasi(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'detailDestinasi',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      print('Fetched Destination with id $id: ${result.first['deskripsi']}');
    } else {
      print('No Destination found with id $id');
    }

    List<DetailDestinasi> detailDestinations = result.map((json) => DetailDestinasi.fromMap(json)).toList();
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

  Future<void> checkTableSchema() async {
    final db = await instance.database;
    final result = await db.rawQuery('PRAGMA table_info(detailDestinasi);');
    for (var row in result) {
      print(row);
    }
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'detailDestinasi.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
    print('Database closed');
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
