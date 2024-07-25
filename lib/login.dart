import 'package:flutter/material.dart';
import 'database_user.dart';
import 'database_admin.dart';
import 'database_superAdmin.dart';
import 'register.dart';
import 'User/user-home.dart'; 
import 'admin-home.dart';
import 'SuperAdmin-home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final dbUser = DatabaseUser.instance;
      final dbAdmin = DatabaseAdmin.instance;
      final dbSuperAdmin = DatabaseSuperAdmin.instance;

      try {
        // Check for regular user
        final userRegisters = await dbUser.getRegisters();
        final userExists = userRegisters.any(
          (register) =>
              register.username == _username && register.password == _password,
        );

        if (userExists) {
          // Save login status
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('loggedInUsername', _username);

          // Navigate to user home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserHome()),
          );
          return;
        }

        // Check for admin
        final adminRegisters = await dbAdmin.getRegistersAdmin();
        final adminExists = adminRegisters.any(
          (register) =>
              register.username == _username && register.password == _password,
        );

        if (adminExists) {
          // Save login status
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('loggedInUsername', _username);

          // Navigate to admin home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminHome()), // Adjust this as needed
          );
          return;
        }

        // Check for super admin
        final superAdminRegisters = await dbSuperAdmin.getRegistersSuperAdmin();
        final superAdminExists = superAdminRegisters.any(
          (register) =>
              register.username == _username && register.password == _password,
        );

        if (superAdminExists) {
          // Save login status
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);

          // Navigate to super admin home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const SuperAdminHome()), // Adjust this as needed
          );
          return;
        }

        // If no user, admin, or super admin is found
        throw Exception('User not found');
      } catch (e) {
        // Display an error message if user is not found
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid username or password'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4297A0),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 40.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FCFC),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Image.asset('assets/icon.png', height: 100),
                    const SizedBox(height: 10),
                    const Text(
                      'MASUK AKUN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum memiliki akun?',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegistrationScreen()),
                            );
                          },
                          child: const Text(
                            'daftar disini',
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 43),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'masukkan username',
                              hintStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Ubuntu'),
                              filled: true,
                              fillColor: const Color(0xFFE0E5E7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide:
                                    const BorderSide(color: Color(0xFFE0E5E7)),
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black, fontFamily: 'Ubuntu'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username tidak boleh kosong';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _username = value!;
                            },
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'masukkan password',
                              hintStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Ubuntu'),
                              filled: true,
                              fillColor: const Color(0xFFE0E5E7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide:
                                    const BorderSide(color: Color(0xFFE0E5E7)),
                              ),
                            ),
                            obscureText: true,
                            style: const TextStyle(
                                color: Colors.black, fontFamily: 'Ubuntu'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              SizedBox(
                height: 45,
                width: 280,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F5061),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  child: const Text(
                    'MASUK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}
