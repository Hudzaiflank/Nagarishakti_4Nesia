import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabasePengajuanKeluhan {
  static final DatabasePengajuanKeluhan instance = DatabasePengajuanKeluhan._init();
  static Database? _database;

  DatabasePengajuanKeluhan._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pengajuanKeluhan.db');
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
      CREATE TABLE pengajuanKeluhan(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        jumlahKeluhan INTEGER NOT NULL,
        warnaBackground INTEGER NOT NULL
      )
    ''');
  }

  Future<void> insertPengajuanKeluhan(PengajuanKeluhan pengajuanKeluhan) async {
    final db = await instance.database;
    await db.insert(
      'pengajuanKeluhan',
      pengajuanKeluhan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted Complain: ${pengajuanKeluhan.title}');
  }

  Future<List<PengajuanKeluhan>> getPengajuanKeluhan() async {
    final db = await instance.database;
    final result = await db.query('pengajuanKeluhan');
    List<PengajuanKeluhan> pengajuanKeluhans = result.map((json) => PengajuanKeluhan.fromMap(json)).toList();

    for (var pengajuanKeluhan in pengajuanKeluhans) {
      print('Fetched Complain: ${pengajuanKeluhan.title}');
    }

    return pengajuanKeluhans;
  }

  Future<void> updatePengajuanKeluhan(PengajuanKeluhan pengajuanKeluhan) async {
    final db = await instance.database;
    await db.update(
      'pengajuanKeluhan',
      pengajuanKeluhan.toMap(),
      where: 'id = ?',
      whereArgs: [pengajuanKeluhan.id],
    );
    print('Update Complain: ${pengajuanKeluhan.title}');
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pengajuanKeluhan.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class PengajuanKeluhan {
  final int? id;
  final String title;
  final int jumlahKeluhan;
  final int warnaBackground;

  PengajuanKeluhan({
    this.id,
    required this.title,
    required this.jumlahKeluhan,
    required this.warnaBackground,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'jumlahKeluhan': jumlahKeluhan,
      'warnaBackground': warnaBackground,
    };
  }

  static PengajuanKeluhan fromMap(Map<String, Object?> map) {
    return PengajuanKeluhan(
      id: map['id'] as int?,
      title: map['title'] as String,
      jumlahKeluhan: map['jumlahKeluhan'] as int,
      warnaBackground: map['warnaBackground'] as int,
    );
  }
}
