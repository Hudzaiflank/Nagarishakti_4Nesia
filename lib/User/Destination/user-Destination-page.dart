import 'package:flutter/material.dart';
import 'user-DetailDestination-page.dart';

class UserDestinationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: Container(
          padding: EdgeInsets.only(top: 35),
          decoration: BoxDecoration(
            color: Color(0xFF3AB3B1),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(7.0)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFE2DED0),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'DESTINASI PARIWISATA',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_pin, size: 16, color: Color(0xFFA53525)),
                  SizedBox(width: 4),
                  Text(
                    'Kota Bekasi',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 16,
                      color: Color(0xFFCDC2AE),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                filled: true,
                fillColor: Color(0xFFE2DED0),
                hintText: 'Cari destinasi wisata',
                hintStyle: TextStyle(
                    color: Color(0xFF8E98A8),
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Ubuntu'),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                  child: Icon(Icons.search, color: Color(0xFF8E98A8)),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                destinationItem(
                  context,
                  imagePath: 'assets/contoh-gambar.png',
                  title: 'CURUG PARIGI',
                  location: 'Jl. Pangkalan 5, Bantar Gebang',
                  savedBy: 'Disimpan oleh 372 orang',
                  backgroundColor: Color(0xFF8C8C8C),
                ),
                destinationItem(
                  context,
                  imagePath: 'assets/contoh-gambar.png',
                  title: 'DELTAMAS HILL',
                  location: 'Hegarmukti, Cikarang Pusat',
                  savedBy: 'Disimpan oleh 124 orang',
                  backgroundColor: Color(0xFF5D5855),
                ),
                destinationItem(
                  context,
                  imagePath: 'assets/contoh-gambar.png',
                  title: 'DANAU MARAKASH',
                  location: 'Marakash, Kebalen, Babelan',
                  savedBy: 'Disimpan oleh 256 orang',
                  backgroundColor: Color(0xFF62B8B1),
                ),
                destinationItem(
                  context,
                  imagePath: 'assets/contoh-gambar.png',
                  title: 'HUTAN KOTA',
                  location: 'Jl. Jend. Ahmad Yani, Bekasi',
                  savedBy: 'Disimpan oleh 398 orang',
                  backgroundColor: Color(0xFF60A39C),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget destinationItem(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String location,
    required String savedBy,
    required Color backgroundColor,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserDetailDestinationPage()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(7.0)), // ini biar semua 7px si pinggirnya
                child: Image.asset(
                  imagePath,
                  height: 120,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_pin,
                              size: 16, color: Colors.white),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              location,
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Ubuntu'),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.bookmark,
                              size: 16, color: Colors.white), // Added save icon
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              savedBy,
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Ubuntu'),
                              overflow:
                                  TextOverflow.ellipsis, // Handle text overflow
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon:
                    Icon(Icons.bookmark_border, color: Colors.white, size: 16),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}