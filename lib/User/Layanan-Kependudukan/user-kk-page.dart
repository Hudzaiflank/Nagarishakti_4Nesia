import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import '../user-home.dart';

class UserKkPage extends StatefulWidget {
  @override
  _UserKkPageState createState() => _UserKkPageState();
}

class _UserKkPageState extends State<UserKkPage> {
  String selectedReason = 'KK hilang/rusak';

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
                'FORMULIR PENGAJUAN KK',
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
                    context,
                    [
                      'KK hilang/rusak',
                      'KK Baru (membentuk Keluarga baru)',
                      'KK Baru (Pergantian Kepala Keluarga)',
                      'KK Baru (Pindah Datang)',
                      'KK Baru (Pindah WNI dari luar negeri)',
                      'KK Baru (Rentan Adminduk)',
                      'KK Perubahan (Peristiwa penting)'
                    ],
                  ),
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
                    child: Text(
                      'DATA PEMOHON',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF233C49),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF233C49),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  _buildTextField(
                    context: context,
                    label: 'Nama Lengkap',
                    hint: 'nama lengkap kepala keluarga',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Nomor Induk Kependudukan',
                    hint: 'nomor induk kependudukan',
                    isNumber: true,
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Nomor Kartu Keluarga',
                    hint: 'nomor kartu keluarga',
                    isNumber: true,
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Nomor Handphone',
                    hint: 'nomor handphone',
                    isNumber: true,
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Email',
                    hint: 'alamat email',
                  ),
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
                  if (selectedReason == 'KK hilang/rusak') ...[
                    _buildSubTitleWithItalic(
                      'Kartu Keluarga Lama (rusak)',
                      ' atau ',
                      'Surat Kehilangan dari Kepolisian',
                    ),
                    _buildUploadField(),
                  ] else if (selectedReason ==
                      'KK Baru (membentuk Keluarga baru)') ...[
                    _buildSubTitleWithNormal(
                      'Buku nikah/kutipan akta perkawinan',
                      ' atau ',
                      'kutipan akta perceraian',
                      ' atau ',
                      'Surat Pernyataan Tanggung Jawab Mutlak (SPTJM) perkawinan/perceraian belum tercatat',
                    ),
                    _buildUploadField(),
                  ] else if (selectedReason ==
                      'KK Baru (Pergantian Kepala Keluarga)') ...[
                    _buildSubTitle('Kartu Keluarga Lama'),
                    _buildUploadField(),
                    _buildSubTitle('Surat Keterangan Kematian Kepala Keluarga'),
                    _buildUploadField(),
                  ] else if (selectedReason == 'KK Baru (Pindah Datang)') ...[
                    _boxBuild(context),
                    _buildSubTitle('Surat Keterangan Pindah Datang (SKPD)'),
                    _buildUploadField(),
                    _buildSubTitle('Kartu Keluarga Lama'),
                    _buildUploadField(),
                  ] else if (selectedReason ==
                      'KK Baru (Pindah WNI dari luar negeri)') ...[
                    _buildSubTitle(
                        'Surat Keterangan Pindah Luar Negeri (SKPLN)'),
                    _buildUploadField(),
                  ] else if (selectedReason == 'KK Baru (Rentan Adminduk)') ...[
                    _buildSubTitle('Surat Pengantar RT dan RW'),
                    _buildUploadField(),
                    _buildSubTitle(
                        'Surat Pernyataan Tidak Memiliki Dokumen Kependudukan'),
                    _buildUploadField(),
                  ] else if (selectedReason ==
                      'KK Perubahan (Peristiwa penting)') ...[
                    _buildSubTitle('Kartu Keluarga Lama'),
                    _buildUploadField(),
                    _textJustify(
                      'Bukti Perubahan Peristiwa Kependudukan dan Peristiwa Penting ',
                      '\nContoh: Kelahiran, Perkawinan, Pembatalan Perkawinan, Perceraian, Pembatalan Perceraian, Kematian, Pengangkatan Anak, Pengakuan Anak, Pengesahan Anak, Perubahan Nama, Perubahan Status Kewarganegaraan, Pembetulan Akta dan Pembatalan Akta',
                    ), // ini itu udh beda widget, makanya mending disatuin pake widget sebelumnya apa gimana ya
                    _buildUploadField(),
                  ] else if (selectedReason == '')
                    ...[],
                  _buildSubTitle('Dokumen Tambahan'),
                  _buildUploadField(),
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
                  // ini buat handle submit nya thinnn
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

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String hint,
    bool isDateField = false,
    bool isNumber = false,
  }) {
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
                    // Handle the selected date
                  }
                : null,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            inputFormatters:
                isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
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
            value: selectedReason,
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

  Widget _buildUploadField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
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
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                icon: Icon(Icons.close, color: Colors.white, size: 16),
                onPressed: () {
                  // ini nanti buat remove nya thinnn mas broo
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textJustify(String part1, String part2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.6,
          ),
          children: <TextSpan>[
            TextSpan(text: part1),
            TextSpan(
              text: part2,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubTitleWithNormal(
      String part1, String part2, String part3, String part4, String part5) {
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
                fontStyle: FontStyle.normal,
              ),
            ),
            TextSpan(text: part3),
            TextSpan(
              text: part4,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
              ),
            ),
            TextSpan(text: part5),
          ],
        ),
      ),
    );
  }

  Widget _boxBuild(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 9.0),
      decoration: BoxDecoration(
        color: Color(0xFF2F5061),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: RichText(
        text: TextSpan(
          text:
              'Silakan isi formulir perpindahan kependudukan terlebih dahulu untuk mendapatkan surat keterangan pindah sebagai syarat kelengkapan pembuatan KK baru ',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w100,
            color: Colors.white,
            height: 1.5,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'di sini.',
              style: TextStyle(
                color: Color(0xFFE57F84),
                fontWeight: FontWeight.w300,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserHome()),
                  );
                },
            ),
          ],
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}