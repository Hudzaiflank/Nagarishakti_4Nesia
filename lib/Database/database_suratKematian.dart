import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DatabaseSuratKematian {
  static final DatabaseSuratKematian instance = DatabaseSuratKematian._init();
  static Database? _database;

  DatabaseSuratKematian._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('suratKematian.db');
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
      CREATE TABLE suratKematian(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nikPemohon INTEGER NOT NULL,
        namaPemohon TEXT NOT NULL,
        umurPemohon INTEGER NOT NULL,
        hubunganPemohon TEXT NOT NULL,
        nikAlmarhum INTEGER NOT NULL,
        namaAlmarhum TEXT NOT NULL,
        jenisKelaminAlmarhum TEXT NOT NULL,
        hariKematianAlmarhum TEXT NOT NULL,
        tanggalKematianAlmarhum TEXT NOT NULL,
        waktuKematianAlmarhum TEXT NOT NULL,
        tempatKematianAlmarhum TEXT NOT NULL,
        penyebabKematianAlmarhum TEXT NOT NULL,
        buktiKematianAlmarhum TEXT NOT NULL,
        suratKematianAlmarhum TEXT NOT NULL,
        ktpPemohon TEXT NOT NULL,
        ktpAlmarhum TEXT NOT NULL,
        kkAlmarhum TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertSuratKematian(Kematian kematian) async {
    final db = await instance.database;
    await db.insert(
      'suratKematian',
      kematian.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateSuratKematian(Kematian kematian) async {
  final db = await instance.database;
  await db.update(
    'suratKematian',
    kematian.toMap(),
    where: 'id = ?',
    whereArgs: [kematian.id],
  );
}

  Future<List<Kematian>> getSuratKematian() async {
    final db = await instance.database;
    final result = await db.query('suratKematian');
    return result.map((json) => Kematian.fromMap(json)).toList();
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'suratKematian.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Kematian {
  final int? id;
  final int nikPemohon;
  final String namaPemohon;
  final int umurPemohon;
  final String hubunganPemohon;
  final int nikAlmarhum;
  final String namaAlmarhum;
  final String jenisKelaminAlmarhum;
  final String hariKematianAlmarhum;
  final DateTime tanggalKematianAlmarhum;
  final String waktuKematianAlmarhum;
  final String tempatKematianAlmarhum;
  final String penyebabKematianAlmarhum;
  final String buktiKematianAlmarhum;
  final String suratKematianAlmarhum;
  final String ktpPemohon;
  final String ktpAlmarhum;
  final String kkAlmarhum;

  Kematian({
    this.id,
    required this.nikPemohon,
    required this.namaPemohon,
    required this.umurPemohon,
    required this.hubunganPemohon,
    required this.nikAlmarhum,
    required this.namaAlmarhum,
    required this.jenisKelaminAlmarhum,
    required this.hariKematianAlmarhum,
    required this.tanggalKematianAlmarhum,
    required this.waktuKematianAlmarhum,
    required this.tempatKematianAlmarhum,
    required this.penyebabKematianAlmarhum,
    required this.buktiKematianAlmarhum,
    required this.suratKematianAlmarhum,
    required this.ktpPemohon,
    required this.ktpAlmarhum,
    required this.kkAlmarhum,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nikPemohon': nikPemohon,
      'namaPemohon': namaPemohon,
      'umurPemohon': umurPemohon,
      'hubunganPemohon': hubunganPemohon,
      'nikAlmarhum': nikAlmarhum,
      'namaAlmarhum': namaAlmarhum,
      'jenisKelaminAlmarhum': jenisKelaminAlmarhum,
      'hariKematianAlmarhum': hariKematianAlmarhum,
      'tanggalKematianAlmarhum': DateFormat('yyyy-MM-dd').format(tanggalKematianAlmarhum),
      'waktuKematianAlmarhum': waktuKematianAlmarhum,
      'tempatKematianAlmarhum': tempatKematianAlmarhum,
      'penyebabKematianAlmarhum': penyebabKematianAlmarhum,
      'buktiKematianAlmarhum': buktiKematianAlmarhum,
      'suratKematianAlmarhum': suratKematianAlmarhum,
      'ktpPemohon': ktpPemohon,
      'ktpAlmarhum': ktpAlmarhum,
      'kkAlmarhum': kkAlmarhum,
    };
  }

  static Kematian fromMap(Map<String, Object?> map) {
    return Kematian(
      id: map['id'] as int?,
      nikPemohon: map['nikPemohon'] as int,
      namaPemohon: map['namaPemohon'] as String,
      umurPemohon: map['umurPemohon'] as int,
      hubunganPemohon: map['hubunganPemohon'] as String,
      nikAlmarhum: map['nikAlmarhum'] as int,
      namaAlmarhum: map['namaAlmarhum'] as String,
      jenisKelaminAlmarhum: map['jenisKelaminAlmarhum'] as String,
      hariKematianAlmarhum: map['hariKematianAlmarhum'] as String,
      tanggalKematianAlmarhum: DateTime.parse(map['tanggalKematianAlmarhum'] as String),
      waktuKematianAlmarhum: map['waktuKematianAlmarhum'] as String,
      tempatKematianAlmarhum: map['tempatKematianAlmarhum'] as String,
      penyebabKematianAlmarhum: map['penyebabKematianAlmarhum'] as String,
      buktiKematianAlmarhum: map['buktiKematianAlmarhum'] as String,
      suratKematianAlmarhum: map['suratKematianAlmarhum'] as String,
      ktpPemohon: map['ktpPemohon'] as String,
      ktpAlmarhum: map['ktpAlmarhum'] as String,
      kkAlmarhum: map['kkAlmarhum'] as String,
    );
  }

  @override
  String toString() {
    return 'Kematian{id: $id, nikPemohon: $nikPemohon, namaPemohon: $namaPemohon, umurPemohon: $umurPemohon, hubunganPemohon: $hubunganPemohon, nikAlmarhum: $nikAlmarhum, namaAlmarhum: $namaAlmarhum, jenisKelaminAlmarhum: $jenisKelaminAlmarhum, hariKematianAlmarhum: $hariKematianAlmarhum, tanggalKematianAlmarhum: $tanggalKematianAlmarhum, waktuKematianAlmarhum: $waktuKematianAlmarhum, tempatKematianAlmarhum: $tempatKematianAlmarhum, penyebabKematianAlmarhum: $penyebabKematianAlmarhum, buktiKematianAlmarhum: $buktiKematianAlmarhum, suratKematianAlmarhum: $suratKematianAlmarhum, ktpPemohon: $ktpPemohon, ktpAlmarhum: $ktpAlmarhum, kkAlmarhum: $kkAlmarhum}';
  }
}
