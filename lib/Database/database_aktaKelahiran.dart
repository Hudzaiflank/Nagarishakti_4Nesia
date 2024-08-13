import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DatabaseAktaKelahiran {
  static final DatabaseAktaKelahiran instance = DatabaseAktaKelahiran._init();
  static Database? _database;

  DatabaseAktaKelahiran._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('aktaKelahiran.db');
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
      CREATE TABLE aktaKelahiran(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nikPelapor INTEGER NOT NULL,
        namaPelapor TEXT NOT NULL,
        kkPelapor INTEGER NOT NULL,
        kewarganegaraanPelapor TEXT NOT NULL,
        nikAyah INTEGER NOT NULL,
        namaAyah TEXT NOT NULL,
        tempatLahirAyah TEXT NOT NULL,
        tanggalLahirAyah TEXT NOT NULL,
        kewarganegaraanAyah TEXT NOT NULL,
        nikIbu INTEGER NOT NULL,
        namaIbu TEXT NOT NULL,
        tempatLahirIbu TEXT NOT NULL,
        tanggalLahirIbu TEXT NOT NULL,
        kewarganegaraanIbu TEXT NOT NULL,
        nikAnak INTEGER NOT NULL,
        namaAnak TEXT NOT NULL,
        jenisKelaminAnak TEXT NOT NULL,
        tempatLahirAnak TEXT NOT NULL,
        daerahLahirAnak TEXT NOT NULL,
        hariLahirAnak TEXT NOT NULL,
        tanggalLahirAnak TEXT NOT NULL,
        waktuLahirAnak TEXT NOT NULL,
        jenisKelahiranAnak TEXT NOT NULL,
        jenisKelahiranAnakLainnya TEXT NOT NULL,
        urutanKelahiranAnak INTEGER NOT NULL,
        beratAnak TEXT NOT NULL,
        panjangAnak INTEGER NOT NULL,
        penolongKelahiranAnak TEXT NOT NULL,
        penolongKelahiranAnakLainnya TEXT NOT NULL,
        suratKelahiran TEXT NOT NULL,
        buktiSPTJM TEXT NOT NULL,
        kkOrangTua TEXT NOT NULL,
        ktpAyah TEXT NOT NULL,
        ktpIbu TEXT NOT NULL,
        dokumenTambahan TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertAkta(Akta akta) async {
    final db = await instance.database;
    await db.insert(
      'aktaKelahiran',
      akta.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateAkta(Akta akta) async {
  final db = await instance.database;
  await db.update(
    'aktaKelahiran',
    akta.toMap(),
    where: 'id = ?',
    whereArgs: [akta.id],
  );
}

  Future<List<Akta>> getAkta() async {
    final db = await instance.database;
    final result = await db.query('aktaKelahiran');
    return result.map((json) => Akta.fromMap(json)).toList();
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'aktaKelahiran.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Akta {
  final int? id;
  final int nikPelapor;
  final String namaPelapor;
  final int kkPelapor;
  final String kewarganegaraanPelapor;
  final int nikAyah;
  final String namaAyah;
  final String tempatLahirAyah;
  final DateTime tanggalLahirAyah;
  final String kewarganegaraanAyah;
  final int nikIbu;
  final String namaIbu;
  final String tempatLahirIbu;
  final DateTime tanggalLahirIbu;
  final String kewarganegaraanIbu;
  final int nikAnak;
  final String namaAnak;
  final String jenisKelaminAnak;
  final String tempatLahirAnak;
  final String daerahLahirAnak; 
  final String hariLahirAnak;
  final DateTime tanggalLahirAnak;
  final String waktuLahirAnak; 
  final String jenisKelahiranAnak;
  final String jenisKelahiranAnakLainnya;
  final int urutanKelahiranAnak;
  final String beratAnak;
  final int panjangAnak;
  final String penolongKelahiranAnak;
  final String penolongKelahiranAnakLainnya;
  final String suratKelahiran;
  final String buktiSPTJM;
  final String kkOrangTua;
  final String ktpAyah;
  final String ktpIbu;
  final String dokumenTambahan;

  Akta({
    this.id,
    required this.nikPelapor,
    required this.namaPelapor,
    required this.kkPelapor,
    required this.kewarganegaraanPelapor,
    required this.nikAyah,
    required this.namaAyah,
    required this.tempatLahirAyah,
    required this.tanggalLahirAyah,
    required this.kewarganegaraanAyah,
    required this.nikIbu,
    required this.namaIbu,
    required this.tempatLahirIbu,
    required this.tanggalLahirIbu,
    required this.kewarganegaraanIbu,
    required this.nikAnak,
    required this.namaAnak,
    required this.jenisKelaminAnak,
    required this.tempatLahirAnak,
    required this.daerahLahirAnak,
    required this.hariLahirAnak,
    required this.tanggalLahirAnak,
    required this.waktuLahirAnak,
    required this.jenisKelahiranAnak,
    required this.jenisKelahiranAnakLainnya,
    required this.urutanKelahiranAnak,
    required this.beratAnak,
    required this.panjangAnak,
    required this.penolongKelahiranAnak,
    required this.penolongKelahiranAnakLainnya,
    required this.suratKelahiran,
    required this.buktiSPTJM,
    required this.kkOrangTua,
    required this.ktpAyah,
    required this.ktpIbu,
    required this.dokumenTambahan,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nikPelapor': nikPelapor,
      'namaPelapor': namaPelapor,
      'kkPelapor': kkPelapor,
      'kewarganegaraanPelapor': kewarganegaraanPelapor,
      'nikAyah': nikAyah,
      'namaAyah': namaAyah,
      'tempatLahirAyah': tempatLahirAyah,
      'tanggalLahirAyah': DateFormat('yyyy-MM-dd').format(tanggalLahirAyah),
      'kewarganegaraanAyah': kewarganegaraanAyah,
      'nikIbu': nikIbu,
      'namaIbu': namaIbu,
      'tempatLahirIbu': tempatLahirIbu,
      'tanggalLahirIbu': DateFormat('yyyy-MM-dd').format(tanggalLahirIbu),
      'kewarganegaraanIbu': kewarganegaraanIbu,
      'nikAnak': nikAnak,
      'namaAnak': namaAnak,
      'jenisKelaminAnak': jenisKelaminAnak,
      'tempatLahirAnak': tempatLahirAnak,
      'daerahLahirAnak': daerahLahirAnak,
      'hariLahirAnak': hariLahirAnak,
      'tanggalLahirAnak': DateFormat('yyyy-MM-dd').format(tanggalLahirAnak),
      'waktuLahirAnak': waktuLahirAnak,
      'jenisKelahiranAnak': jenisKelahiranAnak,
      'jenisKelahiranAnakLainnya': jenisKelahiranAnakLainnya,
      'urutanKelahiranAnak': urutanKelahiranAnak,
      'beratAnak': beratAnak,
      'panjangAnak': panjangAnak,
      'penolongKelahiranAnak': penolongKelahiranAnak,
      'penolongKelahiranAnakLainnya': penolongKelahiranAnakLainnya,
      'suratKelahiran': suratKelahiran,
      'buktiSPTJM': buktiSPTJM,
      'kkOrangTua': kkOrangTua,
      'ktpAyah': ktpAyah,
      'ktpIbu': ktpIbu,
      'dokumenTambahan': dokumenTambahan,
    };
  }

  static Akta fromMap(Map<String, Object?> map) {
    return Akta(
      id: map['id'] as int?,
      nikPelapor: map['nikPelapor'] as int,
      namaPelapor: map['namaPelapor'] as String,
      kkPelapor: map['kkPelapor'] as int,
      kewarganegaraanPelapor: map['kewarganegaraanPelapor'] as String,
      nikAyah: map['nikAyah'] as int,
      namaAyah: map['namaAyah'] as String,
      tempatLahirAyah: map['tempatLahirAyah'] as String,
      tanggalLahirAyah: DateTime.parse(map['tanggalLahirAyah'] as String),
      kewarganegaraanAyah: map['kewarganegaraanAyah'] as String,
      nikIbu: map['nikIbu'] as int,
      namaIbu: map['namaIbu'] as String,
      tempatLahirIbu: map['tempatLahirIbu'] as String,
      tanggalLahirIbu: DateTime.parse(map['tanggalLahirIbu'] as String),
      kewarganegaraanIbu: map['kewarganegaraanIbu'] as String,
      nikAnak: map['nikAnak'] as int,
      namaAnak: map['namaAnak'] as String,
      jenisKelaminAnak: map['jenisKelaminAnak'] as String,
      tempatLahirAnak: map['tempatLahirAnak'] as String,
      daerahLahirAnak: map['daerahLahirAnak'] as String,
      hariLahirAnak: map['hariLahirAnak'] as String,
      tanggalLahirAnak: DateTime.parse(map['tanggalLahirAnak'] as String),
      waktuLahirAnak: map['waktuLahirAnak'] as String,
      jenisKelahiranAnak: map['jenisKelahiranAnak'] as String,
      jenisKelahiranAnakLainnya: map['jenisKelahiranAnakLainnya'] as String,
      urutanKelahiranAnak: map['urutanKelahiranAnak'] as int,
      beratAnak: map['beratAnak'] as String,
      panjangAnak: map['panjangAnak'] as int,
      penolongKelahiranAnak: map['penolongKelahiranAnak'] as String,
      penolongKelahiranAnakLainnya: map['penolongKelahiranAnakLainnya'] as String,
      suratKelahiran: map['suratKelahiran'] as String,
      buktiSPTJM: map['buktiSPTJM'] as String,
      kkOrangTua: map['kkOrangTua'] as String,
      ktpAyah: map['ktpAyah'] as String,
      ktpIbu: map['ktpIbu'] as String,
      dokumenTambahan: map['dokumenTambahan'] as String,
    );
  }

  @override
  String toString() {
    return 'Akta{id: $id, nikPelapor: $nikPelapor, namaPelapor: $namaPelapor, kkPelapor: $kkPelapor, kewarganegaraanPelapor: $kewarganegaraanPelapor, nikAyah: $nikAyah, namaAyah: $namaAyah, tempatLahirAyah: $tempatLahirAyah, tanggalLahirAyah: $tanggalLahirAyah, kewarganegaraanAyah: $kewarganegaraanAyah, nikIbu: $nikIbu, namaIbu: $namaIbu, tempatLahirIbu: $tempatLahirIbu, tanggalLahirIbu: $tanggalLahirIbu, kewarganegaraanIbu: $kewarganegaraanIbu, nikAnak: $nikAnak, namaAnak: $namaAnak, jenisKelaminAnak: $jenisKelaminAnak, tempatLahirAnak: $tempatLahirAnak, daerahLahirAnak: $daerahLahirAnak, hariLahirAnak: $hariLahirAnak, tanggalLahirAnak: $tanggalLahirAnak, waktuLahirAnak: $waktuLahirAnak, jenisKelahiranAnak: $jenisKelahiranAnak, jenisKelahiranAnakLainnya: $jenisKelahiranAnakLainnya, urutanKelahiranAnak: $urutanKelahiranAnak, beratAnak: $beratAnak, panjangAnak: $panjangAnak, penolongKelahiranAnak: $penolongKelahiranAnak, penolongKelahiranAnakLainnya: $penolongKelahiranAnakLainnya, suratKelahiran: $suratKelahiran, buktiSPTJM: $buktiSPTJM, kkOrangTua: $kkOrangTua, ktpAyah: $ktpAyah, ktpIbu: $ktpIbu, dokumenTambahan: $dokumenTambahan}';
  }
}
