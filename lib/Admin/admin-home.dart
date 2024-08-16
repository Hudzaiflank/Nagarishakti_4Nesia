import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Profile/admin-profile.dart';
import '/Database/database_admin.dart'; 
import 'dart:io';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final List<String> imageList = [
    'assets/contoh-gambar.png',
    'assets/contoh-gambar.png',
    'assets/contoh-gambar.png',
    'assets/contoh-gambar.png',
    'assets/contoh-gambar.png',
  ];

  String _gambar = '';

  bool isLoggedIn = false;
  String username = '';

  @override
  void initState() {
    super.initState();
    checkAdminLoginStatus();
    _loadAdminInfo();
  }

  void checkAdminLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? loggedInUsername = prefs.getString('loggedInUsername');

    setState(() {
      isLoggedIn = loggedIn;
      username = loggedInUsername ?? 'Admin';
    });
  }

  Future<void> _loadAdminInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('loggedInUsername') ?? '';

    if (username.isNotEmpty) {
      final dbAdmin = DatabaseAdmin.instance;
      final registersAdmin = await dbAdmin.getRegistersAdmin(); // Fetch all registers

      // Mencari user berdasarkan username
      final admin = registersAdmin.firstWhere(
        (registerAdmin) => registerAdmin.username == username,
        orElse: () => RegisterAdmin(
          username: 'N/A',
          password: 'N/A',
          gambar: 'assets/user-home/admin-profile.png',
          namaInstansi: 'N/A',
          alamatInstansi: 'N/A',
          noTelepon: 0,
          email: 'N/A',
        ),
      );

      setState(() {
        _gambar = admin.gambar;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3EFF1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: const BoxDecoration(
                color: Color(0xFF4297A0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/user-home/logo-icon.png', height: 44),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), //
                  GestureDetector(
                    onTap: () {
                      if (!isLoggedIn) {
                        Navigator.pushReplacementNamed(context, '/login');
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditAdminProfile()),
                        );
                      }
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: _getBackgroundImage(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Carousel Slider
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: imageList.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),

            // Layanan Kependudukan
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              padding: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: const Color(0xFF327178),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      'LAYANAN KEPENDUDUKAN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F6F3),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: SizedBox(
                            width: 30,
                            child: Image.asset('assets/user-home/id-card.png',
                                height: 30),
                          ),
                          title: const Text(
                            'Pembuatan KTP dan KK',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: const Text(
                            'Pembuatan KTP Baru dan Perbaruan Kartu Keluarga Baru',
                            style: TextStyle(fontFamily: 'Ubuntu'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: SizedBox(
                            width: 30,
                            child: Image.asset(
                                'assets/user-home/registration-card.png',
                                height: 30),
                          ),
                          title: const Text(
                            'Pembaruan Data Kependudukan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: const Text(
                            'Untuk perpindahan domisili',
                            style: TextStyle(fontFamily: 'Ubuntu'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: SizedBox(
                            width: 30,
                            child: Image.asset(
                                'assets/user-home/application-card.png',
                                height: 30),
                          ),
                          title: const Text(
                            'Pendaftaran AKTA Kelahiran dan Kematian',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: const Text(
                            'Untuk membuat surat kelahiran dan kematian',
                            style: TextStyle(fontFamily: 'Ubuntu'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Pengaduan Masyarakat
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              padding: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: const Color(0xFF327178),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'PENGADUAN MASYARAKAT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F6F3),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: SizedBox(
                            width: 30,
                            child: Image.asset(
                                'assets/user-home/complaint-card.png',
                                height: 30),
                          ),
                          title: const Text(
                            'Pengaduan Masyarakat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: const Text(
                            'Lihat semua data aduan dari masyarakat terhadap pemerintah daerah Anda!',
                            style: TextStyle(fontFamily: 'Ubuntu'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Informasi Pariwisata
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              padding: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: const Color(0xFF327178),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'INFORMASI PARIWISATA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F6F3),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: SizedBox(
                            width: 30,
                            child: Image.asset(
                                'assets/user-home/destination-card.png',
                                height: 30),
                          ),
                          title: const Text(
                            'Daftar Destinasi Wisata',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: const Text(
                            'List Destinasi Wisata di daerah Anda!',
                            style: TextStyle(fontFamily: 'Ubuntu'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: SizedBox(
                            width: 30,
                            child: Image.asset(
                                'assets/user-home/timeline-card.png',
                                height: 30),
                          ),
                          title: const Text(
                            'Timeline Acara Dan Festival',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: const Text(
                            'Lihat Acara dan Festival yang akan datang',
                            style: TextStyle(fontFamily: 'Ubuntu'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: SizedBox(
                            width: 30,
                            child: Image.asset(
                                'assets/user-home/transportation-card.png',
                                height: 30),
                          ),
                          title: const Text(
                            'Informasi Transportasi dan Akomodasi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: const Text(
                            'Temukan Transportasi yang tepat ke Tempat Wisata tujuan!',
                            style: TextStyle(fontFamily: 'Ubuntu'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Informasi Publik
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              padding: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: const Color(0xFF327178),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'INFORMASI PUBLIK',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F6F3),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Baca Berita Terkini di Daerah Anda',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(4, (index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(7.0),
                                        ),
                                        child: Image.asset(
                                          'assets/contoh-gambar.png',
                                          height: 100,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Judul Berita $index',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Ubuntu',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Text(
                              'Baca selengkapnya',
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFAAA79C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: const Text(
                                  'Akses Dokumen Publik',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFAAA79C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: const Text(
                                  'Agenda Pemerintah Daerah',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _getBackgroundImage() {
    if (_gambar.isNotEmpty && File(_gambar).existsSync()) {
      return FileImage(File(_gambar));
    } else {
      return const AssetImage('assets/user-home/admin-profile.png');
    }
  }
}
