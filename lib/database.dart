import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
        'username VARCHAR(255) NOT NULL, '
        'password VARCHAR(255) NOT NULL, '
        'nama_lengkap VARCHAR(255) NOT NULL, '
        'gambar VARCHAR(255) NOT NULL, '
        'tempat_lahir VARCHAR(255) NOT NULL, '
        'tanggal_lahir DATE NOT NULL, '
        'alamat_lengkap VARCHAR(255) NOT NULL, '
        'agama VARCHAR(255) NOT NULL, '
        'jenis_pekerjaan VARCHAR(255) NOT NULL, '
        'jenis_kelamin VARCHAR(255) NOT NULL, '
        'no_telepon BIGINT NOT NULL, '
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

    // Query the table for all the dogs.
    final List<Map<String, Object?>> registerMaps = await db.query('registers');

    // Convert the list of each dog's fields into a list of `Dog` objects.
    return [
      for (final {
            'id': id as int,
            'name': name as String,
            'age': age as int,
          } in registerMaps)
        Register(id: id, name: name, age: age),
    ];
  }

  Future<void> updateRegister(Register register) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'registers',
      register.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [register.id],
    );
  } 

  Future<void> deleteRegister(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'registers',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Dog and add it to the dogs table
  var fido = Register(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  await insertRegister(fido);

  // Now, use the method above to retrieve all the dogs.
  print(await registers()); // Prints a list that include Fido.

  // Update Fido's age and save it to the database.
  fido = Register(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );
  await updateRegister(fido);

  // Print the updated results.
  print(await registers()); // Prints Fido with age 42.

  // Delete Fido from the database.
  await deleteRegister(fido.id);

  // Print the list of dogs (empty).
  print(await registers());
}

class Register {
  final int id;
  final String name;
  final int age;

  Register({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Register{id: $id, name: $name, age: $age}';
  }
}