import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import '/Database/database_kk.dart';
import '../../user-home.dart';
import 'package:file_picker/file_picker.dart';

class UserKkPage extends StatefulWidget {
  const UserKkPage({super.key});

  @override
  _UserKkPageState createState() => _UserKkPageState();
}

class _UserKkPageState extends State<UserKkPage> {
  final _formKey = GlobalKey<FormState>();
  String? _alasanPembuatan;
  String? _namaLengkap;
  int? _nomorNIK;
  int? _nomorKK;
  int? _nomorHandphone;
  String? _email;
  File? _buktiKehilangan;
  File? _buktiStatusHubungan;
  File? _buktiKKLama;
  File? _buktiKematianKepalaKeluarga;
  File? _buktiSKPD;
  File? _buktiSKPLN;
  File? _suratPengantar;
  File? _suratPernyataanKependudukan;
  File? _buktiPerubahanPeristiwa;
  File? _dokumenTambahan;

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

      // Validasi hanya pada file yang diperlukan sesuai dengan alasan pembuatan yang dipilih
      bool isValid = true;

      if (_alasanPembuatan == 'KK hilang/rusak') {
        if (_buktiKehilangan == null || _dokumenTambahan == null) {
          isValid = false;
          print("Error: _buktiKehilangan or _dokumenTambahan is null for KK hilang/rusak.");
        }
      } else if (_alasanPembuatan == 'KK Baru (membentuk Keluarga baru)') {
        if (_buktiStatusHubungan == null) {
          isValid = false;
          print("Error: _buktiStatusHubungan is null for KK Baru (membentuk Keluarga baru).");
        }
      } else if (_alasanPembuatan == 'KK Baru (Pergantian Kepala Keluarga)') {
        if (_buktiKematianKepalaKeluarga == null) {
          isValid = false;
          print("Error: _buktiKematianKepalaKeluarga is null for KK Baru (Pergantian Kepala Keluarga).");
        }
      } else if (_alasanPembuatan == 'KK Baru (Pindah Datang)') {
        if (_buktiSKPD == null) {
          isValid = false;
          print("Error: _buktiSKPD is null for KK Baru (Pindah Datang or Pindah WNI dari luar negeri).");
        }
      } else if (_alasanPembuatan == 'KK Baru (Pindah WNI dari luar negeri)') {
        if (_buktiSKPLN == null) {
          isValid = false;
          print("Error: _buktiSKPLN is null for KK Baru (Pindah Datang or Pindah WNI dari luar negeri).");
        }
      } else if (_alasanPembuatan == 'KK Perubahan (Peristiwa penting)') {
        if (_buktiPerubahanPeristiwa == null) {
          isValid = false;
          print("Error: _buktiPerubahanPeristiwa is null for KK Perubahan (Peristiwa penting).");
        }
      }

