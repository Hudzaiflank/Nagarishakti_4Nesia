import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AktaLahir(),
  ));
}

class AktaLahir extends StatefulWidget {
  @override
  _AktaLahirState createState() => _AktaLahirState();
}

class _AktaLahirState extends State<AktaLahir> {
  String? _selectedGender;
  String? _selectedJenisKelahiran;
  String? _selectedPenolongKelahiran;

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
                      'FORMULIR PENGAJUAN AKTA KELAHIRAN',
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
              _buildSection(
                title: 'DATA PELAPOR',
                fields: [
                  _buildTextField(
                    context: context,
                    label: 'NIK Pelapor',
                    hint: 'nomor induk kependudukan pelapor',
                    isNumber: true,
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Nama Lengkap',
                    hint: 'tulis nama lengkap pelapor',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Nomor KK',
                    hint: 'nomor KK',
                    isNumber: true,
                  ),
                  _buildDropdownField(
                    context: context,
                    label: 'Kewarganegaraan',
                    items: _countries,
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildSection(
                title: 'DATA ORANG TUA',
                fields: [
                  _buildTextField(
                    context: context,
                    label: 'NIK Ayah',
                    hint: 'nomor induk kependudukan ayah',
                    isNumber: true,
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Nama Ayah',
                    hint: 'tulis nama lengkap ayah',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Tempat Lahir Ayah',
                    hint: 'Tempat lahir',
                  ),
                  _buildDatePickerField(
                    context: context,
                    label: 'Tanggal Lahir Ayah',
                  ),
                  _buildDropdownField(
                    context: context,
                    label: 'Kewarganegaraan Ayah',
                    items: _countries,
                  ),
                  _buildTextField(
                    context: context,
                    label: 'NIK Ibu',
                    hint: 'nomor induk kependudukan ibu',
                    isNumber: true,
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Nama Ibu',
                    hint: 'tulis nama lengkap ibu',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Tempat Lahir Ibu',
                    hint: 'Tempat lahir',
                  ),
                  _buildDatePickerField(
                    context: context,
                    label: 'Tanggal Lahir Ibu',
                  ),
                  _buildDropdownField(
                    context: context,
                    label: 'Kewarganegaraan Ibu',
                    items: _countries,
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildSection(
                title: 'DATA ANAK',
                fields: [
                  _buildTextField(
                    context: context,
                    label: 'NIK Bayi (jika ada)',
                    hint: 'nomor induk kependudukan anak',
                    isNumber: true,
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Nama Lengkap',
                    hint: 'tulis nama lengkap dengan huruf kapital',
                  ),
                  _buildRadioField(
                    context: context,
                    label: 'Jenis Kelamin',
                    items: ['Laki-laki', 'Perempuan'],
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Tempat Dilahirkan',
                    hint: 'Tempat lahir',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Tempat Kelahiran',
                    hint: 'Daerah tempat dilahirkan',
                  ),
                  _buildDropdownField(
                    context: context,
                    label: 'Hari Lahir',
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
                  _buildDatePickerField(
                    context: context,
                    label: 'Tanggal Lahir',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Waktu Kelahiran',
                    hint: 'jam dilahirkan',
                  ),
                  _buildCustomDropdownField(
                    context: context,
                    label: 'Jenis Kelahiran',
                    items: [
                      'Tunggal',
                      'Kembar 2',
                      'Kembar 3',
                      'Kembar 4',
                      'Lainnya'
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedJenisKelahiran = value;
                      });
                    },
                  ),
                  if (_selectedJenisKelahiran == 'Lainnya')
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: _buildTextField(
                        context: context,
                        label: '',
                        hint: '',
                      ),
                    ),
                  _buildTextField(
                    context: context,
                    label: 'Kelahiran Ke-',
                    hint: 'isi dengan angka',
                    isNumber: true,
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Berat Bayi',
                    hint: 'satuan kg, pisahkan dengan tanda titik (.)',
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Panjang Bayi',
                    hint: 'satuan cm',
                    isNumber: true,
                  ),
                  _buildCustomDropdownField(
                    context: context,
                    label: 'Penolong Kelahiran',
                    items: ['Dokter', 'Bidan/Perawat', 'Dukun', 'Lainnya'],
                    onChanged: (value) {
                      setState(() {
                        _selectedPenolongKelahiran = value;
                      });
                    },
                  ),
                  if (_selectedPenolongKelahiran == 'Lainnya')
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: _buildTextField(
                        context: context,
                        label: '',
                        hint: '',
                      ),
                    ),
                ],
              ),
              SizedBox(height: 34),
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
                    _buildSubTitle('Surat Keterangan Kelahiran'),
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
                    _buildSubTitle('Buku Nikah Orang Tua / SPTJM'),
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
                    _buildSubTitle('Kartu Keluarga Orang Tua'),
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
                    _buildSubTitle('KTP Ayah'),
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
                    _buildSubTitle('KTP Ibu'),
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
                    _buildSubTitle('Dokumen Tambahan'),
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
                ),
              ),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFC6B79B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SELANJUTNYA',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: Color(0xFFE57F84)),
                      ],
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

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
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
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: InputBorder.none,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomDropdownField({
    required BuildContext context,
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
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
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: InputBorder.none,
              ),
              value: null,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: onChanged,
              dropdownColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioField({
    required BuildContext context,
    required String label,
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
          Column(
            children: items.map((String item) {
              return RadioListTile<String>(
                title: Text(item),
                value: item,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                activeColor: Colors.black,
              );
            }).toList(),
          ),
        ],
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

  List<String> get _countries => [
        'WNI',
        'WNA',
        // Add more countries
      ];
}
