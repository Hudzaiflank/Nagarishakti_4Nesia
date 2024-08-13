import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabasePengajuanDokumen {
  static final DatabasePengajuanDokumen instance = DatabasePengajuanDokumen._init();
  static Database? _database;

  DatabasePengajuanDokumen._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pengajuanDokumen.db');
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
      CREATE TABLE pengajuanDokumen(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        tanggalDokumen TEXT NOT NULL,
        statusDokumen TEXT NOT NULL,
        jenisDokumen TEXT NOT NULL,
        jumlahDokumen INTEGER NOT NULL,
        warnaBackground INTEGER NOT NULL
      )
    ''');
  }

  Future<void> insertPengajuanDokumen(PengajuanDokumen pengajuanDokumen) async {
    final db = await instance.database;
    await db.insert(
      'pengajuanDokumen',
      pengajuanDokumen.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted Document: ${pengajuanDokumen.title}');
  }

  Future<List<PengajuanDokumen>> getPengajuanDokumen() async {
    final db = await instance.database;
    final result = await db.query('pengajuanDokumen');
    List<PengajuanDokumen> pengajuanDokumens = result.map((json) => PengajuanDokumen.fromMap(json)).toList();

    for (var pengajuanDokumen in pengajuanDokumens) {
      print('Fetched Document: ${pengajuanDokumen.title}');
    }

    return pengajuanDokumens;
  }

  Future<void> updatePengajuanDokumen(PengajuanDokumen pengajuanDokumen) async {
    final db = await instance.database;
    await db.update(
      'pengajuanDokumen',
      pengajuanDokumen.toMap(),
      where: 'id = ?',
      whereArgs: [pengajuanDokumen.id],
    );
    print('Update Document: ${pengajuanDokumen.title}');
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pengajuanDokumen.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class PengajuanDokumen {
  final int? id;
  final String title;
  final String tanggalDokumen;
  final String statusDokumen;
  final String jenisDokumen;
  final int jumlahDokumen;
  final int warnaBackground;

  PengajuanDokumen({
    this.id,
    required this.title,
    required this.tanggalDokumen,
    required this.statusDokumen,
    required this.jenisDokumen,
    required this.jumlahDokumen,
    required this.warnaBackground,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'tanggalDokumen': tanggalDokumen,
      'statusDokumen': statusDokumen,
      'jenisDokumen': jenisDokumen,
      'jumlahDokumen': jumlahDokumen,
      'warnaBackground': warnaBackground,
    };
  }

  static PengajuanDokumen fromMap(Map<String, Object?> map) {
    return PengajuanDokumen(
      id: map['id'] as int?,
      title: map['title'] as String,
      tanggalDokumen: map['tanggalDokumen'] as String,
      statusDokumen: map['statusDokumen'] as String,
      jenisDokumen: map['jenisDokumen'] as String,
      jumlahDokumen: map['jumlahDokumen'] as int,
      warnaBackground: map['warnaBackground'] as int,
    );
  }
}
