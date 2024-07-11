import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'database_user.dart';
// seharusnya dibawah ini ada import database_admin + database_superAdmin, atau gaada ya?

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inisialisasi database
  await DatabaseUser.instance.database;
  // seharusnya dibawah ini ada await DatabaseUser.instance.database; tapi buat admin + superAdmin atau gaada ya?
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        '/register': (context) => RegistrationScreen(),
      },
    );
  }
}
