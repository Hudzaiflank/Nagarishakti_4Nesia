import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Profile/user-profile.dart';
import 'user-Timeline-Festival.dart';
import 'Destination/user-Destination-page.dart';
import 'user-transportation-page.dart';
import './Layanan-Kependudukan/Pembuatan-ktp-kk/user-ktp-page.dart';
import './Layanan-Kependudukan/Pembuatan-ktp-kk/user-kk-page.dart';
import './Layanan-Kependudukan/Pendaftaran-AktaLahir-kematian/Akta-lahir.dart';
import './Layanan-Kependudukan/Pendaftaran-AktaLahir-kematian/Surat-kematian.dart';
import './Layanan-Kependudukan/Pembaruan-data/perpindahan-kependudukan.dart';
import 'Informasi-publik/berita/news-page.dart';
import 'Pengaduan-Masyarakat/pengaduan-masyarakat.dart';
import 'Informasi-publik/Dokumen-publik/Public-Document.dart';
import 'Informasi-publik/Agenda-Pemerintah/Agenda-pemerintahan.dart';
import 'Dashboard-Status/Pengajuan-Dokumen/Pengajuan-Dokumen.dart';
import 'Dashboard-Status/Pengajuan-Keluhan/Pengajuan-Keluhan.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final List<String> imageList = [
    'assets/contoh-gambar.png',
    'assets/contoh-gambar.png',
    'assets/contoh-gambar.png',
    'assets/contoh-gambar.png',
    'assets/contoh-gambar.png',
  ];

  bool isLoggedIn = false;
  String username = '';

  @override
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  void checkUserLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? loggedInUsername = prefs.getString('loggedInUsername');

    setState(() {
      isLoggedIn = loggedIn;
      username = loggedInUsername ?? 'Guest';
    });
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
                          fontFamily: 'Ubuntu',
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      if (!isLoggedIn) {
                        Navigator.pushReplacementNamed(context, '/register');
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditUserProfile()),
                        );
                      }
                    },
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundImage:
                          AssetImage('assets/user-home/profile-logo.png'),
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
                      color: const Color(0xFFFCFCFA),
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.all(0),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF4297A0),
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Pilih yang Akan Diajukan',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Ubuntu',
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserKtpPage()),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFCFCFA),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'KTP',
                                                style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 23,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 5),
                                              const Text(
                                                'Kartu Tanda Penduduk',
                                                style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 14,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF233C49),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 2.0),
                                                      child: RichText(
                                                        text: const TextSpan(
                                                          text: 'Siapkan',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                      child: Text(
                                                        '• Kartu Keluarga',
                                                        style: TextStyle(
                                                          fontFamily: 'Ubuntu',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                      child: Text(
                                                        '• Surat pengantar (jika baru)',
                                                        style: TextStyle(
                                                          fontFamily: 'Ubuntu',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserKkPage()),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFCFCFA),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'KK',
                                                style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 23,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 5),
                                              const Text(
                                                'Kartu Keluarga',
                                                style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 14,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF233C49),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 2.0),
                                                      child: RichText(
                                                        text: const TextSpan(
                                                          text: 'Siapkan',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                      child: Text(
                                                        '• Isian F-1.02 (unduh di bawah)',
                                                        style: TextStyle(
                                                          fontFamily: 'Ubuntu',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                      child: Text(
                                                        '• Kartu Keluarga lama',
                                                        style: TextStyle(
                                                          fontFamily: 'Ubuntu',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                      child: Text(
                                                        '• KTP-el',
                                                        style: TextStyle(
                                                          fontFamily: 'Ubuntu',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                      child: Text(
                                                        '• Surat kehilangan (jika hilang)',
                                                        style: TextStyle(
                                                          fontFamily: 'Ubuntu',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                      child: Text(
                                                        '• Kartu izin tinggal tetap (OA)',
                                                        style: TextStyle(
                                                          fontFamily: 'Ubuntu',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          // nanti handle download pdf nya disini borr
                                        },
                                        icon: SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset(
                                            'assets/download-icon.png',
                                            color: const Color(0xFF233C49),
                                          ),
                                        ),
                                        label: const Text(
                                          'Unduh Formulir F-1.02',
                                          style: TextStyle(
                                              color: Color(0xFF233C49)),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFFAAA79C),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            side: const BorderSide(
                                                color: Colors.white, width: 2),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: SizedBox(
                            width: 30,
                            child: Image.asset(
                              'assets/user-home/registration-card.png',
                              height: 30,
                            ),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PerpindahanKependudukan(),
                              ),
                            );
                          },
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.all(0),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF4297A0),
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Pilih yang Akan Diajukan',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Ubuntu',
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AktaLahir()),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFCFCFA),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0),
                                                child: Text(
                                                  'Akta Kelahiran',
                                                  style: TextStyle(
                                                    fontFamily: 'Ubuntu',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 23,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF233C49),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                      child: Text(
                                                        'Siapkan',
                                                        style: TextStyle(
                                                          fontFamily: 'Ubuntu',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          '• ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'surat keterangan kelahiran dari RS/Puskesmas/dokter/bidan',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          '• ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'Buku Nikah Orang Tua atau SPTJM kebenaran sebagai pasangan suami istri dengan 2 saksi',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          '• ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'KK asli orang tua',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          '• ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'KTP orang tua (ayah dan ibu)',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .justify,
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
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SuratKematian()),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFCFCFA),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0),
                                                child: Text(
                                                  'SURAT KEMATIAN',
                                                  style: TextStyle(
                                                    fontFamily: 'Ubuntu',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 23,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF233C49),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                      child: Text(
                                                        'Siapkan',
                                                        style: TextStyle(
                                                          fontFamily: 'Ubuntu',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          '• ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'Surat keterangan Kematian dari Dokter jika meninggal di Rumah Sakit, atau dari Kepala Desa/Kelurahan jika meninggal di Rumah',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          '• ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'KTP pemohon / pelapor kematian',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          '• ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'KTP yang meninggal/surat keterangan domisili (jika tidak ada KTP)',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          '• ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Ubuntu',
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'KK asli (masih dengan almarhum)',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .justify,
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
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
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
                            'Tulis aduan Anda tentang Infrastruktur atau fasilitas lain kepada Pemerintah',
                            style: TextStyle(fontFamily: 'Ubuntu'),
                            textAlign: TextAlign.justify,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PengaduanMasyarakat(),
                              ),
                            );
                          },
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDestinationPage()),
                            );
                          },
                          child: ListTile(
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
                        ),
                        const Divider(height: 1),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserTimelineFestival()),
                            );
                          },
                          child: ListTile(
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
                        ),
                        const Divider(height: 1),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserTransportationPage()),
                            );
                          },
                          child: ListTile(
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
                              'Informasi tentang sarana transportasi dan akomodasi di daerah Anda',
                              style: TextStyle(fontFamily: 'Ubuntu'),
                              textAlign: TextAlign.justify,
                            ),
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
                        GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman news-page.dart saat diklik
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsPage()),
                            );
                          },
                          child: Align(
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
                        ),
                        const SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PublicDocumentPage(),
                                    ),
                                  );
                                },
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AgendaPemerintahan()),
                                  );
                                },
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
                            const SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // DASHBOARD DAN STATUS
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
                      'DASHBOARD DAN STATUS',
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PengajuanDokumen()),
                            );
                          },
                          child: ListTile(
                            leading: SizedBox(
                              width: 30,
                              child: Image.asset(
                                  'assets/user-home/Status-Document.png',
                                  height: 30),
                            ),
                            title: const Text(
                              'Status Pengajuan Dokumen',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            subtitle: const Text(
                              'Lihat statistik pengajuan dokumen Anda',
                              style: TextStyle(fontFamily: 'Ubuntu'),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        const Divider(height: 1),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PengajuanKeluhan()),
                            );
                          },
                          child: ListTile(
                            leading: SizedBox(
                              width: 30,
                              child: Image.asset(
                                  'assets/user-home/Complaint-status.png',
                                  height: 30),
                            ),
                            title: const Text(
                              'Status Pengaduan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            subtitle: const Text(
                              'Lihat statistik pengajuan aduan ',
                              style: TextStyle(fontFamily: 'Ubuntu'),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupItem(BuildContext context, String title, String subtitle,
      List<String> items, Widget destinationPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
            Center(
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
            const SizedBox(height: 10),
            for (var item in items)
              Text(
                '• $item',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Ubuntu',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
