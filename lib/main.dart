import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'database_user.dart';
import 'admin-home.dart';
// import 'SuperAdmin-home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseUser.instance.database;

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
      home: RegistrationScreen(), // Ubah menjadi widget dari admin-home.dart
      routes: {
        '/register': (context) => RegistrationScreen(),
      },
    );
  }
}
