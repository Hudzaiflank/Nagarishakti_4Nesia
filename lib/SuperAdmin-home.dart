import 'package:flutter/material.dart';
import 'database_integrasi.dart';

class SuperAdminHome extends StatefulWidget {
  @override
  _SuperAdminHomeState createState() => _SuperAdminHomeState();
}

class _SuperAdminHomeState extends State<SuperAdminHome> {
  final List<String> cities = [
    'Kota Sukabumi',
    'Kabupaten Bandung',
  ];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _linkApiController = TextEditingController();
  String? _selectedCity;

  void _addIntegration() async {
    // Manual validation
    if (_linkApiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a link API')),
      );
      return;
    }

    if (_selectedCity == null || _selectedCity!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a city')),
      );
      return;
    }

    final newIntegration = Integration(
      linkAPI: _linkApiController.text,
      namaDaerah: _selectedCity!,
    );

    final dbIntegrasi = DatabaseIntegration.instance;
    await dbIntegrasi.insertIntegration(newIntegration);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3EFF1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                    TextField(
                      controller: _linkApiController,
                      decoration: InputDecoration(
                        hintText: 'link api',
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
                    DropdownButtonFormField<String>(
                      items: cities.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {},
                      decoration: InputDecoration(
                        hintText: 'Pilih Daerah',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a city';
                        }
                        return null;
                      },  
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
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
                    ...cities.map((city) {
                      return Text(
                        city,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
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
            ],
          ),
        ),
      ),
    );
  }
}
