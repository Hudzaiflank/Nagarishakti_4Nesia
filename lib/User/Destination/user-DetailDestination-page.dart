import 'package:flutter/material.dart';

class UserDetailDestinationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press here, if needed
        return true; // Return true if the route can be popped
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/contoh-gambar.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 40.0,
              left: 16.0,
              child: CircleAvatar(
                backgroundColor: Color(0xFFE2DED0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 300.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFCFCFA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'CURUG PARIGI',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          Icon(
                            Icons.bookmark_border,
                            color: Color(0xFF979797),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 24,
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              'Jl. Pangkalan 5, Cikiwul, Bantargebang Bekasi',
                              style: TextStyle(
                                  color: Colors.grey, fontFamily: 'Ubuntu'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Deskripsi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu',
                          color: Color(0xFF285B60),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Curug Parigi sering disebut sebagai mini Niagara karena bentuknya yang melengkung. Tempat ini menawarkan suasana sejuk dan pemandangan alam yang indah, cocok untuk wisata alam dan fotografi.',
                        style:
                            TextStyle(color: Colors.grey, fontFamily: 'Ubuntu'),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Gambar dan Peta Wisata',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu',
                          color: Color(0xFF285B60),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.0),
                              width: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset('assets/contoh-gambar.png'),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Fasilitas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu',
                          color: Color(0xFF285B60),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 11.0, horizontal: 7.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F5F0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Ubuntu',
                                height: 1.7),
                            children: [
                              TextSpan(
                                text: '• ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'Area Parkir: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    'Tersedia lahan parkir sederhana untuk kendaraan pribadi.\n',
                              ),
                              TextSpan(
                                text: '• ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'Kuliner: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    'Meskipun pilihannya terbatas, pengunjung dapat menikmati makanan ringan yang dijual di warung sekitar air terjun.\n',
                              ),
                              TextSpan(
                                text: '• ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'Toilet Umum: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    'Ada fasilitas toilet umum yang bisa digunakan pengunjung.',
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Harga Tiket',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu',
                          color: Color(0xFF285B60),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 11.0, horizontal: 7.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F5F0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        width: double.infinity,
                        child: Text(
                          'Gratis',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ubuntu',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}