import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DatabaseUser {
  static final DatabaseUser instance = DatabaseUser._init();
  static Database? _database;

  DatabaseUser._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('register.db');
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
      CREATE TABLE registers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        nama_lengkap TEXT NOT NULL,
        gambar TEXT NOT NULL,
        tempat_lahir TEXT NOT NULL,
        tanggal_lahir TEXT NOT NULL,
        alamat_lengkap TEXT NOT NULL,
        agama TEXT NOT NULL,
        jenis_pekerjaan TEXT NOT NULL,
        jenis_kelamin TEXT NOT NULL,
        no_telepon INTEGER NOT NULL,
        no_rekening INTEGER NOT NULL
      )
    ''');
  }

  Future<void> insertRegister(Register register) async {
    final db = await instance.database;
    await db.insert(
      'registers',
      register.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateRegister(Register register) async {
  final db = await instance.database;
  await db.update(
    'registers',
    register.toMap(),
    where: 'username = ?',
    whereArgs: [register.username],
  );
}

  Future<List<Register>> getRegisters() async {
    final db = await instance.database;
    final result = await db.query('registers');
    return result.map((json) => Register.fromMap(json)).toList();
  }
  
  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'register.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Register {
  final int? id;
  final String username;
  final String password;
  final String namaLengkap;
  final String gambar;
  final String tempatLahir;
  final DateTime tanggalLahir;
  final String alamatLengkap;
  final String agama;
  final String jenisPekerjaan;
  final String jenisKelamin;
  final int noTelepon;
  final int noRekening;

  Register({
    this.id,
    required this.username,
    required this.password,
    required this.namaLengkap,
    required this.gambar,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.alamatLengkap,
    required this.agama,
    required this.jenisPekerjaan,
    required this.jenisKelamin,
    required this.noTelepon,
    required this.noRekening,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'nama_lengkap': namaLengkap,
      'gambar': gambar,
      'tempat_lahir': tempatLahir,
      'tanggal_lahir': DateFormat('yyyy-MM-dd').format(tanggalLahir),
      'alamat_lengkap': alamatLengkap,
      'agama': agama,
      'jenis_pekerjaan': jenisPekerjaan,
      'jenis_kelamin': jenisKelamin,
      'no_telepon': noTelepon,
      'no_rekening': noRekening,
    };
  }

  static Register fromMap(Map<String, Object?> map) {
    return Register(
      id: map['id'] as int?,
      username: map['username'] as String,
      password: map['password'] as String,
      namaLengkap: map['nama_lengkap'] as String,
      gambar: map['gambar'] as String,
      tempatLahir: map['tempat_lahir'] as String,
      tanggalLahir: DateTime.parse(map['tanggal_lahir'] as String),
      alamatLengkap: map['alamat_lengkap'] as String,
      agama: map['agama'] as String,
      jenisPekerjaan: map['jenis_pekerjaan'] as String,
      jenisKelamin: map['jenis_kelamin'] as String,
      noTelepon: map['no_telepon'] as int,
      noRekening: map['no_rekening'] as int,
    );
  }

  @override
  String toString() {
    return 'Register{id: $id, username: $username, password: $password, namaLengkap: $namaLengkap, gambar: $gambar, tempatLahir: $tempatLahir, tanggalLahir: $tanggalLahir, alamatLengkap: $alamatLengkap, agama: $agama, jenisPekerjaan: $jenisPekerjaan, jenisKelamin: $jenisKelamin, noTelepon: $noTelepon, noRekening: $noRekening}';
  }
}
