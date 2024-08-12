import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DatabasePengaduan {
  static final DatabasePengaduan instance = DatabasePengaduan._init();
  static Database? _database;

  DatabasePengaduan._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pengaduanMasyarakat.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pengaduanMasyarakat(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subjekAduan INTEGER NOT NULL,
        deskripsi TEXT NOT NULL,
        tanggalKejadian TEXT NOT NULL,
        lokasiLengkap TEXT NOT NULL,
        instansiTujuan TEXT NOT NULL,
        anonimitas TEXT NOT NULL,
        namaAnonimitas TEXT NOT NULL,
        noTelepon INTEGER NOT NULL,
        kkOrangTua TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertPengaduanMasyarakat(Pengaduan pengaduan) async {
    final db = await instance.database;
    await db.insert(
      'pengaduanMasyarakat',
      pengaduan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updatePengaduanMasyarakat(Pengaduan pengaduan) async {
  final db = await instance.database;
  await db.update(
    'pengaduanMasyarakat',
    pengaduan.toMap(),
    where: 'id = ?',
    whereArgs: [pengaduan.id],
  );
}

  Future<List<Pengaduan>> getPengaduanMasyarakat() async {
    final db = await instance.database;
    final result = await db.query('pengaduanMasyarakat');
    return result.map((json) => Pengaduan.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Pengaduan {
  final int? id;
  final String subjekAduan;
  final String deskripsi;
  final DateTime tanggalKejadian;
  final String lokasiLengkap;
  final String instansiTujuan;
  final String anonimitas;
  final String namaAnonimitas;
  final int noTelepon;
  final String kkOrangTua;

  Pengaduan({
    this.id,
    required this.subjekAduan,
    required this.deskripsi,
    required this.tanggalKejadian,
    required this.lokasiLengkap,
    required this.instansiTujuan,
    required this.anonimitas,
    required this.namaAnonimitas,
    required this.noTelepon,
    required this.kkOrangTua,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'subjekAduan': subjekAduan,
      'deskripsi': deskripsi,
      'tanggalKejadian': DateFormat('yyyy-MM-dd').format(tanggalKejadian),
      'lokasiLengkap': lokasiLengkap,
      'instansiTujuan': instansiTujuan,
      'anonimitas': anonimitas,
      'namaAnonimitas': namaAnonimitas,
      'noTelepon': noTelepon,
      'kkOrangTua': kkOrangTua,
    };
  }

  static Pengaduan fromMap(Map<String, Object?> map) {
    return Pengaduan(
      id: map['id'] as int?,
      subjekAduan: map['subjekAduan'] as String,
      deskripsi: map['deskripsi'] as String,
      tanggalKejadian: DateTime.parse(map['tanggalKejadian'] as String),
      lokasiLengkap: map['lokasiLengkap'] as String,
      instansiTujuan: map['instansiTujuan'] as String,
      anonimitas: map['anonimitas'] as String,
      namaAnonimitas: map['namaAnonimitas'] as String,
      noTelepon: map['noTelepon'] as int,
      kkOrangTua: map['kkOrangTua'] as String,
    );
  }

  @override
  String toString() {
    return 'Pengaduan{id: $id, subjekAduan: $subjekAduan, deskripsi: $deskripsi, tanggalKejadian: $tanggalKejadian, lokasiLengkap: $lokasiLengkap, instansiTujuan: $instansiTujuan, anonimitas: $anonimitas, namaAnonimitas: $namaAnonimitas, noTelepon: $noTelepon, kkOrangTua: $kkOrangTua}';
  }
}
