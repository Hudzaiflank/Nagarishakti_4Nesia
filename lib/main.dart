import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'login.dart';
import 'register.dart';
import '/Database/database_user.dart';
import '/Database/database_admin.dart';
import '/Database/database_superAdmin.dart';
import '/Database/database_destinasi.dart';
import '/Database/database_detailDestinasi.dart';
import 'User/user-home.dart';
import 'admin-home.dart';
import 'SuperAdmin-home.dart';
import 'User/Destination/user-Destination-page.dart';
import 'User/Destination/user-DetailDestination-page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize databases
  await DatabaseUser.instance.database;
  await DatabaseAdmin.instance.database; 
  await DatabaseSuperAdmin.instance.database; 
  await DatabaseDestinasi.instance.database;
  await DatabaseDetailDestinasi.instance.database;

  // Insert initial data
  await _insertInitialData();

  // Load Destination from json
  await loadDestinationsFromJson();

  // Load Destination from json
  await loadDetailDestinationsFromJson();

  runApp(const MyApp());
}

Future<void> _insertInitialData() async {
  final dbUser = DatabaseUser.instance;
  final dbAdmin = DatabaseAdmin.instance;
  final dbSuperAdmin = DatabaseSuperAdmin.instance;

  final userExists = (await dbUser.getRegisters()).isNotEmpty;
  if (!userExists) {
    final user = Register(
      username: "user1",
      password: "user1mantap",
      gambar: "default_image_path",
      namaLengkap: "User Pertama",
      tempatLahir: "Bandung",
      tanggalLahir: DateTime(2000, 2, 29),
      alamatLengkap: "Jl. Dipatiukur",
      agama: "Islam",
      jenisPekerjaan: "Mahasiswa",
      jenisKelamin: "Laki-laki",
      noTelepon: 08123456789,
      noRekening: 1234567890,
    );
    await dbUser.insertRegister(user);
  }

  // Insert an admin record if not exists
  final adminExists = (await dbAdmin.getRegistersAdmin()).isNotEmpty;
  if (!adminExists) {
    final admin = RegisterAdmin(
      username: "admin1",
      password: "admin1mantap",
      gambar: "defaultAdminImage.png",
      namaInstansi: "Dinas Pariwisata Kota Bandung",
      alamatInstansi: "Jl. Asia Afrika",
      noTelepon: 227271724,
      email: "disbudpar@bandung",
    );
    await dbAdmin.insertRegisterAdmin(admin);
  }

  // Insert a super admin record if not exists
  final superAdminExists = (await dbSuperAdmin.getRegistersSuperAdmin()).isNotEmpty;
  if (!superAdminExists) {
    final superAdmin = RegisterSuperAdmin(
      username: "superadmin1",
      password: "superadmin1mantap",
      gambar: "defaultSuperAdminImage.png",
    );
    await dbSuperAdmin.insertRegisterSuperAdmin(superAdmin);
  }
}

Future<void> loadDestinationsFromJson() async {
  try {
    final String response = await rootBundle.loadString('assets/API/destinasi.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    if (jsonData.containsKey('destinasi')) {
      final List<dynamic> data = jsonData['destinasi'];
      final DatabaseDestinasi db = DatabaseDestinasi.instance;

      for (var destination in data) {
        String colorString = destination['backgroundColor'];
        
        // Remove the "0x" prefix if it exists
        if (colorString.startsWith('0x')) {
          colorString = colorString.substring(2);
        }
        
        // Ensure the colorString is in ARGB format
        if (colorString.length == 6) {
          colorString = 'FF' + colorString; // Add alpha channel
        }

        // Convert the colorString to int
        int color = int.parse(colorString, radix: 16);

        final destinasi = Destinasi(
          title: destination['title'],
          location: destination['location'],
          imagePath: destination['imagePath'],
          backgroundColor: color, // Store as integer
          savedBy: destination['savedBy'],
          bookmark: destination['bookmark'],
        );
        await db.insertDestinasi(destinasi);
      }
    } else {
      print('Key "destinasi" not found in JSON');
    }
  } catch (e) {
    print('Error loading destinations from JSON: $e');
  }
}

Future<void> loadDetailDestinationsFromJson() async {
  try {
    final String response = await rootBundle.loadString('assets/API/detailDestinasi.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    if (jsonData.containsKey('destinasi')) {
      final List<dynamic> data = jsonData['destinasi'];
      final DatabaseDestinasi db = DatabaseDestinasi.instance;

      for (var destination in data) {
        String colorString = destination['backgroundColor'];
        
        // Remove the "0x" prefix if it exists
        if (colorString.startsWith('0x')) {
          colorString = colorString.substring(2);
        }
        
        // Ensure the colorString is in ARGB format
        if (colorString.length == 6) {
          colorString = 'FF' + colorString; // Add alpha channel
        }

        // Convert the colorString to int
        int color = int.parse(colorString, radix: 16);

        final destinasi = Destinasi(
          title: destination['title'],
          location: destination['location'],
          imagePath: destination['imagePath'],
          backgroundColor: color, // Store as integer
          savedBy: destination['savedBy'],
          bookmark: destination['bookmark'],
        );
        await db.insertDestinasi(destinasi);
      }
    } else {
      print('Key "destinasi" not found in JSON');
    }
  } catch (e) {
    print('Error loading destinations from JSON: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserHome(),
      routes: {
        '/register': (context) => const RegistrationScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
