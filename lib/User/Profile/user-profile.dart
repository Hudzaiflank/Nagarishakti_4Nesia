import 'package:flutter/material.dart';
import 'edit-user-profile.dart'; // Tambahkan import ini
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '/Database/database_user.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  String _username = '';
  // String _password = '';
  String _namaLengkap = '';
  String _tempatLahir = '';
  DateTime _tanggalLahir = DateTime(2000, 2, 29);
  String _alamatLengkap = '';
  String _agama = '';
  String _jenisPekerjaan = '';
  String _jenisKelamin = '';
  int _noTelepon = 0;
  int _noRekening = 0;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('loggedInUsername') ?? '';

    if (username.isNotEmpty) {
      final dbUser = DatabaseUser.instance;
      final registers = await dbUser.getRegisters(); // Fetch all registers

      // Mencari user berdasarkan username
      final user = registers.firstWhere(
        (register) => register.username == username,
        orElse: () => Register(
          username: 'N/A',
          password: 'N/A',
          gambar: 'N/A',
          namaLengkap: 'N/A',
          tempatLahir: 'N/A',
          tanggalLahir: DateTime(2000, 2, 29),
          alamatLengkap: 'N/A',
          agama: 'N/A',
          jenisPekerjaan: 'N/A',
          jenisKelamin: 'N/A',
          noTelepon: 0,
          noRekening: 0,
        ),
      );

      setState(() {
        _username = user.username;
        // _password = user.password;
        _namaLengkap = user.namaLengkap;
        _tempatLahir = user.tempatLahir;
        _tanggalLahir = user.tanggalLahir;
        _alamatLengkap = user.alamatLengkap;
        _agama = user.agama;
        _jenisPekerjaan = user.jenisPekerjaan;
        _jenisKelamin = user.jenisKelamin;
        _noTelepon = user.noTelepon;
        _noRekening = user.noRekening;
      });
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('loggedInUsername');
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: const Color(0xFFECF5F6), // Background color
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/profile-edit/rectangle-1.png',
              width: 100,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/profile-edit/rectangle-2.png',
              width: 100,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/profile-edit/rectangle-3.png',
              width: MediaQuery.of(context).size.width / 2.8,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.cover,
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 280.0,
                floating: false,
                pinned: true,
                backgroundColor: const Color(0xFFECF5F6),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(top: 88),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              AssetImage('assets/user-home/profile-logo.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(height: 17),
                        Text(
                          _namaLengkap.isNotEmpty ? _namaLengkap : 'N/A',
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          _username.isNotEmpty ? _username : 'N/A',
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 50),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4297A0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildInfoRow('Username', _username),
                          // buildInfoRow('Password', _password),
                          buildInfoRow('Nama Lengkap', _namaLengkap),
                          buildInfoRow('Tempat Lahir', _tempatLahir),
                          buildInfoRow('Tanggal Lahir', DateFormat('yyyy-MM-dd').format(_tanggalLahir)),
                          buildInfoRow('Alamat Lengkap', _alamatLengkap),
                          buildInfoRow('Agama', _agama),
                          buildInfoRow('Jenis Pekerjaan', _jenisPekerjaan),
                          buildInfoRow('Jenis Kelamin', _jenisKelamin),
                          buildInfoRow('No Telepon', _noTelepon.toString()),
                          buildInfoRow('No Rekening', _noRekening.toString()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditUserProfilePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC6B79B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        ),
                        child: const Text(
                          'UBAH PROFIL',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 110),
                      child: ElevatedButton(
                        onPressed: _logout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F5061),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                        ),
                        child: const Text(
                          'KELUAR',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Text(
            ':',
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w300,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
