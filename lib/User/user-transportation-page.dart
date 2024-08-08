import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '/Database/database_transportasi.dart';

class UserTransportationPage extends StatefulWidget {
  const UserTransportationPage({super.key});

  @override
  _UserTransportationPageState createState() => _UserTransportationPageState();
}

class _UserTransportationPageState extends State<UserTransportationPage> {
  bool showNewContent = false;

  @override
  Widget build(BuildContext context) {
    List<Transportasi> transportations = [
      Transportasi(
        id: 1,
        gambar: 'assets/contoh-gambar.png',
        nama: 'Angkutan Kota (Angkot)',
        deskripsi: 'Angkutan kota (angkot) adalah salah satu moda transportasi utama di Bekasi yang menyediakan layanan transportasi yang luas dan menjangkau berbagai area di kota. Berikut adalah beberapa informasi rinci mengenai angkutan kota di Bekasi:',
        rute: 'K01: Terminal Bekasi - Pondok Gede - Pasar Rebo\nK02: Terminal Bekasi - Bulak Kapal - Cikarang\nK03: Harapan Indah - Bekasi Timur\nK04: Terminal Bekasi - Cibitung - Ujung Harapan\nK05: Summarecon Bekasi - Kalimalang - Jatiasih',
        jamOperasional: 'Angkot di Bekasi beroperasi dari pagi hingga malam, dengan jam operasional yang bervariasi tergantung pada rute dan hari.\nBiasanya: 05.00 WIB s.d. 22.00 WIB',
        tarif: 'Bervariasi tergantung pada jarak perjalanan, biasanya berkisar antara Rp 4.000 hingga Rp 10.000 per perjalanan.',
        fasilitas: 'Tempat Duduk: Kapasitas tempat duduk bervariasi, biasanya mampu menampung sekitar 10-12 penumpang.\nKeamanan Angkot di Bekasi: biasanya sederhana, tapi ada beberapa angkot yang sudah menyediakan AC dan beberapa fasilitas tambahan.',
        tambahan: '• Jangkauan Luas: Angkot menjangkau berbagai wilayah di Bekasi, termasuk area-area yang mungkin tidak dilalui oleh transportasi umum lain.\n• Fleksibilitas: Angkot lebih fleksibel dalam mengatur rute dan waktu operasionalnya, memberikan fleksibilitas bagi penumpang.\n• Biaya Relatif Rendah: Angkot umumnya lebih terjangkau dibandingkan dengan beberapa moda transportasi lainnya, sehingga mengurangi pengeluaran bagi pengguna yang rutin.',
      ),
      Transportasi(
        id: 2,
        gambar: 'assets/icon.png',
        nama: 'Trans Patriot Bekasi (BISKITA)',
        deskripsi: 'Trans Patriot adalah layanan transportasi umum bus di Kota Bekasi yang beroperasi sejak Maret 2024. Inisiatif ini adalah bagian dari upaya pemerintah untuk meningkatkan kualitas transportasi umum dan mengurangi kemacetan di kota. BISKITA menjadi pilihan ideal bagi Anda yang ingin berkeliling kota dengan mudah.',
        rute: 'Rute 1: Summarecon Mall Bekasi - Vida Bantar Gebang\nRute kembali: Pasar Alam Vida - Summarecon Mall Bekasi',
        jamOperasional: 'Setiap hari dari pukul 05.00 hingga 21.00 WIB.\nHeadway (Waktu Tunggu): Sekitar 10 menit antar bus, memastikan frekuensi yang tinggi dan mengurangi waktu tunggu penumpang.',
        tarif: 'Selama masa uji coba, layanan ini gratis. Penumpang hanya perlu melakukan tap kartu pembayaran elektronik seperti E-money, Flazz, atau Brizzi di pintu masuk bus.',
        fasilitas: 'Fasilitas di Dalam Bus:\n• AC untuk kenyamanan penumpang.\n• Kursi yang nyaman dan cukup untuk penumpang.\n• Ruang untuk berdiri dengan pegangan tangan yang aman.\n• Informasi rute dan pemberhentian melalui layar di dalam bus.\nFasilitas di Halte:\n• Tempat duduk yang cukup nyaman.\n• Informasi rute dan bus yang jelas.\n• Pengawasan keamanan melalui CCTV.',
        tambahan: 'KRL Commuter Line: Terhubung di Stasiun Bekasi dan Stasiun Kranji.\nLRT: Terhubung di Stasiun LRT Bekasi Barat, memudahkan akses ke wilayah Jabodetabek.\nAngkot dan Bus Kota: Menghubungkan berbagai titik di dalam dan luar Bekasi.',
      ),
    ];

    return Scaffold(
      backgroundColor: Color(0xFFE3EFF1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 16.0),
              decoration: BoxDecoration(
                color: Color(0xFFC4DFE2),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFE2DED0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 60),
                      Text(
                        'INFORMASI TRANSPORTASI',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          Text(
                            'Kota Bekasi',
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          showNewContent = index == 1;
                        });
                      },
                    ),
                    items: transportations.map((transportation) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                showNewContent = transportation.id == 2;
                              });
                            },
                            child: Container(
                              width: 250,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7.0),
                                child: Image.asset(transportation.gambar, fit: BoxFit.cover),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  showNewContent
                      ? buildTransportationInfo(transportations[1])
                      : buildTransportationInfo(transportations[0]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTransportationInfo(Transportasi transportation) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFE2DED0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            transportation.nama,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
              fontSize: 18,
              color: Color(0xFF2F5061),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            transportation.deskripsi,
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 14,
              height: 1.5,
              color: Colors.black,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 16),
          buildInfoSection('Rute', transportation.rute, boldText: ['K01:', 'K02:', 'K03:', 'K04:', 'K05:', 'Rute 1:', 'Rute kembali:'], withDecoration: true), 
          buildInfoSection('Jam Operasional', transportation.jamOperasional, boldText: ['Biasanya:', 'Setiap hari dari pukul 05.00 hingga 21.00 WIB.', 'Headway (Waktu Tunggu):'], withDecoration: true),
          buildInfoSection('Tarif', transportation.tarif, boldText: ['Bervariasi tergantung pada jarak perjalanan,', 'Selama masa uji coba, layanan ini gratis.'], withDecoration: true),
          buildInfoSection('Fasilitas', transportation.fasilitas, boldText: ['Tempat Duduk:', 'Keamanan Angkot di Bekasi:', 'Fasilitas di Dalam Bus:', 'Fasilitas di Halte:'], withDecoration: true),
          buildInfoSection('Kelebihan', transportation.tambahan, boldText: ['• Jangkauan Luas:', '• Fleksibilitas:', '• Biaya Relatif Rendah:', 'KRL Commuter Line:', 'LRT:', 'Angkot dan Bus Kota:'], withDecoration: true),
        ],
      ),
    );
  }

  Widget buildInfoSection(String title, String content, {List<String> boldText = const [], bool withDecoration = false}) {
    List<InlineSpan> textSpans = [];
    
    content.split('\n').forEach((line) {
      // Split the line into segments based on boldText keywords
      List<TextSpan> lineSpans = [];
      int start = 0;

      // Iterate through each keyword to apply bold styling
      boldText.forEach((keyword) {
        final index = line.indexOf(keyword, start);
        if (index != -1) {
          // Add text before the keyword as normal text
          if (index > start) {
            lineSpans.add(TextSpan(
              text: line.substring(start, index),
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Ubuntu',
                fontSize: 14,
                color: Colors.black,
              ),
            ));
          }
          // Add the keyword as bold text
          lineSpans.add(TextSpan(
            text: line.substring(index, index + keyword.length),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
              fontSize: 14,
              color: Colors.black,
            ),
          ));
          start = index + keyword.length;
        }
      });

      // Add any remaining text after the last keyword
      if (start < line.length) {
        lineSpans.add(TextSpan(
          text: line.substring(start),
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Ubuntu',
            fontSize: 14,
            color: Colors.black,
          ),
        ));
      }

      // Add lineSpans to textSpans, ensuring new lines are handled correctly
      textSpans.add(TextSpan(
        children: lineSpans,
      ));
      textSpans.add(TextSpan(text: '\n')); // Ensure each line is followed by a newline
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Ubuntu',
            fontSize: 16,
            color: Color(0xFF2F5061),
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: withDecoration ? BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ) : null,
          child: RichText(
            text: TextSpan(
              children: textSpans,
            ),
          ),
        ),
      ],
    );
  }
}
