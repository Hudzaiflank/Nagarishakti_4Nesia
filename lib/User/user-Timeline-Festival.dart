import 'package:flutter/material.dart';

class UserTimelineFestival extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4297A0), // Background color
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: 10, bottom: 20), // Adjusted to cover the status bar
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFE2DED0),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_back),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top:
                                        40), // Added padding to move the title down
                                child: Center(
                                  child: Text(
                                    'TIMELINE \nACARA & FESTIVAL',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    textAlign:
                                        TextAlign.center, // Center align text
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_pin, color: Colors.red),
                                  Text(
                                    'Kota Bekasi',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width:
                                40), // Placeholder for balance button and title
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari nama festival',
                    hintStyle: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF8E98A8),
                    ),
                    prefixIcon: Icon(Icons.search, color: Color(0xFF8E98A8)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10), // Adjusted to set height to 40px
                  ),
                ),
              ),
              SizedBox(
                  height:
                      22), // Adjusted height between search bar and containers below
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    buildEventContainer(
                      title: 'FESTIVAL SITU GEDE',
                      date: '04 Juli 2024',
                      location: 'Situ Rawa Gede, Rawalumbu',
                      description:
                          'Festival tahunan yang diadakan di Situ Rawa Gede untuk mempromosikan kebersihan dan potensi wisata. Acara ini melibatkan kegiatan seni budaya dan dialog interaktif.',
                      image: 'assets/contoh-gambar.png',
                    ),
                    SizedBox(height: 22), // Space between containers
                    buildEventContainer(
                      title: 'BAZAAR ETHNIC FOOD',
                      date: '6-7 Maret 2024',
                      location: 'Lapangan Plaza Pemkot Bekasi',
                      description:
                          'Menampilkan lomba makanan etnik, penampilan musik, pesona batik Bekasi, dan talkshow.',
                      image: 'assets/contoh-gambar.png',
                    ),
                    SizedBox(height: 22), // Space between containers
                    buildEventContainer(
                      title: 'FEST. BEDUG & DONDANG',
                      date: '21 Mei 2023',
                      location: 'Mustikajaya, Bekasi',
                      description:
                          'Festival tradisional yang menampilkan adu bedug dan dondang, sebuah kesenian khas daerah setempat.',
                      image: 'assets/contoh-gambar.png',
                    ),
                    SizedBox(height: 33), // Space below the last container
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildEventContainer({
    required String title,
    required String date,
    required String location,
    required String description,
    required String image,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFAAA79C),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(0), // Remove padding to fill the container
            decoration: BoxDecoration(
              color: Color(0xFF2F5061),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7), // Added border radius
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Image.asset(
                      image,
                      width: 118, // Increased width by 18px
                      height: 100, // Adjust height to fill the container
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis, // Add ellipsis
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.white, size: 14), // Change to white
                          SizedBox(width: 5),
                          Text(
                            date,
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_pin,
                              color: Colors.white, size: 14), // Change to white
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              location,
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                color: Colors.white,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis, // Add ellipsis
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.notifications,
                      color: Colors.white, size: 24), // Increased size
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deskripsi:',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.justify,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'informasi lebih lanjut',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        color: Color(0xFFCE7277),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFFCE7277),
                      size: 14, // Match the text size
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
