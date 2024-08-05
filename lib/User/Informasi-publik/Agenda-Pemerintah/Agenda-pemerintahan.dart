import 'package:flutter/material.dart';

class AgendaPemerintahan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC4DFE2),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Container(
          padding: const EdgeInsets.only(top: 20.0, bottom: 16.0),
          decoration: const BoxDecoration(
            color: Color(0xFFECF5F6),
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
                      margin: const EdgeInsets.only(right: 10.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE2DED0),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'TIMELINE ACARA & FESTIVAL',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_pin, size: 16, color: Color(0xFFA53525)),
                  SizedBox(width: 4),
                  Text(
                    'Kota Bekasi',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 16,
                      color: Color(0xFFAC5F63),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 13),
              eventCard(
                subjudul:
                    'Rapat Paripurna Pengucapan Sumpah/Janji Anggota DPRD Masa Jabatan 2024-2029',
                tanggalJam: '4 Juli 2024 09:00 - 12:00 WIB',
                lokasi: 'Gedung Paripurna DPRD Kota Bekasi',
              ),
              eventCard(
                subjudul:
                    'Kunjungan kerja ke seluruh Perangkat Daerah Pemerintah Kota Bekasi (Perumda Aneka Usaha)',
                tanggalJam: '11 Agustus 2024  08:00 - 09:00 WIB',
                lokasi: 'Perumda Aneka Usaha',
              ),
              eventCard(
                subjudul: 'Penyerahan Bantuan Sosial',
                tanggalJam: '12 Agustus 2024  08:00 - 09:00 WIB',
                lokasi: 'Balai Kota Bekasi',
              ),
              eventCard(
                subjudul: 'Rockpot Kesehatan',
                tanggalJam: '20 Agustus 2024  06:00 - 08:00 WIB',
                lokasi: 'Stadion Utama Kota Bekasi',
              ),
              eventCard(
                subjudul: '(DL) Healthy Cities summit ke-6 tahun 2024',
                tanggalJam: '28 Juli 2024  09:00 - 12:00 WIB',
                lokasi: 'Grand Inna Samudra Beach, Sukabumi',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget eventCard({
    required String subjudul,
    required String tanggalJam,
    required String lokasi,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFEAEEEF),
            borderRadius: BorderRadius.circular(7.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subjudul,
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Color(0xFFCE7277)),
                  SizedBox(width: 8),
                  Text(
                    tanggalJam,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xFFCE7277)),
                  SizedBox(width: 8),
                  Text(
                    lokasi,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
