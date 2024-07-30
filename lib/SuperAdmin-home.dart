import 'package:flutter/material.dart';
import '/Database/database_integrasi.dart';

class SuperAdminHome extends StatefulWidget {
  const SuperAdminHome({super.key});

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
        const SnackBar(content: Text('Please enter a link API')),
      );
      return;
    }

    if (_selectedCity == null || _selectedCity!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a city')),
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
      backgroundColor: const Color(0xFFE3EFF1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Judul
              const Text(
                'HALO SUPER ADMIN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 25), // Jarak ke container di bawahnya

              // Container Integrasi Layanan Daerah
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF4297A0),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'INTEGRASI LAYANAN DAERAH',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 15), // Jarak ke container di bawahnya
                    Container(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2DED0),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          const Center(
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
                          const SizedBox(height: 15),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: RichText(
                              text: const TextSpan(
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
                          const SizedBox(height: 10),
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
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
                                  padding: EdgeInsets.only(bottom: 5.0),
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
                                  padding: EdgeInsets.only(bottom: 5.0),
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
                                  padding: EdgeInsets.only(bottom: 5.0),
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
                                  padding: EdgeInsets.only(bottom: 5.0),
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
                                  padding: EdgeInsets.only(bottom: 5.0),
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
                                  padding: EdgeInsets.only(bottom: 5.0),
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
                                  padding: EdgeInsets.only(bottom: 5.0),
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
                    const SizedBox(height: 20),
                    const Text(
                      'INPUT API',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _linkApiController,
                      decoration: InputDecoration(
                        hintText: 'link api',
                        hintStyle: const TextStyle(
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
                    const SizedBox(height: 20),
                    const Text(
                      'DAERAH',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                        hintStyle: const TextStyle(color: Colors.black),
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
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE2DED0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      ),
                      child: const Text(
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
              const SizedBox(height: 25), // Jarak ke container di bawahnya

              // Container API Daerah yang Terhubung
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF2F5061),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'API DAERAH YANG TELAH TERHUBUNG',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5), // Jarak ke atas
                    const Divider(color: Colors.white),
                    const SizedBox(height: 5), // Jarak ke bawah
                    ...cities.map((city) {
                      return Text(
                        city,
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                          color: Colors.white,
                        ),
                      );
                    }),
                    const SizedBox(
                        height:
                            60), // Jarak dari tulisan terakhir ke "to be continued"
                    const Text(
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
              const SizedBox(height: 30), // Jarak ke bawah
            ],
          ),
        ),
      ),
    );
  }
}
