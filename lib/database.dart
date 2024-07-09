import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';


void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'regist_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE registers('
        'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
        'username VARCHAR(255) NOT NULL,'
        'password VARCHAR(255) NOT NULL,'
        'nama_lengkap VARCHAR(255) NOT NULL,'
        'gambar VARCHAR(255) NOT NULL,'
        'tempat_lahir VARCHAR(255) NOT NULL,'
        'tanggal_lahir DATE NOT NULL,'
        'alamat_lengkap VARCHAR(255) NOT NULL,'
        'agama VARCHAR(255) NOT NULL,'
        'jenis_pekerjaan VARCHAR(255) NOT NULL,'
        'jenis_kelamin VARCHAR(255) NOT NULL,'
        'no_telepon BIGINT NOT NULL,'
        'no_rekening BIGINT NOT NULL'
        ')',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts dogs into the database
  Future<void> insertRegister(Register register) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'registers',
      register.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Register>> registers() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all the registers.
    final List<Map<String, Object?>> registerMaps = await db.query('registers');

  // Convert the list of each register's fields into a list of `Register` objects.
    return [
      for (final {
        'id': id as int,
        'username': username as String,
        'password': password as String,
        'nama_lengkap': namaLengkap as String,
        'gambar': gambar as String,
        'tempat_lahir': tempatLahir as String,
        'tanggal_lahir': tanggalLahir as String,
        'alamat_lengkap': alamatLengkap as String,
        'agama': agama as String,
        'jenis_pekerjaan': jenisPekerjaan as String,
        'jenis_kelamin': jenisKelamin as String,
        'no_telepon': noTelepon as int,
        'no_rekening': noRekening as int,
      } in registerMaps)
        Register(
          id: id,
          username: username,
          password: password,
          namaLengkap: namaLengkap,
          gambar: gambar,
          tempatLahir: tempatLahir,
          tanggalLahir: DateTime.parse(tanggalLahir),
          alamatLengkap: alamatLengkap,
          agama: agama,
          jenisPekerjaan: jenisPekerjaan,
          jenisKelamin: jenisKelamin,
          noTelepon: noTelepon,
          noRekening: noRekening,
        ),
    ];
  }
  
  // Create a Register and add it to the registers table
  var newUser = Register(
    id: 0,
    username: 'Fido',
    password: 'password123',
    namaLengkap: 'Fido Dog',
    gambar: 'assets/my_image.jpg',
    tempatLahir: 'Jakarta',
    tanggalLahir: DateTime.parse('2000-02-29 00:00:00'),
    alamatLengkap: 'Jl. Jend. Sudirman No.1, Jakarta',
    agama: 'Islam',
    jenisPekerjaan: 'Software Engineer',
    jenisKelamin: 'Pria',
    noTelepon: int.parse('081233442211'),
    noRekening: int.parse('1234567890'),
  );

  await insertRegister(newUser);

  // Now, use the method above to retrieve all the registers.
  print(await registers()); // Prints a list that includes newUser.
}

class Register {
  final int id;
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
    required this.id,
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

  // Convert a Register into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'nama_lengkap': namaLengkap,
      'gambar': gambar,
      'tempat_lahir': tempatLahir,
      // Format tanggalLahir as 'yyyy-MM-dd' to ignore time information
      'tanggal_lahir': DateFormat('yyyy-MM-dd').format(tanggalLahir),
      'alamat_lengkap': alamatLengkap,
      'agama': agama,
      'jenis_pekerjaan': jenisPekerjaan,
      'jenis_kelamin': jenisKelamin,
      'no_telepon': noTelepon,
      'no_rekening': noRekening,
    };
  }

  // Implement toString to make it easier to see information about
  // each register when using the print statement.
  @override
  String toString() {
    return 'Register{id: $id, username: $username, password: $password, namaLengkap: $namaLengkap, gambar: $gambar, tempatLahir: $tempatLahir, tanggalLahir: $tanggalLahir, alamatLengkap: $alamatLengkap, agama: $agama, jenisPekerjaan: $jenisPekerjaan, jenisKelamin: $jenisKelamin, noTelepon: $noTelepon, noRekening: $noRekening}';
  }
}
