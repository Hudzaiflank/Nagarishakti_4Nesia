import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class UserKtpPage extends StatefulWidget {
  @override
  _UserKtpPageState createState() => _UserKtpPageState();
}

class _UserKtpPageState extends State<UserKtpPage> {
  String selectedReason = 'Telah berusia 17 tahun';
  String selectedGender = 'Pria';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4297A0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0xFF4297A0),
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE2DED0),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back,
                          color: Colors.black, size: 18.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                'FORMULIR PENGAJUAN KTP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Divider(
              color: Colors.white,
              thickness: 1,
            ),
            SizedBox(height: 16.0),
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
                      context, ['Telah berusia 17 tahun', 'KTP hilang/rusak']),
                ],
              ),
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
                  _buildTextField(
                    context: context,
                    label: 'NIK',
                    hint: 'nomor induk kependudukan',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Nama Lengkap',
                    hint: 'nama lengkap huruf kapital',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Tempat Lahir',
                    hint: 'tempat lahir',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Tanggal Lahir',
                    hint: 'BB-HH-TTTT',
                    isDateField: true,
                  ),
                  _buildSubTitle('Jenis Kelamin'),
                  _buildRadioButton('Pria', 'Jenis Kelamin'),
                  _buildRadioButton('Wanita', 'Jenis Kelamin'),
                  _buildTextField(
                    context: context,
                    label: 'Alamat Lengkap',
                    hint: 'alamat sesuai KTP',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Agama',
                    hint: 'agama',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Jenis Pekerjaan',
                    hint: 'jenis pekerjaan',
                  ),
                  _buildDropdownField(
                      context,
                      [
                        'Belum menikah',
                        'Sudah menikah',
                        'Cerai hidup',
                        'Cerai mati'
                      ],
                      label: 'Status Perkawinan',
                      backgroundColor: Color(0xFFE0E5E7)),
                ],
              ),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
                                      borderRadius: BorderRadius.circular(4),
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
                  if (selectedReason == 'Telah berusia 17 tahun') ...[
                    _buildSubTitle('Surat Pengantar Desa/Kelurahan'),
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
                                        borderRadius: BorderRadius.circular(4),
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
                  ] else if (selectedReason == 'KTP hilang/rusak') ...[
                    _buildSubTitleWithItalic('KTP Lama', ' atau',
                        '\nSurat Kehilangan dari Kepolisian'),
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
                                        borderRadius: BorderRadius.circular(4),
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
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFCDC2AE),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                ),
                onPressed: () {
                  // ini buat handle si file nya borrrr
                },
                child: Text(
                  'Ajukan',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildTextField(
      {required BuildContext context,
      required String label,
      required String hint,
      bool isDateField = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubTitle(label),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextField(
            readOnly: isDateField,
            onTap: isDateField
                ? () async {
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
                    if (date != null) {
                      setState(() {
                        // Display selected date in the text field
                        // Format date as per requirement
                      });
                    }
                  }
                : null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: 'Ubuntu',
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
              filled: true,
              fillColor: Color(0xFFE0E5E7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
              suffixIcon: isDateField ? Icon(Icons.calendar_today) : null,
            ),
          ),
        ),
      ],
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

  Widget _buildRadioButton(String title, String groupValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: RadioListTile(
        title: Text(title, style: TextStyle(fontFamily: 'Ubuntu')),
        value: title,
        groupValue: selectedGender,
        onChanged: (value) {
          setState(() {
            selectedGender = value as String;
          });
        },
      ),
    );
  }

  Widget _buildSubTitleWithItalic(String part1, String part2, String part3) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(text: part1),
            TextSpan(
              text: part2,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
              ),
            ),
            TextSpan(text: part3),
          ],
        ),
      ),
    );
  }
}