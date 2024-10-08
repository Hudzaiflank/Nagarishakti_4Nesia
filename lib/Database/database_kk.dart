import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseKk {
  static final DatabaseKk instance = DatabaseKk._init();
  static Database? _database;

  DatabaseKk._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('kkBaru.db');
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
      CREATE TABLE kkBaru(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        alasanPembuatan TEXT NOT NULL,
        namaLengkap TEXT NOT NULL,
        nomorNIK INTEGER NOT NULL,
        nomorKK INTEGER NOT NULL,
        nomorHandphone INTEGER NOT NULL,
        email TEXT NOT NULL,
        buktiKehilangan TEXT NOT NULL,
        buktiStatusHubungan TEXT NOT NULL,
        buktiKKLama TEXT NOT NULL,
        buktiKematianKepalaKeluarga TEXT NOT NULL,
        buktiSKPD TEXT NOT NULL,
        buktiSKPLN TEXT NOT NULL,
        suratPengantar TEXT NOT NULL,
        suratPernyataanKependudukan TEXT NOT NULL,
        buktiPerubahanPeristiwa TEXT NOT NULL,
        dokumenTambahan TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertKk(Kk kk) async {
    final db = await instance.database;
    await db.insert(
      'kkBaru',
      kk.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateKk(Kk kk) async {
  final db = await instance.database;
  await db.update(
    'kkBaru',
    kk.toMap(),
    where: 'id = ?',
    whereArgs: [kk.id],
  );
}

  Future<List<Kk>> getKk() async {
    final db = await instance.database;
    final result = await db.query('kkBaru');
    return result.map((json) => Kk.fromMap(json)).toList();
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'kkBaru.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Kk {
  final int? id;
  final String alasanPembuatan;
  final String namaLengkap;
  final int nomorNIK;
  final int nomorKK;
  final int nomorHandphone;
  final String email;
  final String buktiKehilangan;
  final String buktiStatusHubungan;
  final String buktiKKLama;
  final String buktiKematianKepalaKeluarga;
  final String buktiSKPD;
  final String buktiSKPLN;
  final String suratPengantar;
  final String suratPernyataanKependudukan;
  final String buktiPerubahanPeristiwa;
  final String dokumenTambahan;

  Kk({
    this.id,
    required this.alasanPembuatan,
    required this.namaLengkap,
    required this.nomorNIK,
    required this.nomorKK,
    required this.nomorHandphone,
    required this.email,
    required this.buktiKehilangan,
    required this.buktiStatusHubungan,
    required this.buktiKKLama,
    required this.buktiKematianKepalaKeluarga,
    required this.buktiSKPD,
    required this.buktiSKPLN,
    required this.suratPengantar,
    required this.suratPernyataanKependudukan,
    required this.buktiPerubahanPeristiwa,
    required this.dokumenTambahan,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'alasanPembuatan': alasanPembuatan,
      'namaLengkap': namaLengkap,
      'nomorNIK': nomorNIK,
      'nomorKK': nomorKK,
      'nomorHandphone': nomorHandphone,
      'email': email,
      'buktiKehilangan': buktiKehilangan,
      'buktiStatusHubungan': buktiStatusHubungan,
      'buktiKKLama': buktiKKLama,
      'buktiKematianKepalaKeluarga':buktiKematianKepalaKeluarga,
      'buktiSKPD': buktiSKPD,
      'buktiSKPLN': buktiSKPLN,
      'suratPengantar': suratPengantar,
      'suratPernyataanKependudukan': suratPernyataanKependudukan,
      'buktiPerubahanPeristiwa': buktiPerubahanPeristiwa,
      'dokumenTambahan': dokumenTambahan,
    };
  }

  static Kk fromMap(Map<String, Object?> map) {
    return Kk(
      id: map['id'] as int?,
      alasanPembuatan: map['alasanPembuatan'] as String,
      namaLengkap: map['namaLengkap'] as String,
      nomorNIK: map['nomorNIK'] as int,
      nomorKK: map['nomorKK'] as int,
      nomorHandphone: map['nomorHandphone'] as int,
      email: map['email'] as String,
      buktiKehilangan: map['buktiKehilangan'] as String,
      buktiStatusHubungan: map['buktiStatusHubungan'] as String,
      buktiKKLama: map['buktiKKLama'] as String,
      buktiKematianKepalaKeluarga: map['buktiKematianKepalaKeluarga'] as String,
      buktiSKPD: map['buktiSKPD'] as String,
      buktiSKPLN: map['buktiSKPLN'] as String,
      suratPengantar: map['suratPengantar'] as String,
      suratPernyataanKependudukan: map['suratPernyataanKependudukan'] as String,
      buktiPerubahanPeristiwa: map['buktiPerubahanPeristiwa'] as String,
      dokumenTambahan: map['dokumenTambahan'] as String,
    );
  }

  @override
  String toString() {
    return 'Kk{id: $id, alasanPembuatan: $alasanPembuatan, namaLengkap: $namaLengkap, nomorNIK: $nomorNIK, nomorKK: $nomorKK, nomorHandphone: $nomorHandphone, email: $email, buktiKehilangan: $buktiKehilangan, buktiStatusHubungan: $buktiStatusHubungan, buktiKKLama: $buktiKKLama, buktiKematianKepalaKeluarga: $buktiKematianKepalaKeluarga, buktiSKPD: $buktiSKPD, buktiSKPLN: $buktiSKPLN, suratPengantar: $suratPengantar, suratPernyataanKependudukan: $suratPernyataanKependudukan, buktiPerubahanPeristiwa: $buktiPerubahanPeristiwa, dokumenTambahan: $dokumenTambahan}';
  }
}
