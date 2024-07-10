import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  final List<String> imageList = [
    'assets/contoh-gambar.png',
    'assets/contoh-gambar.png',
    'assets/contoh-gambar.png',
    'assets/contoh-gambar.png',
    'assets/contoh-gambar.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3EFF1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
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
                        'BUDI WIJAYA',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu',
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), //
                  CircleAvatar(
                    radius: 22,
                    backgroundImage:
                        AssetImage('assets/user-home/profile-logo.png'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Carousel Slider
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
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
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
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
            SizedBox(height: 10),

            // Layanan Kependudukan
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              padding: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: Color(0xFF327178),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
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
                      color: Color(0xFFF8F6F3),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 30,
                            child: Image.asset('assets/user-home/id-card.png',
                                height: 30),
                          ),
                          title: Text(
                            'Pembuatan KTP dan KK',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: Text(
                            'Pembuatan KTP Baru dan Perbaruan Kartu Keluarga Baru',
                            style: TextStyle(fontFamily: 'Ubuntu'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Divider(height: 1),
                        ListTile(
                          leading: Container(
                            width: 30,
                            child: Image.asset(
                                'assets/user-home/registration-card.png',
                                height: 30),
                          ),
                          title: Text(
                            'Pembaruan Data Kependudukan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: Text(
                            'Untuk perpindahan domisili',
                            style: TextStyle(fontFamily: 'Ubuntu'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Divider(height: 1),
                        ListTile(
                          leading: Container(
                            width: 30,
                            child: Image.asset(
                                'assets/user-home/application-card.png',
                                height: 30),
                          ),
                          title: Text(
                            'Pendaftaran AKTA Kelahiran dan Kematian',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: Text(
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
            SizedBox(height: 10),

            // Pengaduan Masyarakat
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              padding: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: Color(0xFF327178),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
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
                      color: Color(0xFFF8F6F3),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 30,
                            child: Image.asset(
                                'assets/user-home/complaint-card.png',
                                height: 30),
                          ),
                          title: Text(
                            'Pengaduan Masyarakat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: Text(
                            'Tulis aduan Anda tentang Infrastruktur atau fasilitas lain kepada Pemerintah',
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
            SizedBox(height: 10),

            // Informasi Pariwisata
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              padding: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: Color(0xFF327178),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
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
                      color: Color(0xFFF8F6F3),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 30,
                            child: Image.asset(
                                'assets/user-home/destination-card.png',
                                height: 30),
                          ),
                          title: Text(
                            'Daftar Destinasi Wisata',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: Text(
                            'List Destinasi Wisata di daerah Anda!',
                            style: TextStyle(fontFamily: 'Ubuntu'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Divider(height: 1),
                        ListTile(
                          leading: Container(
                            width: 30,
                            child: Image.asset(
                                'assets/user-home/timeline-card.png',
                                height: 30),
                          ),
                          title: Text(
                            'Timeline Acara Dan Festival',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: Text(
                            'Lihat Acara dan Festival yang akan datang',
                            style: TextStyle(fontFamily: 'Ubuntu'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Divider(height: 1),
                        ListTile(
                          leading: Container(
                            width: 30,
                            child: Image.asset(
                                'assets/user-home/transportation-card.png',
                                height: 30),
                          ),
                          title: Text(
                            'Informasi Transportasi dan Akomodasi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          subtitle: Text(
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
            SizedBox(height: 10),

            // Informasi Publik
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              padding: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: Color(0xFF327178),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'INFORMASI PUBLIK',
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
                      color: Color(0xFFF8F6F3),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
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
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(4, (index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
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
                                        borderRadius: BorderRadius.vertical(
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
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Judul Berita $index',
                                          style: TextStyle(
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
                        Align(
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
                        SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFAAA79C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  minimumSize: Size(double.infinity, 50),
                                ),
                                child: Text(
                                  'Akses Dokumen Publik',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFAAA79C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  minimumSize: Size(double.infinity, 50),
                                ),
                                child: Text(
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
}
