import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UserTransportationPage extends StatefulWidget {
  @override
  _UserTransportationPageState createState() => _UserTransportationPageState();
}

class _UserTransportationPageState extends State<UserTransportationPage> {
  bool showNewContent = false;

  @override
  Widget build(BuildContext context) {
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
                    ),
                    items: [
                      'assets/contoh-gambar.png',
                      'assets/icon.png',
                      'assets/contoh-gambar.png',
                      'assets/contoh-gambar.png',
                      'assets/contoh-gambar.png',
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                showNewContent = i == 'assets/icon.png';
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
                                child: Image.asset(i, fit: BoxFit.cover),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  showNewContent
                      ? Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFE2DED0),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Angkutan Kota (Angkot)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Ubuntu',
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Angkutan kota (angkot) adalah salah satu moda transportasi utama di Bekasi yang menyediakan layanan transportasi yang luas dan menjangkau berbagai area di kota. Berikut adalah beberapa informasi rinci mengenai angkutan kota di Bekasi:',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 16),
                              buildInfoSection(
                                'Rute',
                                'K01: Terminal Bekasi - Pondok Gede - Pasar Rebo\n'
                                    'K02: Terminal Bekasi - Bulak Kapal - Cikarang\n'
                                    'K03: Harapan Indah - Bekasi Timur\n'
                                    'K04: Terminal Bekasi - Cibitung - Ujung Harapan\n'
                                    'K05: Summarecon Bekasi - Kalimalang - Jatiasih',
                                boldText: [
                                  'K01:',
                                  'K02:',
                                  'K03:',
                                  'K04:',
                                  'K05:'
                                ],
                              ),
                              buildInfoSection(
                                'Jam Operasional',
                                'Angkot di Bekasi beroperasi dari pagi hingga malam, dengan jam operasional yang bervariasi tergantung pada rute dan hari.\n'
                                    'Biasanya: 05.00 WIB s.d. 22.00 WIB',
                                boldText: ['Biasanya:'],
                              ),
                              buildInfoSection(
                                'Tarif',
                                'Bervariasi tergantung pada jarak perjalanan, biasanya berkisar antara Rp 4.000 hingga Rp 10.000 per perjalanan.',
                                boldText: [
                                  'Bervariasi tergantung pada jarak perjalanan,'
                                ],
                              ),
                              buildInfoSection(
                                'Fasilitas',
                                'Tempat Duduk: Kapasitas tempat duduk bervariasi, biasanya mampu menampung sekitar 10-12 penumpang.\n'
                                    'Keamanan Angkot di Bekasi: biasanya sederhana, tapi ada beberapa angkot yang sudah menyediakan AC dan beberapa fasilitas tambahan.',
                                boldText: [
                                  'Tempat Duduk:',
                                  'Keamanan Angkot di Bekasi:'
                                ],
                              ),
                              buildInfoSection(
                                'Kelebihan',
                                '• Jangkauan Luas: Angkot menjangkau berbagai wilayah di Bekasi, termasuk area-area yang mungkin tidak dilalui oleh transportasi umum lain.\n'
                                    '• Fleksibilitas: Angkot lebih fleksibel dalam mengatur rute dan waktu operasionalnya, memberikan fleksibilitas bagi penumpang.\n'
                                    '• Biaya Relatif Rendah: Angkot umumnya lebih terjangkau dibandingkan dengan beberapa moda transportasi lainnya, sehingga mengurangi pengeluaran bagi pengguna yang rutin.',
                                boldText: [
                                  '• Jangkauan Luas:',
                                  '• Fleksibilitas:',
                                  '• Biaya Relatif Rendah:'
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFE2DED0),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Trans Patriot Bekasi (BISKITA)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Ubuntu',
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Trans Patriot adalah layanan transportasi umum bus di Kota Bekasi yang beroperasi sejak Maret 2024. '
                                'Inisiatif ini adalah bagian dari upaya pemerintah untuk meningkatkan kualitas transportasi umum '
                                'dan mengurangi kemacetan di kota. BISKITA menjadi pilihan ideal bagi Anda yang ingin berkeliling kota dengan mudah.',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 16),
                              buildInfoSection(
                                'Rute',
                                'Rute 1: Summarecon Mall Bekasi - Vida Bantar Gebang\n'
                                    'Rute kembali: Pasar Alam Vida - Summarecon Mall Bekasi',
                                boldText: ['Rute 1:', 'Rute kembali:'],
                              ),
                              buildInfoSection(
                                'Jam Operasional',
                                'Setiap hari dari pukul 05.00 hingga 21.00 WIB.\n'
                                    'Headway (Waktu Tunggu): Sekitar 10 menit antar bus, memastikan frekuensi yang tinggi '
                                    'dan mengurangi waktu tunggu penumpang.',
                                boldText: [
                                  'Setiap hari dari pukul 05.00 hingga 21.00 WIB.',
                                  'Headway (Waktu Tunggu):'
                                ],
                              ),
                              buildInfoSection(
                                'Tarif',
                                'Selama masa uji coba, layanan ini gratis. '
                                    'Penumpang hanya perlu melakukan tap kartu pembayaran elektronik seperti E-money, Flazz, '
                                    'atau Brizzi di pintu masuk bus.',
                                boldText: [
                                  'Selama masa uji coba, layanan ini gratis.'
                                ],
                              ),
                              buildInfoSection(
                                'Fasilitas di Dalam Bus:',
                                '• AC untuk kenyamanan penumpang.\n'
                                    '• Kursi yang nyaman dan cukup untuk penumpang.\n'
                                    '• Ruang untuk berdiri dengan pegangan tangan yang aman.\n'
                                    '• Informasi rute dan pemberhentian melalui layar di dalam bus.\n\n'
                                    'Fasilitas di Halte:\n'
                                    '• Tempat duduk yang cukup nyaman.\n'
                                    '• Informasi rute dan bus yang jelas.\n'
                                    '• Pengawasan keamanan melalui CCTV.',
                                boldText: [
                                  'Fasilitas di Dalam Bus:',
                                  'Fasilitas di Halte:'
                                ],
                              ),
                              buildInfoSection(
                                'Konektivitas',
                                'KRL Commuter Line: Terhubung di Stasiun Bekasi dan Stasiun Kranji.\n'
                                    'LRT: Terhubung di Stasiun LRT Bekasi Barat, memudahkan akses ke wilayah Jabodetabek.\n'
                                    'Angkot dan Bus Kota: Menghubungkan berbagai titik di dalam dan luar Bekasi.',
                                boldText: [
                                  'KRL Commuter Line:',
                                  'LRT:',
                                  'Angkot dan Bus Kota:'
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

  Widget buildInfoSection(String title, String content,
      {List<String>? boldText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(top: 16.0),
            decoration: BoxDecoration(
              color: Color(0xFFF6F5F0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: RichText(
              text: TextSpan(
                children: _buildTextSpans(content, boldText),
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 14,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Positioned(
            left: 16,
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Color(0xFF2F5061),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildTextSpans(String content, List<String>? boldText) {
    List<TextSpan> spans = [];
    List<String> parts = content.split('\n');
    for (String part in parts) {
      if (boldText != null) {
        bool isBold = false;
        for (String bold in boldText) {
          if (part.contains(bold)) {
            spans.add(TextSpan(
              text: bold,
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
            spans.add(TextSpan(
              text: part.replaceFirst(bold, ''),
            ));
            spans.add(TextSpan(text: '\n'));
            isBold = true;
            break;
          }
        }
        if (!isBold) {
          spans.add(TextSpan(text: part));
          spans.add(TextSpan(text: '\n'));
        }
      } else {
        spans.add(TextSpan(text: part));
        spans.add(TextSpan(text: '\n'));
      }
    }
    return spans;
  }

  List<InlineSpan> _buildCustomBulletList(List<String> items) {
    return items
        .map((item) => WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("• "),
                    Expanded(
                      child: Text(item,
                          style: TextStyle(fontSize: 14, height: 1.5)),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }
}
