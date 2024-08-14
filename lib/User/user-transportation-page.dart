import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nagarishakti/Database/database_transportasi.dart';

class UserTransportationPage extends StatefulWidget {
  const UserTransportationPage({super.key});

  @override
  _UserTransportationPageState createState() => _UserTransportationPageState();
}

class _UserTransportationPageState extends State<UserTransportationPage> {
  int showNewContent = 0;
  List<Transportasi> _transportations = [];

  @override
  void initState() {
    super.initState();
    _loadTransportationsFromDB();
  }

  Future<void> _loadTransportationsFromDB() async {
    final DatabaseTransportasi db = DatabaseTransportasi.instance;
    final List<Transportasi> transportations = await db.getTransportasi();
    setState(() {
      _transportations = transportations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3EFF1),
      body: _transportations.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildHeader(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (_transportations.isNotEmpty)
                          buildCarouselSlider(),
                        const SizedBox(height: 16),
                        if (_transportations.isNotEmpty)
                          buildTransportasiContent(_transportations[showNewContent]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFC4DFE2),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: CircleAvatar(
              backgroundColor: const Color(0xFFE2DED0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                'INFORMASI TRANSPORTASI',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
    );
  }

  Widget buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: false,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          setState(() {
            showNewContent = index;
          });
        },
      ),
      items: _transportations.map((transportation) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  showNewContent = _transportations.indexOf(transportation);
                });
              },
              child: Container(
                width: 250,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
    );
  }

  Widget buildTransportasiContent(Transportasi transportasi) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE2DED0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            transportasi.nama,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
              fontSize: 18,
              color: Color(0xFF173538),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            transportasi.deskripsi,
            style: const TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 14,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          buildInfoSection('Rute', transportasi.rute),
          buildInfoSection('Jam Operasional', transportasi.jamOperasional),
          buildInfoSection('Tarif', transportasi.tarif),
          buildInfoSection('Fasilitas', transportasi.fasilitas),
          buildInfoSection('Tambahan', transportasi.tambahan),
        ],
      ),
    );
  }

  Widget buildInfoSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
              fontSize: 16, // Adjust the font size if necessary
              color: Color(0xFF173538),
            ), 
          ),
          const SizedBox(height: 8), // Add some space between title and box
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Ubuntu',
                fontSize: 14,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
