import 'package:flutter/material.dart';
import 'database_user.dart';
// seharusnya dibawah ini ada import database_admin + database_superAdmin
import 'database_admin.dart';
import 'database_superAdmin.dart';
import 'register.dart';
import 'User/user-home.dart'; // Import UserHome
import 'admin-home.dart';
import 'SuperAdmin-home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;

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
          // Navigate to user home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserHome()),
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
          // Navigate to admin home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AdminHome()), // Adjust this as needed
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
          // Navigate to super admin home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SuperAdminHome()), // Adjust this as needed
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
            title: Text('Login Failed'),
            content: Text('Invalid username or password'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
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
      backgroundColor: Color(0xFF4297A0),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 40.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF9FCFC),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Image.asset('assets/icon.png', height: 100),
                    SizedBox(height: 10),
                    Text(
                      'MASUK AKUN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum memiliki akun?',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()),
                            );
                          },
                          child: Text(
                            'daftar disini',
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 43),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'masukkan username',
                              hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Ubuntu'),
                              filled: true,
                              fillColor: Color(0xFFE0E5E7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide:
                                    BorderSide(color: Color(0xFFE0E5E7)),
                              ),
                            ),
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'Ubuntu'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username tidak boleh kosong';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _username = value;
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'masukkan password',
                              hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Ubuntu'),
                              filled: true,
                              fillColor: Color(0xFFE0E5E7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide:
                                    BorderSide(color: Color(0xFFE0E5E7)),
                              ),
                            ),
                            obscureText: true,
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'Ubuntu'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
              SizedBox(
                height: 45,
                width: 280,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2F5061),
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  child: Text(
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
              SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}
