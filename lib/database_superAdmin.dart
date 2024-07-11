import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSuperAdmin {
  static final DatabaseSuperAdmin instance = DatabaseSuperAdmin._init();
  static Database? _database;

  DatabaseSuperAdmin._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('registSuperAdmin_database.db');
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
      CREATE TABLE registerSuperAdmins(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        gambar TEXT NOT NULL,
      )
    ''');
  }

  Future<void> insertRegisterSuperAdmin(RegisterSuperAdmin registerSuperAdmin) async {
    final db = await instance.database;
    await db.insert(
      'registerSuperAdmins',
      registerSuperAdmin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<RegisterSuperAdmin>> getRegistersSuperAdmin() async {
    final db = await instance.database;
    final result = await db.query('registerAdmins');
    return result.map((json) => RegisterSuperAdmin.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class RegisterSuperAdmin {
  final int? id;
  final String username;
  final String password;
  final String gambar;

  RegisterSuperAdmin({
    this.id,
    this.username = "admin1",
    this.password = "admin1debest",
    this.gambar = "defaultSuperAdminImage.png",
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'gambar': gambar,
    };
  }

  static RegisterSuperAdmin fromMap(Map<String, Object?> map) {
    return RegisterSuperAdmin(
      id: map['id'] as int?,
      username: map['username'] as String,
      password: map['password'] as String,
      gambar: map['gambar'] as String,
    );
  }

  @override
  String toString() {
    return 'RegisterAdmin{id: $id, username: $username, password: $password, gambar: $gambar}';
  }
}