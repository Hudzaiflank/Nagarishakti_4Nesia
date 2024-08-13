import 'dart:io';
import 'package:flutter/material.dart';
import '/Database/database_aktaKelahiran.dart';
import 'package:file_picker/file_picker.dart';

class AktaLahir extends StatefulWidget {
  const AktaLahir({super.key});

  @override
  _AktaLahirState createState() => _AktaLahirState();
}

class _AktaLahirState extends State<AktaLahir> {
  final _formKey = GlobalKey<FormState>();
  int? _nikPelapor;
  int? _kkPelapor;
  int? _nikAyah;
  int? _nikIbu;
  int? _nikAnak;
  int? _urutanKelahiranAnak;
  int? _panjangAnak;
  String? _namaPelapor;
  String? _kewarganegaraanPelapor;
  String? _namaAyah;
  String? _tempatLahirAyah;
  String? _kewarganegaraanAyah;
  String? _namaIbu;
  String? _tempatLahirIbu;
  String? _kewarganegaraanIbu;
  String? _namaAnak;
  String? _jenisKelaminAnak;
  String? _tempatLahirAnak;
  String? _daerahLahirAnak;
  String? _hariLahirAnak;
  String? _waktuLahirAnak;
  String? _jenisKelahiranAnak; 
  String? _jenisKelahiranAnakLainnya;
  String? _beratAnak;
  String? _penolongKelahiranAnak; 
  String? _penolongKelahiranAnakLainnya;
  DateTime? _selectedDateAyah;
  DateTime? _selectedDateIbu;
  DateTime? _selectedDateAnak;
  File? _suratKelahiran;
  File? _buktiSPTJM;
  File? _kkOrangTua;
  File? _ktpAyah;
  File? _ktpIbu;
  File? _dokumenTambahan;

  Future<void> _selectDate({
    required BuildContext context,
    required DateTime? selectedDate,
    required ValueChanged<DateTime> onSelect,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      onSelect(picked);
    }
  }

