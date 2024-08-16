import 'package:flutter/material.dart';
import '/Database/database_superAdmin.dart';
import '/Database/database_integrasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuperAdminHome extends StatefulWidget {
  const SuperAdminHome({super.key});

  @override
  _SuperAdminHome createState() => _SuperAdminHome();
}

class _SuperAdminHome extends State<SuperAdminHome> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _linkAPIFocusNode = FocusNode();
  final FocusNode _namaDaerahFocusNode = FocusNode();
  String _username = '';
  String? _linkAPI;
  String? _namaDaerah;
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _loadSuperAdminInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_linkAPIFocusNode);
      FocusScope.of(context).requestFocus(_namaDaerahFocusNode);
    });
  }

  @override
  void dispose() {
    _linkAPIFocusNode.dispose();
    _namaDaerahFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadSuperAdminInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('loggedInUsername') ?? '';

    if (username.isNotEmpty) {
      final dbSuperAdmin = DatabaseSuperAdmin.instance;
      final registersSuperAdmin = await dbSuperAdmin.getRegistersSuperAdmin(); // Fetch all registers

      // Mencari user berdasarkan username
      final superAdmin = registersSuperAdmin.firstWhere(
        (registerSuperAdmin) => registerSuperAdmin.username == username,
        orElse: () => RegisterSuperAdmin(
          username: 'N/A',
          password: 'N/A',
          gambar: 'assets/user-home/admin-profile.png',
        ),
      );

      setState(() {
        _username = superAdmin.username;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Pastikan bahwa _linkAPI dan _namaDaerah tidak null
      if (_linkAPI != null && _namaDaerah != null) {
        final newIntegrasi = Integration(
          linkAPI: _linkAPI!,
          namaDaerah: _namaDaerah!,
        );

        try {
          final dbIntegrasi = DatabaseIntegration.instance;
          await dbIntegrasi.insertIntegrations(newIntegrasi);

          // Menambahkan data baru ke _history jika diperlukan
          setState(() {
            _history.add(_linkAPI!);
            // Anda bisa juga menambahkan _namaDaerah ke _history jika perlu
            _history.add(_namaDaerah!);
          });

          // Debug log untuk memeriksa _history
          print("Riwayat: $_history");

          // Pastikan _history tidak kosong sebelum menavigasi
          if (_history.isNotEmpty) {
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            print("Riwayat kosong, tidak dapat menavigasi");
          }
        } catch (error) {
          // Menangani error atau menampilkan pesan
          print("Error saving integration: $error");
        }
      } else {
        print("Link API atau Nama Daerah tidak boleh kosong");
      }
    } else {
      print("Form tidak valid");
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
      backgroundColor: Color(0xFFE3EFF1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 40),
                // Judul
                Text(
                  'HALO SUPER ADMIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 25), // Jarak ke container di bawahnya

                // Container Integrasi Layanan Daerah
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF4297A0),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'INTEGRASI LAYANAN DAERAH',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 15), // Jarak ke container di bawahnya
                      Container(
                        padding:
                            EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFE2DED0),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Center(
                              child: Text(
                                'SYARAT DAN KETENTUAN',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Pastikan lagi data di dalam API telah ',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black,
                                    height: 1.7, // Spasi antar baris sebesar 5px
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'sesuai dengan standar',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' yang kita tetapkan, cek lagi penamaan tabel, kolom, dan data lainnya juga. Pastikan, list data berikut harus sudah ada:',
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('•', style: TextStyle(height: 1.5)),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: Text('Data KTP dan KK',
                                                style: TextStyle(height: 1.5))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('•', style: TextStyle(height: 1.5)),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: Text(
                                                'Data Kelahiran dan Kematian',
                                                style: TextStyle(height: 1.5))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('•', style: TextStyle(height: 1.5)),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: Text(
                                                'Daftar tempat wisata daerah',
                                                style: TextStyle(height: 1.5))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('•', style: TextStyle(height: 1.5)),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: Text(
                                                'Agenda Acara dan Festival Daerah',
                                                style: TextStyle(height: 1.5))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('•', style: TextStyle(height: 1.5)),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: Text(
                                                'Informasi Transportasi Daerah',
                                                style: TextStyle(height: 1.5))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('•', style: TextStyle(height: 1.5)),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: Text(
                                                'Berita Terkini di daerah',
                                                style: TextStyle(height: 1.5))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('•', style: TextStyle(height: 1.5)),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: Text(
                                                'Data atau Dokumen file Publik',
                                                style: TextStyle(height: 1.5))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('•', style: TextStyle(height: 1.5)),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: Text(
                                                'Kalender Kegiatan pemerintah daerah',
                                                style: TextStyle(height: 1.5))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'INPUT API',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        focusNode: _linkAPIFocusNode,
                        decoration: InputDecoration(
                          hintText: 'ketik link api',
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        onSaved: (value) {
                          _linkAPI = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Link API tidak boleh kosong';
                          }
                          return null;
                        },      
                        autofocus: true,                  
                      ),
                      SizedBox(height: 20),
                      Text(
                        'DAERAH',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        focusNode: _namaDaerahFocusNode,
                        decoration: InputDecoration(
                          hintText: 'ketik daerah',
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        onSaved: (value) {
                          _namaDaerah = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Daerah tidak boleh kosong';
                          }
                          return null;
                        }, 
                        autofocus: true,                       
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE2DED0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                        ),
                        child: Text(
                          'TAMBAH',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25), // Jarak ke container di bawahnya

                // Container API Daerah yang Terhubung
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF2F5061),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Column(
                    children: [             
                      Text(
                        'API DAERAH YANG TELAH TERHUBUNG',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 5), // Jarak ke atas
                      Divider(color: Colors.white),
                      SizedBox(height: 5), // Jarak ke bawah
                      if (_namaDaerah != null && _namaDaerah!.isNotEmpty)
                        Text(
                          _namaDaerah!,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            color: Colors.white,
                          ),
                        )
                      else
                        Text(
                          'Belum ada daerah yang terhubung',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            color: Colors.white,
                          ),
                        ),
                      SizedBox(
                          height:
                              60), // Jarak dari tulisan terakhir ke "to be continued"
                      Text(
                        'to be continued',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),                                  
                    ],
                  ),         
                ),              
                SizedBox(height: 30), // Jarak ke bawah  

                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 110),
                  child: ElevatedButton(
                    onPressed: _logout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2F5061),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    ),
                    child: Text(
                      'KELUAR',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),  
        ),
      ),
    );
  }
}