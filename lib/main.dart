import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'database_user.dart';
import 'database_admin.dart';
import 'database_superAdmin.dart';
import 'User/user-home.dart';
import 'admin-home.dart';
import 'SuperAdmin-home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize databases
  await DatabaseUser.instance.database;
  await DatabaseAdmin.instance.database; 
  await DatabaseSuperAdmin.instance.database; 

  // Insert initial data
  await _insertInitialData();

  runApp(MyApp());
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserHome(),
      routes: {
        '/register': (context) => RegistrationScreen(),
      },
    );
  }
}