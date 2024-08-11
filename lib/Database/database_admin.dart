import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAdmin {
  static final DatabaseAdmin instance = DatabaseAdmin._init();
  static Database? _database;

  DatabaseAdmin._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('registersAdmin.db');
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
      CREATE TABLE registersAdmin(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        gambar TEXT NOT NULL,
        nama_instansi TEXT NOT NULL,
        alamat_instansi TEXT NOT NULL,
        no_telepon INTEGER NOT NULL,
        email TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertRegistersAdmin(RegisterAdmin registerAdmin) async {
    final db = await instance.database;
    await db.insert(
      'registersAdmin',
      registerAdmin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateRegistersAdmin(RegisterAdmin registerAdmin) async {
    final db = await instance.database;
    try {
      await db.update(
        'registersAdmin',
        registerAdmin.toMap(),
        where: 'id = ?', 
        whereArgs: [registerAdmin.id],
      );
    } catch (e) {
      print('Error updating registerAdmin: $e');
    }
  }

  Future<List<RegisterAdmin>> getRegistersAdmin() async {
    final db = await instance.database;
    final result = await db.query('registersAdmin');
    return result.map((json) => RegisterAdmin.fromMap(json)).toList();
  }

  Future<RegisterAdmin?> getRegisterAdminByUsername(String username) async {
    final db = await instance.database;
    final maps = await db.query(
      'registersAdmin',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return RegisterAdmin.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'registersAdmin.db');
    await databaseFactory.deleteDatabase(path);
    print('Database deleted');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class RegisterAdmin {
  final int? id;
  final String username;
  final String password;
  final String gambar;
  final String namaInstansi;
  final String alamatInstansi;
  final int noTelepon;
  final String email;

  RegisterAdmin({
    this.id,
    required this.username,
    required this.password,
    required this.gambar,
    required this.namaInstansi,
    required this.alamatInstansi,
    required this.noTelepon,
    required this.email,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'gambar': gambar,
      'nama_instansi': namaInstansi,
      'alamat_instansi': alamatInstansi,
      'no_telepon': noTelepon,
      'email': email,
    };
  }

  static RegisterAdmin fromMap(Map<String, Object?> map) {
    return RegisterAdmin(
      id: map['id'] as int?,
      username: map['username'] as String,
      password: map['password'] as String,
      gambar: map['gambar'] as String,
      namaInstansi: map['nama_instansi'] as String,
      alamatInstansi: map['alamat_instansi'] as String,
      noTelepon: map['no_telepon'] as int,
      email: map['email'] as String,
    );
  }

  @override
  String toString() {
    return 'RegisterAdmin{id: $id, username: $username, password: $password, gambar: $gambar, namaInstansi: $namaInstansi, alamatInstansi: $alamatInstansi, noTelepon: $noTelepon, email: $email}';
  }
}
