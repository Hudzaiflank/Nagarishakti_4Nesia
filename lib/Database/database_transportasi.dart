import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseTransportasi {
  static final DatabaseTransportasi instance = DatabaseTransportasi._init();
  static Database? _database;

  DatabaseTransportasi._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('transportasi.db');
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
      CREATE TABLE transportasi(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        gambar TEXT NOT NULL,
        deskripsi TEXT NOT NULL,
        rute TEXT NOT NULL,
        jamOperasional TEXT NOT NULL,
        tarif TEXT NOT NULL,
        fasilitas TEXT NOT NULL,
        tambahan TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertTransportasi(Transportasi transportasi) async {
    final db = await instance.database;
    await db.insert(
      'transportasi',
      transportasi.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted Transportation: ${transportasi.nama}');
  }

  Future<List<Transportasi>> getTransportasi(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'transportasi',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      print('Fetched Destination with id $id: ${result.first['nama']}');
    } else {
      print('No Destination found with id $id');
    }

    List<Transportasi> transportations = result.map((json) => Transportasi.fromMap(json)).toList();
    return transportations;
  }

  Future<void> updateTransportasi(Transportasi transportasi) async {
    final db = await instance.database;
    await db.update(
      'transportasi',
      transportasi.toMap(),
      where: 'id = ?',
      whereArgs: [transportasi.id],
    );
    print('Updated Transportation: ${transportasi.nama}');
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'transportasi.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Transportasi {
  final int? id;
  final String nama;
  final String gambar;
  final String deskripsi;
  final String rute;
  final String jamOperasional;
  final String tarif;
  final String fasilitas;
  final String tambahan;

  Transportasi({
    this.id,
    required this.nama,
    required this.gambar,
    required this.deskripsi,
    required this.rute,
    required this.jamOperasional,
    required this.tarif,
    required this.fasilitas,
    required this.tambahan,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nama': nama,
      'gambar': gambar,
      'deskripsi': deskripsi,
      'rute': rute,
      'jamOperasional': jamOperasional,
      'tarif': tarif,
      'fasilitas': fasilitas,
      'tambahan': tambahan,
    };
  }

  static Transportasi fromMap(Map<String, Object?> map) {
    return Transportasi(
      id: map['id'] as int?,
      nama: map['nama'] as String,
      gambar: map['gambar'] as String,
      deskripsi: map['deskripsi'] as String,
      rute: map['rute'] as String,
      jamOperasional: map['jamOperasional'] as String,
      tarif: map['tarif'] as String,
      fasilitas: map['fasilitas'] as String,
      tambahan: map['tambahan'] as String,
    );
  }
}
