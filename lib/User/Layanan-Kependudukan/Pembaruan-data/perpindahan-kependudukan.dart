import 'package:flutter/material.dart';

class PerpindahanKependudukan extends StatefulWidget {
  @override
  _PerpindahanKependudukanState createState() =>
      _PerpindahanKependudukanState();
}

class _PerpindahanKependudukanState extends State<PerpindahanKependudukan> {
  String selectedReason = 'Surat Keterangan Pindah';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF5F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFE2DED0),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    Text(
                      'PENGAJUAN PERPINDAHAN KEPENDUDUKAN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 2,
                      color: Colors.black,
                      width: double.infinity,
                    ),
                    SizedBox(height: 19),
                  ],
                ),
              ),
              //ini data pemohon sob
              _buildSection(
                title: 'DATA PEMOHON',
                fields: [
                  _buildTextField(
                    context: context,
                    label: 'Nomor KK',
                    hint: 'nomor kartu keluarga',
                    isNumber: true,
                  ),
                  _buildTextField(
                    context: context,
                    label: 'NIK Pemohon',
                    hint: 'nomor induk kependudukan pelapor',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Nama Lengkap',
                    hint: 'tulis nama lengkap pelapor',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Posisi dalam Keluarga',
                    hint: 'kedudukan pada kartu keluarga',
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              //ini alasan pembuatan sob
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE2DED0),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubTitle('Alasan Pembuatan'),
                    _buildDropdownField(
                      context,
                      [
                        'Surat Keterangan Pindah',
                        'Surat Keterangan Pindah Luar Negeri (SKPLN)'
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              if (selectedReason == 'Surat Keterangan Pindah') ...[
                _buildSection(
                  title: 'DAERAH ASAL',
                  fields: [
                    _buildTextField(
                        context: context,
                        label: 'Alamat Asal',
                        hint: 'Nomor rumah atau lainnya'),
                    _buildSubTitle('RT, RW, dan Kode Pos'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 90,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the click event here
                              print('TextField clicked');
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w100,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'RT',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 90,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the click event here
                              print('TextField clicked');
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'RW',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 90,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the click event here
                              print('TextField clicked');
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Kode Pos',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Provinsi',
                      hint: 'PILIH PROVINSI',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Kota/Kabupaten',
                      hint: 'PILIH KOTA/KABUPATEN',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Kecamatan',
                      hint: 'PILIH KECAMATAN',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Desa/Kelurahan  ',
                      hint: 'PILIH DESA/KELURAHAN',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                _buildSection(
                  title: 'Daerah Perpindahan',
                  fields: [
                    _buildTextField(
                        context: context,
                        label: 'Alamat Tujuan',
                        hint: 'Nomor rumah atau lainnya'),
                    _buildSubTitle('RT, RW, dan Kode Pos'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 90,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the click event here
                              print('TextField clicked');
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w100,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'RT',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 90,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the click event here
                              print('TextField clicked');
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'RW',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 90,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the click event here
                              print('TextField clicked');
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Kode Pos',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Provinsi',
                      hint: 'PILIH PROVINSI',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Kota/Kabupaten',
                      hint: 'PILIH KOTA/KABUPATEN',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Kecamatan',
                      hint: 'PILIH KECAMATAN',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Desa/Kelurahan  ',
                      hint: 'PILIH DESA/KELURAHAN',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Alasan Kepindahan  ',
                      hint: 'Alasan Kepindahan',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Jenis Kepindahan  ',
                      hint: 'Jenis Kepindahan',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Anggota Keluarga yang Pindah ',
                      hint: 'Kepindahan Anggota Keluarga',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9FCFC),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFCE7277),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'UNGGAH DOKUMEN KELENGKAPAN',
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      _buildSubTitle('KTP Pemohon'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // ini buat handle upload document nya thin
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0E5E7),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/upload-icon.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE2DED0),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Pilih gambar atau dokumen',
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4F4E49),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                  onPressed: () {
                                    // ini nanti buat remove nya thinnn mas broo
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildSubTitle('Kartu Keluarga'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // ini buat handle upload document nya thin
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0E5E7),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/upload-icon.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE2DED0),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Pilih gambar atau dokumen',
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4F4E49),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                  onPressed: () {
                                    // ini nanti buat remove nya thinnn mas broo
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildSubTitle('Formulir F-1.02'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // ini buat handle upload document nya thin
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0E5E7),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/upload-icon.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE2DED0),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Pilih gambar atau dokumen',
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4F4E49),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                  onPressed: () {
                                    // ini nanti buat remove nya thinnn mas broo
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildSubTitle('Formulir F-1.03'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // ini buat handle upload document nya thin
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0E5E7),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/upload-icon.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE2DED0),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Pilih gambar atau dokumen',
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4F4E49),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                  onPressed: () {
                                    // ini nanti buat remove nya thinnn mas broo
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ] else if (selectedReason ==
                  'Surat Keterangan Pindah Luar Negeri (SKPLN)') ...[
                _buildSection(
                  title: 'DAERAH ASAL',
                  fields: [
                    _buildTextField(
                        context: context,
                        label: 'Alamat Asal',
                        hint: 'Nomor rumah atau lainnya'),
                    _buildSubTitle('RT, RW, dan Kode Pos'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 90,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the click event here
                              print('TextField clicked');
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w100,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'RT',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 90,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the click event here
                              print('TextField clicked');
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'RW',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 90,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the click event here
                              print('TextField clicked');
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Kode Pos',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Provinsi',
                      hint: 'PILIH PROVINSI',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Kota/Kabupaten',
                      hint: 'PILIH KOTA/KABUPATEN',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Kecamatan',
                      hint: 'PILIH KECAMATAN',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Desa/Kelurahan  ',
                      hint: 'PILIH DESA/KELURAHAN',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                _buildSection(
                  title: 'Negara Perpindahan',
                  fields: [
                    _buildTextField(
                        context: context,
                        label: 'Alamat Tujuan',
                        hint: 'Nomor rumah atau lainnya'),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Kode Negara',
                      hint: 'PILIH KODE NEGARA',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                    ),
                    _buildTextField(
                        context: context,
                        label: 'Penanggung Jawab',
                        hint: 'nama penanggung jawab kepindahan'),
                    _buildDatePickerField(
                      context: context,
                      label: 'Rencana Pindah Tanggal',
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Nomor Handphone',
                      hint: 'nomor handphone',
                      isNumber: true,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Nama Lengkap',
                      hint: 'tulis nama lengkap pelapor',
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9FCFC),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFCE7277),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'UNGGAH DOKUMEN KELENGKAPAN',
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      _buildSubTitle('KTP Pemohon'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // ini buat handle upload document nya thin
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0E5E7),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/upload-icon.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE2DED0),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Pilih gambar atau dokumen',
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4F4E49),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                  onPressed: () {
                                    // ini nanti buat remove nya thinnn mas broo
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildSubTitle('Kartu Keluarga'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // ini buat handle upload document nya thin
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0E5E7),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/upload-icon.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE2DED0),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Pilih gambar atau dokumen',
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4F4E49),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                  onPressed: () {
                                    // ini nanti buat remove nya thinnn mas broo
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildSubTitle('Formulir F-1.02'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // ini buat handle upload document nya thin
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0E5E7),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/upload-icon.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE2DED0),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Pilih gambar atau dokumen',
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4F4E49),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                  onPressed: () {
                                    // ini nanti buat remove nya thinnn mas broo
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildSubTitle('Formulir F-1.03 (Opsional)'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // ini buat handle upload document nya thin
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0E5E7),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/upload-icon.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE2DED0),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Pilih gambar atau dokumen',
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4F4E49),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                  onPressed: () {
                                    // ini nanti buat remove nya thinnn mas broo
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2F5061),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                    ),
                    onPressed: () {},
                    child: Text(
                      'BUAT PENGAJUAN',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w700, // Very bold font weight
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 38),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> fields}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFC4DFE2),
        borderRadius: BorderRadius.circular(7),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF233C49),
                  ),
                ),
                Container(
                  height: 2,
                  color: Color(0xFF233C49),
                  width: 100,
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          ...fields,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String hint,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w100,
                color: Colors.black54,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(
              color: Colors.black,
            ),
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(BuildContext context, List<String> items,
      {String? label, Color backgroundColor = Colors.white}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) _buildSubTitle(label),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: DropdownButtonFormField(
            value: items.contains(selectedReason) ? selectedReason : null,
            isDense: true,
            isExpanded: true,
            decoration: InputDecoration(
              fillColor: backgroundColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
            ),
            items: items
                .map((label) => DropdownMenuItem(
                      child: Text(
                        label,
                        style: TextStyle(
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      value: label,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedReason = value as String;
              });
            },
            dropdownColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomDropdownField({
    required BuildContext context,
    required String label,
    required String hint,
    required List<String> items,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w100,
                    color: Colors.black54,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black54,
                ),
                value: null,
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChanged: (value) {},
                dropdownColor: Colors.white,
                isExpanded: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDatePickerField({
    required BuildContext context,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: Color(0xFF4297A0),
                      colorScheme: ColorScheme.light(
                        primary: Color(0xFF4297A0),
                        onPrimary: Colors.white,
                        onSurface: Colors.black,
                      ),
                      buttonTheme: ButtonThemeData(
                        textTheme: ButtonTextTheme.primary,
                      ),
                      dialogBackgroundColor: Colors.white,
                    ),
                    child: child!,
                  );
                },
              );
              // Handle the selected date
            },
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'BB-HH-TTTT',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w100,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Icon(Icons.calendar_today, color: Colors.black),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> get _provinces => [
        'Aceh',
        'Sumatera Utara',
        'Sumatera Barat',
        'Riau',
        'Kepulauan Riau',
        'Jambi',
        'Sumatera Selatan',
        'Bangka Belitung',
        'Bengkulu',
        'Lampung',
        'DKI Jakarta',
        'Jawa Barat',
        'Banten',
        'Jawa Tengah',
        'DI Yogyakarta',
        'Jawa Timur',
        'Bali',
        'Nusa Tenggara Barat',
        'Nusa Tenggara Timur',
        'Kalimantan Barat',
        'Kalimantan Tengah',
        'Kalimantan Selatan',
        'Kalimantan Timur',
        'Kalimantan Utara',
        'Sulawesi Utara',
        'Sulawesi Tengah',
        'Sulawesi Selatan',
        'Sulawesi Tenggara',
        'Gorontalo',
        'Sulawesi Barat',
        'Maluku',
        'Maluku Utara',
        'Papua',
        'Papua Barat',
        'Papua Selatan',
        'Papua Pegunungan',
        'Papua Tengah',
        'Papua Barat Daya'
      ];

  List<String> get _citiesAndRegencies => [
        // Aceh
        'Kabupaten Aceh Barat',
        'Kabupaten Aceh Barat Daya',
        'Kabupaten Aceh Besar',
        'Kabupaten Aceh Jaya',
        'Kabupaten Aceh Selatan',
        'Kabupaten Aceh Singkil',
        'Kabupaten Aceh Tamiang',
        'Kabupaten Aceh Tengah',
        'Kabupaten Aceh Tenggara',
        'Kabupaten Aceh Timur',
        'Kabupaten Aceh Utara',
        'Kabupaten Bener Meriah',
        'Kabupaten Bireuen',
        'Kabupaten Gayo Lues',
        'Kabupaten Nagan Raya',
        'Kabupaten Pidie',
        'Kabupaten Pidie Jaya',
        'Kabupaten Simeulue',
        'Kota Banda Aceh',
        'Kota Langsa',
        'Kota Lhokseumawe',
        'Kota Sabang',
        'Kota Subulussalam',

        // Sumatera Utara
        'Kabupaten Asahan',
        'Kabupaten Batu Bara',
        'Kabupaten Dairi',
        'Kabupaten Deli Serdang',
        'Kabupaten Humbang Hasundutan',
        'Kabupaten Karo',
        'Kabupaten Labuhanbatu',
        'Kabupaten Labuhanbatu Selatan',
        'Kabupaten Labuhanbatu Utara',
        'Kabupaten Langkat',
        'Kabupaten Mandailing Natal',
        'Kabupaten Nias',
        'Kabupaten Nias Barat',
        'Kabupaten Nias Selatan',
        'Kabupaten Nias Utara',
        'Kabupaten Padang Lawas',
        'Kabupaten Padang Lawas Utara',
        'Kabupaten Pakpak Bharat',
        'Kabupaten Samosir',
        'Kabupaten Serdang Bedagai',
        'Kabupaten Simalungun',
        'Kabupaten Tapanuli Selatan',
        'Kabupaten Tapanuli Tengah',
        'Kabupaten Tapanuli Utara',
        'Kabupaten Toba',
        'Kota Binjai',
        'Kota Gunungsitoli',
        'Kota Medan',
        'Kota Padang Sidempuan',
        'Kota Pematang Siantar',
        'Kota Sibolga',
        'Kota Tanjung Balai',
        'Kota Tebing Tinggi',

        // Sumatera Barat
        'Kabupaten Agam',
        'Kabupaten Dharmasraya',
        'Kabupaten Kepulauan Mentawai',
        'Kabupaten Lima Puluh Kota',
        'Kabupaten Padang Pariaman',
        'Kabupaten Pasaman',
        'Kabupaten Pasaman Barat',
        'Kabupaten Pesisir Selatan',
        'Kabupaten Sijunjung',
        'Kabupaten Solok',
        'Kabupaten Solok Selatan',
        'Kabupaten Tanah Datar',
        'Kota Bukittinggi',
        'Kota Padang',
        'Kota Padang Panjang',
        'Kota Pariaman',
        'Kota Payakumbuh',
        'Kota Sawahlunto',
        'Kota Solok',

        // Riau
        'Kabupaten Bengkalis',
        'Kabupaten Indragiri Hilir',
        'Kabupaten Indragiri Hulu',
        'Kabupaten Kampar',
        'Kabupaten Kepulauan Meranti',
        'Kabupaten Kuantan Singingi',
        'Kabupaten Pelalawan',
        'Kabupaten Rokan Hilir',
        'Kabupaten Rokan Hulu',
        'Kabupaten Siak',
        'Kota Dumai',
        'Kota Pekanbaru',

        // Kepulauan Riau
        'Kabupaten Bintan',
        'Kabupaten Karimun',
        'Kabupaten Kepulauan Anambas',
        'Kabupaten Lingga',
        'Kabupaten Natuna',
        'Kota Batam',
        'Kota Tanjung Pinang',

        // Jambi
        'Kabupaten Batanghari',
        'Kabupaten Bungo',
        'Kabupaten Kerinci',
        'Kabupaten Merangin',
        'Kabupaten Muaro Jambi',
        'Kabupaten Sarolangun',
        'Kabupaten Tanjung Jabung Barat',
        'Kabupaten Tanjung Jabung Timur',
        'Kabupaten Tebo',
        'Kota Jambi',
        'Kota Sungai Penuh',

        // Sumatera Selatan
        'Kabupaten Banyuasin',
        'Kabupaten Empat Lawang',
        'Kabupaten Lahat',
        'Kabupaten Muara Enim',
        'Kabupaten Musi Banyuasin',
        'Kabupaten Musi Rawas',
        'Kabupaten Musi Rawas Utara',
        'Kabupaten Ogan Ilir',
        'Kabupaten Ogan Komering Ilir',
        'Kabupaten Ogan Komering Ulu',
        'Kabupaten Ogan Komering Ulu Selatan',
        'Kabupaten Ogan Komering Ulu Timur',
        'Kabupaten Penukal Abab Lematang Ilir',
        'Kota Lubuklinggau',
        'Kota Pagar Alam',
        'Kota Palembang',
        'Kota Prabumulih',

        // Bangka Belitung
        'Kabupaten Bangka',
        'Kabupaten Bangka Barat',
        'Kabupaten Bangka Selatan',
        'Kabupaten Bangka Tengah',
        'Kabupaten Belitung',
        'Kabupaten Belitung Timur',
        'Kota Pangkal Pinang',

        // Bengkulu
        'Kabupaten Bengkulu Selatan',
        'Kabupaten Bengkulu Tengah',
        'Kabupaten Bengkulu Utara',
        'Kabupaten Kaur',
        'Kabupaten Kepahiang',
        'Kabupaten Lebong',
        'Kabupaten Mukomuko',
        'Kabupaten Rejang Lebong',
        'Kabupaten Seluma',
        'Kota Bengkulu',

        // Lampung
        'Kabupaten Lampung Barat',
        'Kabupaten Lampung Selatan',
        'Kabupaten Lampung Tengah',
        'Kabupaten Lampung Timur',
        'Kabupaten Lampung Utara',
        'Kabupaten Mesuji',
        'Kabupaten Pesawaran',
        'Kabupaten Pesisir Barat',
        'Kabupaten Pringsewu',
        'Kabupaten Tanggamus',
        'Kabupaten Tulang Bawang',
        'Kabupaten Tulang Bawang Barat',
        'Kabupaten Way Kanan',
        'Kota Bandar Lampung',
        'Kota Metro',

        // DKI Jakarta
        'Kabupaten Administrasi Kepulauan Seribu',
        'Kota Administrasi Jakarta Barat',
        'Kota Administrasi Jakarta Pusat',
        'Kota Administrasi Jakarta Selatan',
        'Kota Administrasi Jakarta Timur',
        'Kota Administrasi Jakarta Utara',

        // Jawa Barat
        'Kabupaten Bandung',
        'Kabupaten Bandung Barat',
        'Kabupaten Bekasi',
        'Kabupaten Bogor',
        'Kabupaten Ciamis',
        'Kabupaten Cianjur',
        'Kabupaten Cirebon',
        'Kabupaten Garut',
        'Kabupaten Indramayu',
        'Kabupaten Karawang',
        'Kabupaten Kuningan',
        'Kabupaten Majalengka',
        'Kabupaten Pangandaran',
        'Kabupaten Purwakarta',
        'Kabupaten Subang',
        'Kabupaten Sukabumi',
        'Kabupaten Sumedang',
        'Kabupaten Tasikmalaya',
        'Kota Bandung',
        'Kota Banjar',
        'Kota Bekasi',
        'Kota Bogor',
        'Kota Cimahi',
        'Kota Cirebon',
        'Kota Depok',
        'Kota Sukabumi',
        'Kota Tasikmalaya',

        // Banten
        'Kabupaten Lebak',
        'Kabupaten Pandeglang',
        'Kabupaten Serang',
        'Kabupaten Tangerang',
        'Kota Cilegon',
        'Kota Serang',
        'Kota Tangerang',
        'Kota Tangerang Selatan',

        // Jawa Tengah
        'Kabupaten Banjarnegara',
        'Kabupaten Banyumas',
        'Kabupaten Batang',
        'Kabupaten Blora',
        'Kabupaten Boyolali',
        'Kabupaten Brebes',
        'Kabupaten Cilacap',
        'Kabupaten Demak',
        'Kabupaten Grobogan',
        'Kabupaten Jepara',
        'Kabupaten Karanganyar',
        'Kabupaten Kebumen',
        'Kabupaten Kendal',
        'Kabupaten Klaten',
        'Kabupaten Kudus',
        'Kabupaten Magelang',
        'Kabupaten Pati',
        'Kabupaten Pekalongan',
        'Kabupaten Pemalang',
        'Kabupaten Purbalingga',
        'Kabupaten Purworejo',
        'Kabupaten Rembang',
        'Kabupaten Semarang',
        'Kabupaten Sragen',
        'Kabupaten Sukoharjo',
        'Kabupaten Tegal',
        'Kabupaten Temanggung',
        'Kabupaten Wonogiri',
        'Kabupaten Wonosobo',
        'Kota Magelang',
        'Kota Pekalongan',
        'Kota Salatiga',
        'Kota Semarang',
        'Kota Surakarta',
        'Kota Tegal',

        // DI Yogyakarta
        'Kabupaten Bantul',
        'Kabupaten Gunungkidul',
        'Kabupaten Kulon Progo',
        'Kabupaten Sleman',
        'Kota Yogyakarta',

        // Jawa Timur
        'Kabupaten Bangkalan',
        'Kabupaten Banyuwangi',
        'Kabupaten Blitar',
        'Kabupaten Bojonegoro',
        'Kabupaten Bondowoso',
        'Kabupaten Gresik',
        'Kabupaten Jember',
        'Kabupaten Jombang',
        'Kabupaten Kediri',
        'Kabupaten Lamongan',
        'Kabupaten Lumajang',
        'Kabupaten Madiun',
        'Kabupaten Magetan',
        'Kabupaten Malang',
        'Kabupaten Mojokerto',
        'Kabupaten Nganjuk',
        'Kabupaten Ngawi',
        'Kabupaten Pacitan',
        'Kabupaten Pamekasan',
        'Kabupaten Pasuruan',
        'Kabupaten Ponorogo',
        'Kabupaten Probolinggo',
        'Kabupaten Sampang',
        'Kabupaten Sidoarjo',
        'Kabupaten Situbondo',
        'Kabupaten Sumenep',
        'Kabupaten Trenggalek',
        'Kabupaten Tuban',
        'Kabupaten Tulungagung',
        'Kota Batu',
        'Kota Blitar',
        'Kota Kediri',
        'Kota Madiun',
        'Kota Malang',
        'Kota Mojokerto',
        'Kota Pasuruan',
        'Kota Probolinggo',
        'Kota Surabaya',

        // Bali
        'Kabupaten Badung',
        'Kabupaten Bangli',
        'Kabupaten Buleleng',
        'Kabupaten Gianyar',
        'Kabupaten Jembrana',
        'Kabupaten Karangasem',
        'Kabupaten Klungkung',
        'Kabupaten Tabanan',
        'Kota Denpasar',

        // Nusa Tenggara Barat
        'Kabupaten Bima',
        'Kabupaten Dompu',
        'Kabupaten Lombok Barat',
        'Kabupaten Lombok Tengah',
        'Kabupaten Lombok Timur',
        'Kabupaten Lombok Utara',
        'Kabupaten Sumbawa',
        'Kabupaten Sumbawa Barat',
        'Kota Bima',
        'Kota Mataram',

        // Nusa Tenggara Timur
        'Kabupaten Alor',
        'Kabupaten Belu',
        'Kabupaten Ende',
        'Kabupaten Flores Timur',
        'Kabupaten Kupang',
        'Kabupaten Lembata',
        'Kabupaten Malaka',
        'Kabupaten Manggarai',
        'Kabupaten Manggarai Barat',
        'Kabupaten Manggarai Timur',
        'Kabupaten Ngada',
        'Kabupaten Nagekeo',
        'Kabupaten Rote Ndao',
        'Kabupaten Sabu Raijua',
        'Kabupaten Sikka',
        'Kabupaten Sumba Barat',
        'Kabupaten Sumba Barat Daya',
        'Kabupaten Sumba Tengah',
        'Kabupaten Sumba Timur',
        'Kabupaten Timor Tengah Selatan',
        'Kabupaten Timor Tengah Utara',
        'Kota Kupang',

        // Kalimantan Barat
        'Kabupaten Bengkayang',
        'Kabupaten Kapuas Hulu',
        'Kabupaten Kayong Utara',
        'Kabupaten Ketapang',
        'Kabupaten Kubu Raya',
        'Kabupaten Landak',
        'Kabupaten Melawi',
        'Kabupaten Mempawah',
        'Kabupaten Sambas',
        'Kabupaten Sanggau',
        'Kabupaten Sekadau',
        'Kabupaten Sintang',
        'Kota Pontianak',
        'Kota Singkawang',

        // Kalimantan Tengah
        'Kabupaten Barito Selatan',
        'Kabupaten Barito Timur',
        'Kabupaten Barito Utara',
        'Kabupaten Gunung Mas',
        'Kabupaten Kapuas',
        'Kabupaten Katingan',
        'Kabupaten Kotawaringin Barat',
        'Kabupaten Kotawaringin Timur',
        'Kabupaten Lamandau',
        'Kabupaten Murung Raya',
        'Kabupaten Pulang Pisau',
        'Kabupaten Sukamara',
        'Kabupaten Seruyan',
        'Kota Palangka Raya',

        // Kalimantan Selatan
        'Kabupaten Balangan',
        'Kabupaten Banjar',
        'Kabupaten Barito Kuala',
        'Kabupaten Hulu Sungai Selatan',
        'Kabupaten Hulu Sungai Tengah',
        'Kabupaten Hulu Sungai Utara',
        'Kabupaten Kotabaru',
        'Kabupaten Tabalong',
        'Kabupaten Tanah Bumbu',
        'Kabupaten Tanah Laut',
        'Kabupaten Tapin',
        'Kota Banjarbaru',
        'Kota Banjarmasin',

        // Kalimantan Timur
        'Kabupaten Berau',
        'Kabupaten Kutai Barat',
        'Kabupaten Kutai Kartanegara',
        'Kabupaten Kutai Timur',
        'Kabupaten Mahakam Ulu',
        'Kabupaten Paser',
        'Kabupaten Penajam Paser Utara',
        'Kota Balikpapan',
        'Kota Bontang',
        'Kota Samarinda',

        // Kalimantan Utara
        'Kabupaten Bulungan',
        'Kabupaten Malinau',
        'Kabupaten Nunukan',
        'Kabupaten Tana Tidung',
        'Kota Tarakan',

        // Sulawesi Utara
        'Kabupaten Bolaang Mongondow',
        'Kabupaten Bolaang Mongondow Selatan',
        'Kabupaten Bolaang Mongondow Timur',
        'Kabupaten Bolaang Mongondow Utara',
        'Kabupaten Kepulauan Sangihe',
        'Kabupaten Kepulauan Siau Tagulandang Biaro',
        'Kabupaten Kepulauan Talaud',
        'Kabupaten Minahasa',
        'Kabupaten Minahasa Selatan',
        'Kabupaten Minahasa Tenggara',
        'Kabupaten Minahasa Utara',
        'Kota Bitung',
        'Kota Kotamobagu',
        'Kota Manado',
        'Kota Tomohon',

        // Sulawesi Tengah
        'Kabupaten Banggai',
        'Kabupaten Banggai Kepulauan',
        'Kabupaten Banggai Laut',
        'Kabupaten Buol',
        'Kabupaten Donggala',
        'Kabupaten Morowali',
        'Kabupaten Morowali Utara',
        'Kabupaten Parigi Moutong',
        'Kabupaten Poso',
        'Kabupaten Sigi',
        'Kabupaten Tojo Una-Una',
        'Kabupaten Tolitoli',
        'Kota Palu',

        // Sulawesi Selatan
        'Kabupaten Bantaeng',
        'Kabupaten Barru',
        'Kabupaten Bone',
        'Kabupaten Bulukumba',
        'Kabupaten Enrekang',
        'Kabupaten Gowa',
        'Kabupaten Jeneponto',
        'Kabupaten Kepulauan Selayar',
        'Kabupaten Luwu',
        'Kabupaten Luwu Timur',
        'Kabupaten Luwu Utara',
        'Kabupaten Maros',
        'Kabupaten Pangkajene dan Kepulauan',
        'Kabupaten Pinrang',
        'Kabupaten Sidenreng Rappang',
        'Kabupaten Sinjai',
        'Kabupaten Soppeng',
        'Kabupaten Takalar',
        'Kabupaten Tana Toraja',
        'Kabupaten Toraja Utara',
        'Kabupaten Wajo',
        'Kota Makassar',
        'Kota Palopo',
        'Kota Parepare',

        // Sulawesi Tenggara
        'Kabupaten Bombana',
        'Kabupaten Buton',
        'Kabupaten Buton Selatan',
        'Kabupaten Buton Tengah',
        'Kabupaten Buton Utara',
        'Kabupaten Kolaka',
        'Kabupaten Kolaka Timur',
        'Kabupaten Kolaka Utara',
        'Kabupaten Konawe',
        'Kabupaten Konawe Kepulauan',
        'Kabupaten Konawe Selatan',
        'Kabupaten Konawe Utara',
        'Kabupaten Muna',
        'Kabupaten Muna Barat',
        'Kabupaten Wakatobi',
        'Kota Bau-Bau',
        'Kota Kendari',

        // Gorontalo
        'Kabupaten Boalemo',
        'Kabupaten Bone Bolango',
        'Kabupaten Gorontalo',
        'Kabupaten Gorontalo Utara',
        'Kabupaten Pohuwato',
        'Kota Gorontalo',

        // Sulawesi Barat
        'Kabupaten Majene',
        'Kabupaten Mamasa',
        'Kabupaten Mamuju',
        'Kabupaten Mamuju Tengah',
        'Kabupaten Pasangkayu',
        'Kabupaten Polewali Mandar',

        // Maluku
        'Kabupaten Buru',
        'Kabupaten Buru Selatan',
        'Kabupaten Kepulauan Aru',
        'Kabupaten Maluku Barat Daya',
        'Kabupaten Maluku Tengah',
        'Kabupaten Maluku Tenggara',
        'Kabupaten Kepulauan Tanimbar',
        'Kabupaten Seram Bagian Barat',
        'Kabupaten Seram Bagian Timur',
        'Kota Ambon',
        'Kota Tual',

        // Maluku Utara
        'Kabupaten Halmahera Barat',
        'Kabupaten Halmahera Tengah',
        'Kabupaten Halmahera Timur',
        'Kabupaten Halmahera Selatan',
        'Kabupaten Halmahera Utara',
        'Kabupaten Kepulauan Sula',
        'Kabupaten Pulau Morotai',
        'Kabupaten Pulau Taliabu',
        'Kota Ternate',
        'Kota Tidore Kepulauan',

        // Papua
        'Kabupaten Asmat',
        'Kabupaten Biak Numfor',
        'Kabupaten Boven Digoel',
        'Kabupaten Deiyai',
        'Kabupaten Dogiyai',
        'Kabupaten Intan Jaya',
        'Kabupaten Jayapura',
        'Kabupaten Jayawijaya',
        'Kabupaten Keerom',
        'Kabupaten Lanny Jaya',
        'Kabupaten Mamberamo Raya',
        'Kabupaten Mamberamo Tengah',
        'Kabupaten Mappi',
        'Kabupaten Merauke',
        'Kabupaten Mimika',
        'Kabupaten Nabire',
        'Kabupaten Nduga',
        'Kabupaten Paniai',
        'Kabupaten Pegunungan Bintang',
        'Kabupaten Puncak',
        'Kabupaten Puncak Jaya',
        'Kabupaten Sarmi',
        'Kabupaten Supiori',
        'Kabupaten Tolikara',
        'Kabupaten Waropen',
        'Kabupaten Yahukimo',
        'Kabupaten Yalimo',
        'Kota Jayapura',

        // Papua Barat
        'Kabupaten Fakfak',
        'Kabupaten Kaimana',
        'Kabupaten Manokwari',
        'Kabupaten Manokwari Selatan',
        'Kabupaten Pegunungan Arfak',
        'Kabupaten Maybrat',
        'Kabupaten Raja Ampat',
        'Kabupaten Sorong',
        'Kabupaten Sorong Selatan',
        'Kabupaten Tambrauw',
        'Kabupaten Teluk Bintuni',
        'Kabupaten Teluk Wondama',
        'Kota Sorong',

        // Papua Selatan
        'Kabupaten Asmat',
        'Kabupaten Boven Digoel',
        'Kabupaten Mappi',
        'Kabupaten Merauke',

        // Papua Pegunungan
        'Kabupaten Jayawijaya',
        'Kabupaten Lanny Jaya',
        'Kabupaten Mamberamo Tengah',
        'Kabupaten Nduga',
        'Kabupaten Pegunungan Bintang',
        'Kabupaten Tolikara',
        'Kabupaten Yahukimo',
        'Kabupaten Yalimo',

        // Papua Tengah
        'Kabupaten Deiyai',
        'Kabupaten Dogiyai',
        'Kabupaten Intan Jaya',
        'Kabupaten Mimika',
        'Kabupaten Nabire',
        'Kabupaten Paniai',
        'Kabupaten Puncak',
        'Kabupaten Puncak Jaya',

        // Papua Barat Daya
        'Kabupaten Fakfak',
        'Kabupaten Kaimana',
        'Kabupaten Manokwari',
        'Kabupaten Manokwari Selatan',
        'Kabupaten Maybrat',
        'Kabupaten Pegunungan Arfak',
        'Kabupaten Raja Ampat',
        'Kabupaten Sorong',
        'Kabupaten Sorong Selatan',
        'Kabupaten Tambrauw',
        'Kabupaten Teluk Bintuni',
        'Kabupaten Teluk Wondama',
        'Kota Sorong',
      ];
}
