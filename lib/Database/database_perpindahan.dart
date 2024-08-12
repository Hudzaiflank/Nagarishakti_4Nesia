import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DatabasePerpindahan {
  static final DatabasePerpindahan instance = DatabasePerpindahan._init();
  static Database? _database;

  DatabasePerpindahan._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('perpindahanKependudukan.db');
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
      CREATE TABLE perpindahanKependudukan(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kkPemohon INTEGER NOT NULL,
        nikPemohon INTEGER NOT NULL,
        namaPemohon TEXT NOT NULL,
        kedudukanPemohon TEXT NOT NULL,
        alasanPembuatan TEXT NOT NULL,
        alamatAsal TEXT NOT NULL,
        rtAsal INTEGER NOT NULL,
        rwAsal INTEGER NOT NULL,
        kodePosAsal INTEGER NOT NULL,
        provinsiAsal TEXT NOT NULL,
        kotaKapubatenAsal TEXT NOT NULL,
        kecamatanAsal TEXT NOT NULL,
        desaKelurahanAsal TEXT NOT NULL,
        alamatTujuanDaerah TEXT NOT NULL,
        rtTujuan INTEGER NOT NULL,
        rwTujuan INTEGER NOT NULL,
        kodePosTujuan INTEGER NOT NULL,
        provinsiTujuan TEXT NOT NULL,
        kotaKabupatenTujuan TEXT NOT NULL,
        kecamatanTujuan TEXT NOT NULL,
        desaKelurahanTujuan TEXT NOT NULL,
        alasanPerpindahan TEXT NOT NULL,
        alasanPerpindahanLainnya TEXT NOT NULL,
        jenisPerpindahan TEXT NOT NULL,
        kepindahanAnggotaKeluarga TEXT NOT NULL,
        alamatTujuanNegara TEXT NOT NULL,
        kodeNegara TEXT NOT NULL,
        namaPenanggungJawab TEXT NOT NULL,
        tanggalPerpindahan TEXT NOT NULL,
        nomorHandphone INTEGER NOT NULL,
        namaPelapor TEXT NOT NULL,
        ktpPemohon TEXT NOT NULL,
        kartuKeluarga TEXT NOT NULL,
        formulirF102 TEXT NOT NULL,
        formulirF103 TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertPerpindahanKependudukan(Perpindahan perpindahan) async {
    final db = await instance.database;
    await db.insert(
      'perpindahanKependudukan',
      perpindahan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updatePerpindahanKependudukan(Perpindahan perpindahan) async {
  final db = await instance.database;
  await db.update(
    'perpindahanKependudukan',
    perpindahan.toMap(),
    where: 'id = ?',
    whereArgs: [perpindahan.id],
  );
}

  Future<List<Perpindahan>> getPerpindahanKependudukan() async {
    final db = await instance.database;
    final result = await db.query('perpindahanKependudukan');
    return result.map((json) => Perpindahan.fromMap(json)).toList();
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'perpindahanKependudukan.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Perpindahan {
  final int? id;
  final int kkPemohon;
  final int nikPemohon;
  final String namaPemohon;
  final String kedudukanPemohon;
  final String alasanPembuatan;
  final String alamatAsal;
  final int rtAsal;
  final int rwAsal;
  final int kodePosAsal;
  final String provinsiAsal;
  final String kotaKapubatenAsal;
  final String kecamatanAsal;
  final String desaKelurahanAsal;
  final String alamatTujuanDaerah;
  final int rtTujuan;
  final int rwTujuan;
  final int kodePosTujuan;
  final String provinsiTujuan;
  final String kotaKabupatenTujuan;
  final String kecamatanTujuan;
  final String desaKelurahanTujuan;
  final String alasanPerpindahan;
  final String alasanPerpindahanLainnya;
  final String jenisPerpindahan;
  final String kepindahanAnggotaKeluarga;
  final String alamatTujuanNegara;
  final String kodeNegara;
  final String namaPenanggungJawab;
  final DateTime tanggalPerpindahan;
  final int nomorHandphone;
  final String namaPelapor;
  final String ktpPemohon;
  final String kartuKeluarga;
  final String formulirF102;
  final String formulirF103;

  Perpindahan({
    this.id,
    required this.kkPemohon,
    required this.nikPemohon,
    required this.namaPemohon,
    required this.kedudukanPemohon,
    required this.alasanPembuatan,
    required this.alamatAsal,
    required this.rtAsal,
    required this.rwAsal,
    required this.kodePosAsal,
    required this.provinsiAsal,
    required this.kotaKapubatenAsal,
    required this.kecamatanAsal,
    required this.desaKelurahanAsal,
    required this.alamatTujuanDaerah,
    required this.rtTujuan,
    required this.rwTujuan,
    required this.kodePosTujuan,
    required this.provinsiTujuan,
    required this.kotaKabupatenTujuan,
    required this.kecamatanTujuan,
    required this.desaKelurahanTujuan,
    required this.alasanPerpindahan,
    required this.alasanPerpindahanLainnya,
    required this.jenisPerpindahan,
    required this.kepindahanAnggotaKeluarga,
    required this.alamatTujuanNegara,
    required this.kodeNegara,
    required this.namaPenanggungJawab,
    required this.tanggalPerpindahan,
    required this.nomorHandphone,
    required this.namaPelapor,
    required this.ktpPemohon,
    required this.kartuKeluarga,
    required this.formulirF102,
    required this.formulirF103,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'kkPemohon': kkPemohon,
      'nikPemohon': nikPemohon,
      'namaPemohon': namaPemohon,
      'kedudukanPemohon': kedudukanPemohon,
      'alasanPembuatan': alasanPembuatan,
      'alamatAsal': alamatAsal,
      'rtAsal': rtAsal,
      'rwAsal': rwAsal,
      'kodePosAsal': kodePosAsal,
      'provinsiAsal': provinsiAsal,
      'kotaKapubatenAsal': kotaKapubatenAsal,
      'kecamatanAsal': kecamatanAsal,
      'desaKelurahanAsal': desaKelurahanAsal,
      'alamatTujuanDaerah': alamatTujuanDaerah,
      'rtTujuan': rtTujuan,
      'rwTujuan': rwTujuan,
      'kodePosTujuan': kodePosTujuan,
      'provinsiTujuan': provinsiTujuan,
      'kotaKabupatenTujuan': kotaKabupatenTujuan,
      'kecamatanTujuan': kecamatanTujuan,
      'desaKelurahanTujuan': kodePosAsal,
      'alasanPerpindahan': alasanPerpindahan,
      'alasanPerpindahanLainnya': alasanPerpindahanLainnya,
      'jenisPerpindahan': jenisPerpindahan,
      'kepindahanAnggotaKeluarga': kepindahanAnggotaKeluarga,
      'alamatTujuanNegara': alamatTujuanNegara,
      'kodeNegara': kodeNegara,
      'namaPenanggungJawab': namaPenanggungJawab,
      'tanggalPerpindahan': DateFormat('yyyy-MM-dd').format(tanggalPerpindahan),
      'nomorHandphone': nomorHandphone,
      'namaPelapor': namaPelapor,
      'ktpPemohon': ktpPemohon,
      'kartuKeluarga': kartuKeluarga,
      'formulirF102': formulirF102,
      'formulirF103': formulirF103,
    };
  }

  static Perpindahan fromMap(Map<String, Object?> map) {
    return Perpindahan(
      id: map['id'] as int?,
      kkPemohon: map['kkPemohon'] as int,
      nikPemohon: map['nikPemohon'] as int,
      namaPemohon: map['namaPemohon'] as String,
      kedudukanPemohon: map['kedudukanPemohon'] as String,
      alasanPembuatan: map['alasanPembuatan'] as String,
      alamatAsal: map['alamatAsal'] as String,
      rtAsal: map['rtAsal'] as int,
      rwAsal: map['rwAsal'] as int,
      kodePosAsal: map['kodePosAsal'] as int,
      provinsiAsal: map['provinsiAsal'] as String,
      kotaKapubatenAsal: map['kotaKapubatenAsal'] as String,
      kecamatanAsal: map['kecamatanAsal'] as String,
      desaKelurahanAsal: map['desaKelurahanAsal'] as String,
      alamatTujuanDaerah: map['alamatTujuanDaerah'] as String,
      rtTujuan: map['rtTujuan'] as int,
      rwTujuan: map['rwTujuan'] as int,
      kodePosTujuan: map['kodePosTujuan'] as int,
      provinsiTujuan: map['provinsiTujuan'] as String,
      kotaKabupatenTujuan: map['kotaKabupatenTujuan'] as String,
      kecamatanTujuan: map['kecamatanTujuan'] as String,
      desaKelurahanTujuan: map['desaKelurahanTujuan'] as String,
      alasanPerpindahan: map['alasanPerpindahan'] as String,
      alasanPerpindahanLainnya: map['alasanPerpindahanLainnya'] as String,
      jenisPerpindahan: map['jenisPerpindahan'] as String,
      kepindahanAnggotaKeluarga: map['kepindahanAnggotaKeluarga'] as String,
      alamatTujuanNegara: map['alamatTujuanNegara'] as String,
      kodeNegara: map['kodeNegara'] as String,
      namaPenanggungJawab: map['namaPenanggungJawab'] as String,
      tanggalPerpindahan: DateTime.parse(map['tanggalPerpindahan'] as String),
      nomorHandphone: map['nomorHandphone'] as int,
      namaPelapor: map['namaPelapor'] as String,
      ktpPemohon: map['ktpPemohon'] as String,
      kartuKeluarga: map['kartuKeluarga'] as String,
      formulirF102: map['formulirF102'] as String,
      formulirF103: map['formulirF103'] as String,
    );
  }

  @override
  String toString() {
    return 'Perpindahan{id: $id, kkPemohon: $kkPemohon, nikPemohon: $nikPemohon, namaPemohon: $namaPemohon, kedudukanPemohon: $kedudukanPemohon, alasanPembuatan: $alasanPembuatan, alamatAsal: $alamatAsal, rtAsal: $rtAsal, rwAsal: $rwAsal, kodePosAsal: $kodePosAsal, provinsiAsal: $provinsiAsal, kotaKapubatenAsal: $kotaKapubatenAsal, kecamatanAsal: $kecamatanAsal, desaKelurahanAsal: $desaKelurahanAsal, alamatTujuanDaerah: $alamatTujuanDaerah, rtTujuan: $rtTujuan, rwTujuan: $rwTujuan, kodePosTujuan: $kodePosTujuan, provinsiTujuan: $provinsiTujuan, kotaKabupatenTujuan: $kotaKabupatenTujuan, kecamatanTujuan: $kecamatanTujuan, desaKelurahanTujuan: $desaKelurahanTujuan, alasanPerpindahan: $alasanPerpindahan, alasanPerpindahanLainnya: $alasanPerpindahanLainnya, jenisPerpindahan: $jenisPerpindahan, kepindahanAnggotaKeluarga: $kepindahanAnggotaKeluarga, alamatTujuanNegara: $alamatTujuanNegara, kodeNegara: $kodeNegara, namaPenanggungJawab: $namaPenanggungJawab, nomorHandphone: $nomorHandphone, namaPelapor: $namaPelapor, ktpPemohon: $ktpPemohon, kartuKeluarga: $kartuKeluarga, formulirF102: $formulirF102, formulirF103: $formulirF103}';
  }
}
