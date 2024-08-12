import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DatabaseKtp {
  static final DatabaseKtp instance = DatabaseKtp._init();
  static Database? _database;

  DatabaseKtp._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('ktpBaru.db');
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
      CREATE TABLE ktpBaru(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        alasanPembuatan TEXT NOT NULL,
        nik INTEGER NOT NULL,
        namaLengkap TEXT NOT NULL,
        tempatLahir TEXT NOT NULL,
        tanggalLahir TEXT NOT NULL,
        jenisKelamin TEXT NOT NULL,
        alamatLengkap TEXT NOT NULL,
        agama TEXT NOT NULL,
        jenisPekerjaan TEXT NOT NULL,
        statusPerkawinan TEXT NOT NULL,
        kartuKeluarga TEXT NOT NULL,
        suratPengantar TEXT NOT NULL,
        buktiKehilangan TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertKtp(Ktp ktp) async {
    final db = await instance.database;
    await db.insert(
      'ktpBaru',
      ktp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateKtp(Ktp ktp) async {
  final db = await instance.database;
  await db.update(
    'ktpBaru',
    ktp.toMap(),
    where: 'id = ?',
    whereArgs: [ktp.id],
  );
}

  Future<List<Ktp>> getKtp() async {
    final db = await instance.database;
    final result = await db.query('ktpBaru');
    return result.map((json) => Ktp.fromMap(json)).toList();
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ktpBaru.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Ktp {
  final int? id;
  final String alasanPembuatan;
  final int nik;
  final String namaLengkap;
  final String tempatLahir;
  final DateTime tanggalLahir;
  final String jenisKelamin;
  final String alamatLengkap;
  final String agama;
  final String jenisPekerjaan;
  final String statusPerkawinan;
  final String kartuKeluarga;
  final String suratPengantar;
  final String buktiKehilangan;

  Ktp({
    this.id,
    required this.alasanPembuatan,
    required this.nik,
    required this.namaLengkap,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.alamatLengkap,
    required this.agama,
    required this.jenisPekerjaan,
    required this.statusPerkawinan,
    required this.kartuKeluarga,
    required this.suratPengantar,
    required this.buktiKehilangan,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'alasanPembuatan': alasanPembuatan,
      'nik': nik,
      'namaLengkap': namaLengkap,
      'tempatLahir': tempatLahir,
      'tanggalLahir': DateFormat('yyyy-MM-dd').format(tanggalLahir),
      'jenisKelamin': jenisKelamin,
      'alamatLengkap': alamatLengkap,
      'agama': agama,
      'jenisPekerjaan': jenisPekerjaan,
      'statusPerkawinan': statusPerkawinan,
      'kartuKeluarga': kartuKeluarga,
      'suratPengantar': suratPengantar,
      'buktiKehilangan': buktiKehilangan,
    };
  }

  static Ktp fromMap(Map<String, Object?> map) {
    return Ktp(
      id: map['id'] as int?,
      alasanPembuatan: map['alasanPembuatan'] as String,
      nik: map['nik'] as int,
      namaLengkap: map['namaLengkap'] as String,
      tempatLahir: map['tempatLahir'] as String,
      tanggalLahir: DateTime.parse(map['tanggalLahir'] as String),
      jenisKelamin: map['jenisKelamin'] as String,
      alamatLengkap: map['alamatLengkap'] as String,
      agama: map['agama'] as String,
      jenisPekerjaan: map['jenisPekerjaan'] as String,
      statusPerkawinan: map['statusPerkawinan'] as String,
      kartuKeluarga: map['kartuKeluarga'] as String,
      suratPengantar: map['suratPengantar'] as String,
      buktiKehilangan: map['buktiKehilangan'] as String,
    );
  }

  @override
  String toString() {
    return 'Ktp{id: $id, alasanPembuatan: $alasanPembuatan, nik: $nik, namaLengkap: $namaLengkap, tempatLahir: $tempatLahir, tanggalLahir: $tanggalLahir, jenisKelamin: $jenisKelamin, alamatLengkap: $alamatLengkap, agama: $agama, jenisPekerjaan: $jenisPekerjaan, statusPerkawinan: $statusPerkawinan, kartuKeluarga: $kartuKeluarga, suratPengantar: $suratPengantar, buktiKehilangan: $buktiKehilangan}';
  }
}