      if (isValid) {
        final newKk = Kk(
          alasanPembuatan: _alasanPembuatan!,
          namaLengkap: _namaLengkap!,
          nomorNIK: _nomorNIK!,
          nomorKK: _nomorKK!,
          nomorHandphone: _nomorHandphone!,
          email: _email!,
          buktiKehilangan: _buktiKehilangan?.path ?? '',
          buktiStatusHubungan: _buktiStatusHubungan?.path ?? '',
          buktiKKLama: _buktiKKLama?.path ?? '',
          buktiKematianKepalaKeluarga: _buktiKematianKepalaKeluarga?.path ?? '',
          buktiSKPD: _buktiSKPD?.path ?? '',
          buktiSKPLN: _buktiSKPLN?.path ?? '',
          suratPengantar: _suratPengantar?.path ?? '',
          suratPernyataanKependudukan: _suratPernyataanKependudukan?.path ?? '',
          buktiPerubahanPeristiwa: _buktiPerubahanPeristiwa?.path ?? '',
          dokumenTambahan: _dokumenTambahan?.path ?? '',
        );

        final dbKk = DatabaseKk.instance;
        await dbKk.insertKk(newKk);

        Navigator.pop(context);
      } else {
        print("Error: Required documents are missing based on the selected Alasan Pembuatan.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4297A0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
                    _buildDropdownField(
                      context: context,
                      label: 'Alasan Pembuatan',
                      items: [
                        'KK hilang/rusak',
                        'KK Baru (membentuk Keluarga baru)',
                        'KK Baru (Pergantian Kepala Keluarga)',
                        'KK Baru (Pindah Datang)',
                        'KK Baru (Pindah WNI dari luar negeri)',
                        'KK Baru (Rentan Adminduk)',
                        'KK Perubahan (Peristiwa penting)'
                      ],
                      currentValue: _alasanPembuatan,
                      onSave: (value) {
                        _alasanPembuatan = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Alasan Pembuatan tidak boleh kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _alasanPembuatan = value!;
                        });
                      },
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
                      onSave: (value) => _namaLengkap = value,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Nomor Induk Kependudukan',
                      hint: 'nomor induk kependudukan',
                      isNumber: true,
                      onSave: (value) => _nomorNIK = value != null ? int.tryParse(value) : null,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Nomor Kartu Keluarga',
                      hint: 'nomor kartu keluarga',
                      isNumber: true,
                      onSave: (value) => _nomorKK = value != null ? int.tryParse(value) : null,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Nomor Handphone',
                      hint: 'nomor handphone',
                      isNumber: true,
                      onSave: (value) => _nomorHandphone = value != null ? int.tryParse(value) : null,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Email',
                      hint: 'alamat email',
                      onSave: (value) => _email = value,
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
                    if (_alasanPembuatan == 'KK hilang/rusak') ...[
                      _buildSubTitleWithItalic(
                        'Kartu Keluarga Lama (rusak)',
                        ' atau ',
                        'Surat Kehilangan dari Kepolisian',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _buktiKehilangan = file;
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
                                          _buktiKehilangan != null
                                              ? _buktiKehilangan!.path.split('/').last
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
                            if (_buktiKehilangan != null)
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
                                        _buktiKehilangan = null;
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
                    ] else if (_alasanPembuatan ==
                        'KK Baru (membentuk Keluarga baru)') ...[
                      _buildSubTitleWithNormal(
                        'Buku nikah/kutipan akta perkawinan',
                        ' atau ',
                        'kutipan akta perceraian',
                        ' atau ',
                        'Surat Pernyataan Tanggung Jawab Mutlak (SPTJM) perkawinan/perceraian belum tercatat',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _buktiStatusHubungan = file;
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
                                          _buktiStatusHubungan != null
                                              ? _buktiStatusHubungan!.path.split('/').last
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
                            if (_buktiStatusHubungan != null)
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
                                        _buktiStatusHubungan = null;
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
                    ] else if (_alasanPembuatan ==
                        'KK Baru (Pergantian Kepala Keluarga)') ...[
                      _buildSubTitle('Kartu Keluarga Lama'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _buktiKKLama = file;
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
                                          _buktiKKLama != null
                                              ? _buktiKKLama!.path.split('/').last
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
                            if (_buktiKKLama != null)
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
                                        _buktiKKLama = null;
                                      });
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _buildSubTitle('Surat Keterangan Kematian Kepala Keluarga'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _buktiKematianKepalaKeluarga = file;
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
                                          _buktiKKLama != null
                                              ? _buktiKKLama!.path.split('/').last
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
                            if (_buktiKematianKepalaKeluarga != null)
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
                                        _buktiKematianKepalaKeluarga = null;
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
                    ] else if (_alasanPembuatan == 'KK Baru (Pindah Datang)') ...[
                      _boxBuild(context),
                      _buildSubTitle('Surat Keterangan Pindah Datang (SKPD)'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _buktiSKPD = file;
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
                                          _buktiSKPD != null
                                              ? _buktiSKPD!.path.split('/').last
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
                            if (_buktiSKPD != null)
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
                                        _buktiSKPD = null;
                                      });
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _buildSubTitle('Kartu Keluarga Lama'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _buktiKKLama = file;
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
                                          _buktiKKLama != null
                                              ? _buktiKKLama!.path.split('/').last
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
                            if (_buktiKKLama != null)
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
                                        _buktiKKLama = null;
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
                    ] else if (_alasanPembuatan ==
                        'KK Baru (Pindah WNI dari luar negeri)') ...[
                      _buildSubTitle(
                          'Surat Keterangan Pindah Luar Negeri (SKPLN)'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _buktiSKPLN = file;
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
                                          _buktiSKPLN != null
                                              ? _buktiSKPLN!.path.split('/').last
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
                            if (_buktiSKPLN != null)
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
                                        _buktiSKPLN = null;
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
                    ] else if (_alasanPembuatan == 'KK Baru (Rentan Adminduk)') ...[
                      _buildSubTitle('Surat Pengantar RT dan RW'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _suratPengantar = file;
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
                                          _suratPengantar != null
                                              ? _suratPengantar!.path.split('/').last
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
                            if (_suratPengantar != null)
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
                                        _suratPengantar = null;
                                      });
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _buildSubTitle(
                          'Surat Pernyataan Tidak Memiliki Dokumen Kependudukan'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _suratPernyataanKependudukan = file;
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
                                          _suratPernyataanKependudukan != null
                                              ? _suratPernyataanKependudukan!.path.split('/').last
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
                            if (_suratPernyataanKependudukan != null)
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
                                        _suratPernyataanKependudukan = null;
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
                    ] else if (_alasanPembuatan ==
                        'KK Perubahan (Peristiwa penting)') ...[
                      _buildSubTitle('Kartu Keluarga Lama'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _buktiKKLama = file;
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
                                          _buktiKKLama != null
                                              ? _buktiKKLama!.path.split('/').last
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
                            if (_buktiKKLama != null)
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
                                        _buktiKKLama = null;
                                      });
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _textJustify(
                        'Bukti Perubahan Peristiwa Kependudukan dan Peristiwa Penting ',
                        '\nContoh: Kelahiran, Perkawinan, Pembatalan Perkawinan, Perceraian, Pembatalan Perceraian, Kematian, Pengangkatan Anak, Pengakuan Anak, Pengesahan Anak, Perubahan Nama, Perubahan Status Kewarganegaraan, Pembetulan Akta dan Pembatalan Akta',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _buktiPerubahanPeristiwa = file;
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
                                          _buktiPerubahanPeristiwa != null
                                              ? _buktiPerubahanPeristiwa!.path.split('/').last
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
                            if (_buktiPerubahanPeristiwa != null)
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
                                        _buktiPerubahanPeristiwa = null;
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
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: Form(
                  child: ElevatedButton(
                    onPressed: _submitForm, // ini buat handle submit nya thinnn
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFCDC2AE),
                      padding: EdgeInsets.symmetric(horizontal: 40),
                    ),
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
              ),
            ],
          ),
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
    bool isNumber = false,
    required FormFieldSetter<String?> onSave,
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
          TextFormField(
            onSaved: (value) {
              if (isNumber) {
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
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                fontFamily: 'Ubuntu',
              ),
              filled: true,
              fillColor: Color(0xFFE0E5E7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required List<String> items,
    required FormFieldSetter<String?> onSave,
    required FormFieldValidator<String?> validator,
    String? currentValue,
    ValueChanged<String?>? onChanged,
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
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: InputBorder.none,
              ),
              value: items.contains(currentValue) ? currentValue : null,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _alasanPembuatan = value; // Update _alasanPembuatan jika dropdown ini digunakan untuk alasan pembuatan
                });
                if (onChanged != null) {
                  onChanged(value);
                }
              },
              onSaved: onSave,
              validator: validator,
              dropdownColor: Colors.white,
              isExpanded: true,
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
}