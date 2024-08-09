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
import '/Database/database_acara.dart';
import '/Database/database_transportasi.dart';
import '/Database/database_ktp.dart';
import '/Database/database_kk.dart';
import '/Database/database_aktaKelahiran.dart';
import '/Database/database_suratKematian.dart';
import '/Database/database_perpindahan.dart';
import '/Database/database_agenda.dart';
import '/Database/database_dokumen.dart';
import 'User/user-home.dart';
import 'Admin/admin-home.dart';
import 'Admin/SuperAdmin-home.dart';
import 'User/Destination/user-Destination-page.dart';
import 'User/Destination/user-DetailDestination-page.dart';
import 'User/user-Timeline-Festival.dart';
import 'User/user-transportation-page.dart';
import 'User/Layanan-Kependudukan/Pembuatan-ktp-kk/user-kk-page.dart';
import 'User/Layanan-Kependudukan/Pembuatan-ktp-kk/user-ktp-page.dart';
import 'User/Layanan-Kependudukan/Pendaftaran-AktaLahir-kematian/Akta-lahir.dart';
import 'User/Layanan-Kependudukan/Pendaftaran-AktaLahir-kematian/Surat-Kematian.dart';
import 'User/Layanan-Kependudukan/Pembaruan-data/perpindahan-kependudukan.dart';
import 'User/Informasi-publik/Agenda-Pemerintah/Agenda-pemerintahan.dart';
import 'User/Informasi-publik/Dokumen-publik/Public-Document.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Delete the existing database
  await DatabaseDestinasi.instance.deleteDatabaseFile();
  await DatabaseDetailDestinasi.instance.deleteDatabaseFile();
  await DatabaseDokumen.instance.deleteDatabaseFile();

  // Initialize databases
  await DatabaseUser.instance.database;
  await DatabaseAdmin.instance.database; 
  await DatabaseSuperAdmin.instance.database; 
  await DatabaseDestinasi.instance.database;
  await DatabaseDetailDestinasi.instance.database;
  await DatabaseAcara.instance.database;
  await DatabaseTransportasi.instance.database;
  await DatabaseKtp.instance.database;
  await DatabaseKk.instance.database;
  await DatabaseAktaKelahiran.instance.database;
  await DatabaseSuratKematian.instance.database;
  await DatabasePerpindahan.instance.database;
  await DatabaseAgenda.instance.database;
  await DatabaseDokumen.instance.database;

  // Check table schema
  await DatabaseDetailDestinasi.instance.checkTableSchema();

  // Insert initial data
  await _insertInitialData();

  // Load Destination from json
  await loadDestinationsFromJson();

  // Load Detail Destination from json
  await loadDetailDestinationsFromJson();

  // Load Event from JSON
  await loadAcaraFromJson();

  // Load Transportation from JSON
  await loadTransportasiFromJson();

  // Load Agenda from JSON
  await loadAgendaFromJson();

  // Load Document from JSON
  await loadDokumenFromJson();

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
      gambar: "assets/user-home/profile-logo.png",
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
  final superAdminExists =
      (await dbSuperAdmin.getRegistersSuperAdmin()).isNotEmpty;
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
          colorString = 'FF$colorString';
        }

        // Convert the colorString to int
        int color = int.parse(colorString, radix: 16);

        final destinasi = Destinasi(
          title: destination['title'],
          location: destination['location'],
          imagePath: destination['imagePath'],
          backgroundColor: color,
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

    if (jsonData.containsKey('detailDestinasi')) {
      final List<dynamic> data = jsonData['detailDestinasi'];
      final DatabaseDetailDestinasi db = DatabaseDetailDestinasi.instance;

      for (var detailDestination in data) {
        final detailDestinasi = DetailDestinasi(
          deskripsi: detailDestination['deskripsi'],
          gambar: detailDestination['gambar'],
          fasilitas: detailDestination['fasilitas'],
          hargaTiket: detailDestination['hargaTiket'],
        );
        await db.insertDetailDestinasi(detailDestinasi);
      }
    } else {
      print('Key "detailDestinasi" not found in JSON');
    }
  } catch (e) {
    print('Error loading detail destinations from JSON: $e');
  }
}

Future<void> loadAcaraFromJson() async {
  try {
    final String response = await rootBundle.loadString('assets/API/acara.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    if (jsonData.containsKey('acara')) {
      final List<dynamic> data = jsonData['acara'];
      final DatabaseAcara db = DatabaseAcara.instance;

      for (var event in data) {
        final acara = Acara(
          id: event['id'],
          title: event['title'],
          location: event['location'],
          image: event['image'],
          date: event['date'],
          description: event['description'],
          notification: event['notification'],
        );
        await db.insertAcara(acara);
      }
    } else {
      print('Key "acara" not found in JSON');
    }
  } catch (e) {
    print('Error loading events from JSON: $e');
  }
}

Future<void> loadTransportasiFromJson() async {
  try {
    final String response = await rootBundle.loadString('assets/API/transportasi.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    if (jsonData.containsKey('transportasi')) {
      final List<dynamic> data = jsonData['transportasi'];
      final DatabaseTransportasi db = DatabaseTransportasi.instance;

      for (var transportation in data) {
        final transportasi = Transportasi(
          id: transportation['id'] ?? 0,
          gambar: transportation['gambar'],
          nama: transportation['nama'],
          deskripsi: transportation['deskripsi'],
          rute: transportation['rute'],
          jamOperasional: transportation['jamOperasional'],
          tarif: transportation['tarif'],
          fasilitas: transportation['fasilitas'],
          tambahan: transportation['tambahan'],
        );
        await db.insertTransportasi(transportasi);
      }
    } else {
      print('Key "transportasi" not found in JSON');
    }
  } catch (e) {
    print('Error loading transportations from JSON: $e');
  }
}

Future<void> loadAgendaFromJson() async {
  try {
    final String response = await rootBundle.loadString('assets/API/agenda.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    if (jsonData.containsKey('agenda')) {
      final List<dynamic> data = jsonData['agenda'];
      final DatabaseAgenda db = DatabaseAgenda.instance;

      for (var schedule in data) {
        final agenda = Agenda(
          id: schedule['id'],
          judul: schedule['judul'],
          waktu: schedule['waktu'],
          lokasi: schedule['lokasi'],
        );
        await db.insertAgenda(agenda);
      }
    } else {
      print('Key "agenda" not found in JSON');
    }
  } catch (e) {
    print('Error loading agendas from JSON: $e');
  }
}

Future<void> loadDokumenFromJson() async {
  try {
    final String response = await rootBundle.loadString('assets/API/dokumen.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    if (jsonData.containsKey('dokumen')) {
      final List<dynamic> data = jsonData['dokumen'];
      final DatabaseDokumen db = DatabaseDokumen.instance;

      for (var document in data) {
        final dokumen = Dokumen(
          id: document['id'],
          title: document['title'],
          date: document['date'],
          time: document['time'], 
          fileUrl: document['fileUrl'], 
        );
        await db.insertDokumen(dokumen);
      }
    } else {
      print('Key "dokumen" not found in JSON');
    }
  } catch (e) {
    print('Error loading documents from JSON: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration & Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AdminHome(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
      },
    );
  }
}