  Future<void> _pickFile(Function(File) onFilePicked) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        onFilePicked(file);
      });
    }
  }

  void _removeFile(Function() onFileRemoved) {
    setState(() {
      onFileRemoved();
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newAkta = Akta(
        nikPelapor: _nikPelapor!,
        namaPelapor: _namaPelapor!,
        kkPelapor: _kkPelapor!,
        kewarganegaraanPelapor: _kewarganegaraanPelapor!,
        nikAyah: _nikAyah!,
        namaAyah: _namaAyah!,
        tempatLahirAyah: _tempatLahirAyah!,
        tanggalLahirAyah: _selectedDateAyah!,
        kewarganegaraanAyah: _kewarganegaraanAyah!,
        nikIbu: _nikIbu!,
        namaIbu: _namaIbu!,
        tempatLahirIbu: _tempatLahirIbu!,
        tanggalLahirIbu: _selectedDateIbu!,        
        kewarganegaraanIbu: _kewarganegaraanIbu!,
        nikAnak: _nikAnak!,
        namaAnak: _namaAnak!,
        jenisKelaminAnak: _jenisKelaminAnak!,
        tempatLahirAnak: _tempatLahirAnak!,
        daerahLahirAnak: _daerahLahirAnak!,
        hariLahirAnak: _hariLahirAnak!,
        tanggalLahirAnak: _selectedDateAnak!,
        waktuLahirAnak: _waktuLahirAnak!,
        jenisKelahiranAnak: _jenisKelahiranAnak!, 
        jenisKelahiranAnakLainnya: _jenisKelahiranAnakLainnya!,
        urutanKelahiranAnak: _urutanKelahiranAnak!,
        beratAnak: _beratAnak!,
        panjangAnak: _panjangAnak!,
        penolongKelahiranAnak: _penolongKelahiranAnak!,    
        penolongKelahiranAnakLainnya: _penolongKelahiranAnakLainnya!,
        suratKelahiran: _suratKelahiran!.path,
        buktiSPTJM: _buktiSPTJM!.path,
        kkOrangTua: _kkOrangTua!.path,
        ktpAyah: _ktpAyah!.path,
        ktpIbu: _ktpIbu!.path,        
        dokumenTambahan: _dokumenTambahan!.path,
      );

      final dbAkta = DatabaseAktaKelahiran.instance;
      await dbAkta.insertAkta(newAkta);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF5F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form (
            key: _formKey,
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
                      onSave: (value) => _nikPelapor = value != null ? int.tryParse(value) : null,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Nama Lengkap',
                      hint: 'tulis nama lengkap pelapor',
                      onSave: (value) => _namaPelapor = value,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Nomor KK',
                      hint: 'nomor KK',
                      isNumber: true,
                      onSave: (value) => _kkPelapor = value != null ? int.tryParse(value) : null,
                    ),
                    _buildDropdownField(
                      context: context,
                      label: 'Kewarganegaraan',
                      items: _countries,
                      currentValue: _kewarganegaraanPelapor,
                      onSave: (value) => _kewarganegaraanPelapor = value,
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
                      onSave: (value) => _nikAyah = value != null ? int.tryParse(value) : null,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Nama Ayah',
                      hint: 'tulis nama lengkap ayah',
                      onSave: (value) => _namaAyah = value,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Tempat Lahir Ayah',
                      hint: 'Tempat lahir',
                      onSave: (value) => _tempatLahirAyah = value,
                    ),
                    _buildDatePickerField(
                      context: context,
                      label: 'Tanggal Lahir Ayah',
                      selectedDate: _selectedDateAyah,
                      onSelect: (date) {
                        setState(() {
                          _selectedDateAyah = date;
                        });
                      },
                      onSave: (value) => null,
                      validator: (value) {
                        if (_selectedDateAyah == null) {
                          return 'Tanggal Lahir Ayah tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    _buildDropdownField(
                      context: context,
                      label: 'Kewarganegaraan Ayah',
                      items: _countries,
                      currentValue: _kewarganegaraanAyah,
                      onSave: (value) => _kewarganegaraanAyah = value,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'NIK Ibu',
                      hint: 'nomor induk kependudukan ibu',
                      isNumber: true,
                      onSave: (value) => _nikIbu = value != null ? int.tryParse(value) : null,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Nama Ibu',
                      hint: 'tulis nama lengkap ibu',
                      onSave: (value) => _namaIbu = value,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Tempat Lahir Ibu',
                      hint: 'Tempat lahir',
                      onSave: (value) => _tempatLahirIbu = value,
                    ),
                    _buildDatePickerField(
                      context: context,
                      label: 'Tanggal Lahir Ibu',
                      selectedDate: _selectedDateIbu,
                      onSelect: (date) {
                        setState(() {
                          _selectedDateIbu = date;
                        });
                      },
                      onSave: (value) => null,
                      validator: (value) {
                        if (_selectedDateIbu == null) {
                          return 'Tanggal Lahir Ibu tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    _buildDropdownField(
                      context: context,
                      label: 'Kewarganegaraan Ibu',
                      items: _countries,
                      currentValue: _kewarganegaraanIbu,
                      onSave: (value) => _kewarganegaraanIbu = value,
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
                      onSave: (value) => _nikAnak = value != null ? int.tryParse(value) : null,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Nama Lengkap',
                      hint: 'tulis nama lengkap dengan huruf kapital',
                      onSave: (value) => _namaAnak = value,
                    ),
                    _buildRadioField(
                      context: context,
                      label: 'Jenis Kelamin',
                      items: ['Laki-laki', 'Perempuan'],
                      groupValue: _jenisKelaminAnak,
                      onSaved: (value) => _jenisKelaminAnak = value,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Tempat Dilahirkan',
                      hint: 'Tempat lahir',
                      onSave: (value) => _tempatLahirAnak = value,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Tempat Kelahiran',
                      hint: 'Daerah tempat dilahirkan',
                      onSave: (value) => _daerahLahirAnak = value,
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
                      currentValue: _hariLahirAnak,
                      onSave: (value) => _hariLahirAnak = value,
                    ),
                    _buildDatePickerField(
                      context: context,
                      label: 'Tanggal Lahir',
                      selectedDate: _selectedDateAnak,
                      onSelect: (date) {
                        setState(() {
                          _selectedDateAnak = date;
                        });
                      },
                      onSave: (value) => null,
                      validator: (value) {
                        if (_selectedDateAnak == null) {
                          return 'Tanggal Lahir Anak tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Waktu Kelahiran',
                      hint: 'jam dilahirkan',
                      onSave: (value) => _waktuLahirAnak = value,
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
                      currentValue: _jenisKelahiranAnak,
                      onSave: (value) => _jenisKelahiranAnak = value,
                      onChanged: (value) {
                        setState(() {
                          _jenisKelahiranAnak = value;
                          if (value != 'Lainnya') {
                            _jenisKelahiranAnak = null;
                          }
                        });
                      },
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Kelahiran Ke-',
                      hint: 'isi dengan angka',
                      isNumber: true,
                      onSave: (value) => _urutanKelahiranAnak = value != null ? int.tryParse(value) : null,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Berat Bayi',
                      hint: 'satuan kg, pisahkan dengan tanda titik (.)',
                      onSave: (value) => _beratAnak = value,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Panjang Bayi',
                      hint: 'satuan cm',
                      isNumber: true,
                      onSave: (value) => _panjangAnak = value != null ? int.tryParse(value) : null,
                    ),
                    _buildCustomDropdownField(
                      context: context,
                      label: 'Penolong Kelahiran',
                      items: ['Dokter', 'Bidan/Perawat', 'Dukun', 'Lainnya'],
                      currentValue: _penolongKelahiranAnak,
                      onSave: (value) => _penolongKelahiranAnak = value,
                      onChanged: (value) {
                        setState(() {
                          _penolongKelahiranAnak = value;
                          if (value != 'Lainnya') {
                            _penolongKelahiranAnak = null;
                          }
                        });
                      },
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
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _suratKelahiran = file;
                                });
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
                                          _suratKelahiran != null
                                              ? _suratKelahiran!.path.split('/').last
                                              : 'Pilih gambar atau dokumen',
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
                            if (_suratKelahiran != null)
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
                                      _removeFile(() {
                                        _suratKelahiran = null;
                                      });
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
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _buktiSPTJM = file;
                                });
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
                                          _buktiSPTJM != null
                                              ? _buktiSPTJM!.path.split('/').last
                                              : 'Pilih gambar atau dokumen',
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
                            if (_buktiSPTJM != null)
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
                                      _removeFile(() {
                                        _buktiSPTJM = null;
                                      });
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
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _kkOrangTua = file;
                                });
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
                                          _kkOrangTua != null
                                              ? _kkOrangTua!.path.split('/').last
                                              : 'Pilih gambar atau dokumen',
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
                            if (_kkOrangTua != null)
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
                                      _removeFile(() {
                                        _kkOrangTua = null;
                                      });
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
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _ktpAyah = file;
                                });
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
                                          _ktpAyah != null
                                              ? _ktpAyah!.path.split('/').last
                                              : 'Pilih gambar atau dokumen',
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
                            if (_ktpAyah != null)
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
                                      _removeFile(() {
                                        _ktpAyah = null;
                                      });
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
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _ktpIbu = file;
                                });
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
                                          _ktpIbu != null
                                              ? _ktpIbu!.path.split('/').last
                                              : 'Pilih gambar atau dokumen',
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
                            if (_ktpIbu != null)
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
                                      _removeFile(() {
                                        _ktpIbu = null;
                                      });
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
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _dokumenTambahan = file;
                                });
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
                                          _dokumenTambahan != null
                                              ? _dokumenTambahan!.path.split('/').last
                                              : 'Pilih gambar atau dokumen',
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
                            if (_dokumenTambahan != null)
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
                                      _removeFile(() {
                                        _dokumenTambahan = null;
                                      });
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
                    child: Form(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC6B79B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        ),
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
                ),
                SizedBox(height: 38),
              ],
            ),
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
    required FormFieldSetter<String?> onSave, // Menyesuaikan dengan tipe data nullable
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            onSaved: (value) {
              if (isNumber) {
                // Konversi string ke integer jika isNumber true
                onSave(value?.isNotEmpty == true ? int.tryParse(value!)?.toString() : null);
              } else {
                onSave(value);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label tidak boleh kosong';
              }
              if (isNumber && int.tryParse(value) == null) {
                return '$label tidak boleh kosong';
              }
              return null;
            },
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                fontFamily: 'Ubuntu',
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required List<String> items,
    String? currentValue,
    Function(String?)? onSave,
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
              value: items.contains(currentValue) ? currentValue : null,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (value) {
                if (onSave != null) {
                  onSave(value);
                }
              },
              onSaved: onSave,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '$label tidak boleh kosong';
                }
                return null;
              },
              dropdownColor: Colors.white,
              isExpanded: true, 
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
    Function(String?)? onSave,
    String? currentValue,
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
              value: items.contains(currentValue) ? currentValue : null,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (value) {
                onChanged(value);
                if (onSave != null) {
                  onSave(value);
                }
                if (label == 'Jenis Kelahiran' && value != 'Lainnya') {
                  _jenisKelahiranAnakLainnya = null;
                }
                if (label == 'Penolong Kelahiran' && value != 'Lainnya') {
                  _penolongKelahiranAnakLainnya = null;
                }
              },
              onSaved: onSave,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '$label tidak boleh kosong';
                }
                return null;
              },
              dropdownColor: Colors.white,
              isExpanded: true, // Ensure the dropdown expands to fill its container
            ),
          ),
          // Kondisi untuk menampilkan TextField jika pilihan "Lainnya" dipilih
          if (label == 'Jenis Kelahiran' && currentValue == 'Lainnya')
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildTextField(
                context: context,
                label: 'Jenis Kelahiran Lainnya',
                hint: '',
                onSave: (value) => _jenisKelahiranAnakLainnya = value,
              ),
            ),
          if (label == 'Penolong Kelahiran' && currentValue == 'Lainnya')
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildTextField(
                context: context,
                label: 'Penolong Kelahiran Lainnya',
                hint: '',
                onSave: (value) => _penolongKelahiranAnakLainnya = value,
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
    required String? groupValue,
    required void Function(String?)? onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FormField<String>(
        onSaved: onSaved,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label tidak boleh kosong';
          }
          return null;
        },
        builder: (FormFieldState<String> state) {
          return Column(
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
                    groupValue: groupValue,
                    onChanged: (value) {
                      state.didChange(value);
                      onSaved?.call(value);
                      setState(() {
                        // Update the value when the radio button is selected
                        groupValue = value;
                      });
                    },
                    activeColor: Colors.black,
                  );
                }).toList(),
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    state.errorText!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDatePickerField({
    required BuildContext context,
    required String label,
    required FormFieldSetter<String> onSave,
    required FormFieldValidator<String> validator,
    DateTime? selectedDate,
    ValueChanged<DateTime>? onSelect,
  }) {
    TextEditingController _controller = TextEditingController(
      text: selectedDate != null ? "${selectedDate.toLocal()}".split(' ')[0] : '',
    );

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
          TextFormField(
            controller: _controller,
            readOnly: true,
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
              if (date != null) {
                _controller.text = "${date.toLocal()}".split(' ')[0];
                if (onSelect != null) {
                  onSelect(date);
                }
              }
            },
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onSaved: onSave,
            validator: validator,
          ),
        ],
      ),
    );
  }

  Widget _buildFilePicker({
    required String label,
    required File? file,
    required Future<void> Function() onPick,
    required VoidCallback onRemove,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              file == null ? label : 'File selected: ${file.path.split('/').last}',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: Icon(file == null ? Icons.upload : Icons.remove),
            onPressed: file == null ? () async => await onPick() : onRemove,
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
        'Afganistan',
        'Albania',
        'Aljazair',
        'Andorra',
        'Angola',
        'Antigua dan Barbuda',
        'Argentina',
        'Armenia',
        'Australia',
        'Austria',
        'Azerbaijan',
        'Bahama',
        'Bahrain',
        'Bangladesh',
        'Barbados',
        'Belarus',
        'Belgia',
        'Belize',
        'Benin',
        'Bhutan',
        'Bolivia',
        'Bosnia dan Herzegovina',
        'Botswana',
        'Brazil',
        'Brunei',
        'Bulgaria',
        'Burkina Faso',
        'Burundi',
        'Cabo Verde',
        'Kamboja',
        'Kamerun',
        'Kanada',
        'Republik Afrika Tengah',
        'Chad',
        'Cile',
        'Cina',
        'Kolombia',
        'Komoros',
        'Kongo (Kongo-Brazzaville)',
        'Kosta Rika',
        'Kroasia',
        'Kuba',
        'Siprus',
        'Ceko (Republik Ceko)',
        'Denmark',
        'Djibouti',
        'Dominika',
        'Republik Dominika',
        'Ekuador',
        'Mesir',
        'El Salvador',
        'Guinea Khatulistiwa',
        'Eritrea',
        'Estonia',
        'Eswatini (dulu "Swaziland")',
        'Etiopia',
        'Fiji',
        'Finlandia',
        'Prancis',
        'Gabon',
        'Gambia',
        'Georgia',
        'Jerman',
        'Ghana',
        'Yunani',
        'Grenada',
        'Guatemala',
        'Guinea',
        'Guinea-Bissau',
        'Guyana',
        'Haiti',
        'Honduras',
        'Hongaria',
        'Islandia',
        'India',
        'Indonesia',
        'Iran',
        'Irak',
        'Irlandia',
        'Israel',
        'Italia',
        'Jamaika',
        'Jepang',
        'Yordania',
        'Kazakhstan',
        'Kenya',
        'Kiribati',
        'Korea Utara',
        'Korea Selatan',
        'Kosovo',
        'Kuwait',
        'Kirgistan',
        'Laos',
        'Latvia',
        'Libanon',
        'Lesotho',
        'Liberia',
        'Libya',
        'Liechtenstein',
        'Lituania',
        'Luxembourg',
        'Madagaskar',
        'Malawi',
        'Malaysia',
        'Maladewa',
        'Mali',
        'Malta',
        'Kepulauan Marshall',
        'Mauritania',
        'Mauritius',
        'Meksiko',
        'Mikronesia',
        'Moldova',
        'Monako',
        'Mongolia',
        'Montenegro',
        'Maroko',
        'Mozambik',
        'Myanmar (dulu Burma)',
        'Namibia',
        'Nauru',
        'Nepal',
        'Belanda',
        'Selandia Baru',
        'Nikaragua',
        'Niger',
        'Nigeria',
        'Makedonia Utara',
        'Norwegia',
        'Oman',
        'Pakistan',
        'Palau',
        'Negara Palestina',
        'Panama',
        'Papua Nugini',
        'Paraguay',
        'Peru',
        'Filipina',
        'Polandia',
        'Portugal',
        'Qatar',
        'Rumania',
        'Rusia',
        'Rwanda',
        'Saint Kitts dan Nevis',
        'Saint Lucia',
        'Saint Vincent dan Grenadines',
        'Samoa',
        'San Marino',
        'Sao Tome dan Principe',
        'Arab Saudi',
        'Senegal',
        'Serbia',
        'Seychelles',
        'Sierra Leone',
        'Singapura',
        'Slovakia',
        'Slovenia',
        'Kepulauan Solomon',
        'Somalia',
        'Afrika Selatan',
        'Sudan Selatan',
        'Spanyol',
        'Sri Lanka',
        'Sudan',
        'Suriname',
        'Swedia',
        'Swiss',
        'Suriah',
        'Taiwan',
        'Tajikistan',
        'Tanzania',
        'Thailand',
        'Timor Leste',
        'Turki',
        'Turkmenistan',
        'Tuvalu',
        'Uganda',
        'Ukraina',
        'Uni Emirat Arab',
        'Inggris',
        'Amerika Serikat',
        'Uruguay',
        'Uzbekistan',
        'Vanuatu',
        'Kota Vatikan',
        'Venezuela',
        'Vietnam',
        'Yaman',
        'Zambia',
        'Zimbabwe',
      ];
}