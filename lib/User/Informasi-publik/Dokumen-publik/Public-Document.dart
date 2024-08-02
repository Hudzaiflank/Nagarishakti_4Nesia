//!JANGAN DI UBAH STYLINGNYA
//!JANGAN DI UBAH STYLINGNYA
//!JANGAN DI UBAH STYLINGNYA
//!JANGAN DI UBAH STYLINGNYA
//!JANGAN DI UBAH STYLINGNYA

import 'package:flutter/material.dart';

class PublicDocumentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF5F6),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE2DED0),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  // Handle back button press
                },
              ),
            ),
            title: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFFE2DED0),
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Cari Berita',
                  hintStyle: const TextStyle(
                    color: Color(0xFF8E98A8),
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Ubuntu',
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 12.0),
                    child: Icon(Icons.search, color: Color(0xFF8E98A8)),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFC4DFE2),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'AKSES DOKUMEN PUBLIK',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Ubuntu',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on, color: Color(0xFFAC5F63)),
                            SizedBox(width: 4),
                            Text(
                              'Kota Bekasi',
                              style: TextStyle(
                                color: Color(0xFFAC5F63),
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  documentCard(
                    title: 'Rencana Kerja Perangkat Daerah (RKPD) 2024 ',
                    date: '12/07/2024',
                    time: '08:00 WIB',
                  ),
                  documentCard(
                    title:
                        'Rencana Pembangunan Jangka Menengah Daerah (RPJMD) 2024',
                    date: '15/07/2024',
                    time: '09:23 WIB',
                  ),
                  documentCard(
                    title:
                        'Laporan Harta Kekayaan Penyelenggara Negara (LHKPN) 2023',
                    date: '19/07/2024',
                    time: '12:10 WIB',
                  ),
                  documentCard(
                    title: 'Laporan Keterangan Pertanggungjawaban 2023',
                    date: '12/07/2024',
                    time: '08:00 WIB',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget documentCard({
  required String title,
  required String date,
  required String time,
}) {
  return Card(
    color: Color(0xFFFBFAF8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  SizedBox(width: 7),
                  Text(
                    time,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Image.asset('assets/download-pdf.png',
                      width: 24, height: 24),
                  onPressed: () {
                    // TODO: thin buat handle download masing masing disini, panggil aja pk atau id nya
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
