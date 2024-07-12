import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAdmin {
  static final DatabaseAdmin instance = DatabaseAdmin._init();
  static Database? _database;

  DatabaseAdmin._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('registAdmin_database.db');
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
      CREATE TABLE registersAdmin(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        gambar TEXT NOT NULL,
        nama_instansi TEXT NOT NULL,
        alamat_instansi TEXT NOT NULL,
        no_telepon INTEGER NOT NULL,
        email TEXT NOT NULL,
        user_type TEXT NOT NULL // Add this line
      )
    ''');
  }

  Future<void> insertRegisterAdmin(RegisterAdmin registerAdmin) async {
    final db = await instance.database;
    await db.insert(
      'registersAdmin',
      registerAdmin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<RegisterAdmin>> getRegistersAdmin() async {
    final db = await instance.database;
    final result = await db.query('registersAdmin');
    return result.map((json) => RegisterAdmin.fromMap(json)).toList();
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
  final String userType; // Add this line

  RegisterAdmin({
    this.id,
    this.username = "admin1",
    this.password = "admin1mantap",
    this.gambar = "defaultAdminImage.png",
    this.namaInstansi = "Dinas Pariwisata Kota Bandung",
    this.alamatInstansi = "Jl. Asia Afrika",
    this.noTelepon = 0227271724,
    this.email = "disbudpar@bandung",
    this.userType = "admin", // And this line
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
      'user_type': userType, // And this line
    };
  }

  static RegisterAdmin fromMap(Map<String, Object?> map) {
    return RegisterAdmin(
      id: map['id'] as int?,
      username: map['username'] as String,
      password: map['password'] as String,
      gambar: map['gambar'] as String,
      namaInstansi: map['nama_instansi'] as String,
      alamatInstansi: map['alamat_lengkap'] as String,
      noTelepon: map['no_telepon'] as int,
      email: map['email'] as String,
      userType: map['user_type'] as String, // And this line
    );
  }

  @override
  String toString() {
    return 'RegisterAdmin{id: $id, username: $username, password: $password, gambar: $gambar, namaInstansi: $namaInstansi, alamatLengkap: $alamatInstansi, noTelepon: $noTelepon, email: $email, userType: $userType}'; // Update this line
  }
}
