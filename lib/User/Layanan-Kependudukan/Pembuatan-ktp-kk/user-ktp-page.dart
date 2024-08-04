import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import '/Database/database_ktp.dart';
import 'package:file_picker/file_picker.dart';

class UserKtpPage extends StatefulWidget {
  const UserKtpPage({super.key});

  @override
  _UserKtpPageState createState() => _UserKtpPageState();
}

class _UserKtpPageState extends State<UserKtpPage> {
  final _formKey = GlobalKey<FormState>();
  String? _alasanPembuatan;
  int? _nik;
  String? _namaLengkap;
  String? _tempatLahir;
  DateTime? _selectedDate;
  String? _jenisKelamin;
  String? _alamatLengkap;
  String? _agama;
  String? _jenisPekerjaan;
  String? _statusPerkawinan;
  File? _kartuKeluarga;
  File? _suratPengantar;
  File? _buktiKehilangan;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
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

      final newKtp = Ktp(
        alasanPembuatan: _alasanPembuatan!,
        nik: _nik!,
        namaLengkap: _namaLengkap!,
        tempatLahir: _tempatLahir!,
        tanggalLahir: _selectedDate!,
        alamatLengkap: _alamatLengkap!,
        agama: _agama!,
        jenisPekerjaan: _jenisPekerjaan!,
        jenisKelamin: _jenisKelamin!,
        statusPerkawinan: _statusPerkawinan!,
        kartuKeluarga: _kartuKeluarga!,
        suratPengantar: _suratPengantar!,
        buktiKehilangan: _buktiKehilangan!,
      );

      final dbKtp = DatabaseKtp.instance;
      await dbKtp.insertKtp(newKtp);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
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
                      context, 
                      ['Telah berusia 17 tahun', 'KTP hilang/rusak'],
                      onSave: (value) => _alasanPembuatan = value,
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
                  _buildTextField(
                    context: context,
                    label: 'NIK',
                    hint: 'nomor induk kependudukan',
                    keyboardType: TextInputType.number,
                    onSave: (value) => _nik = int.tryParse(value!),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'NIK tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Nama Lengkap',
                    hint: 'nama lengkap huruf kapital',
                    onSave: (value) => _namaLengkap = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama Lengkap tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Tempat Lahir',
                    hint: 'tempat lahir',
                    onSave: (value) => _tempatLahir = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tempat Lahir tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Tanggal Lahir',
                    hint: 'TTTT-BB-HH',
                    isDateField: true,
                    selectedDate: _selectedDate,
                    onSelect: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                    onSave: (value) => null,
                    validator: (value) {
                      if (_selectedDate == null) {
                        return 'Tanggal Lahir tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  _buildRadioButtonGroup(
                    label: 'Jenis Kelamin',
                    onSave: (value) => _jenisKelamin = value,
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Alamat Lengkap',
                    hint: 'alamat sesuai KTP',
                    onSave: (value) => _alamatLengkap = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat Lengkap tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Agama',
                    hint: 'agama',
                    onSave: (value) => _agama = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Agama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    context: context,
                    label: 'Jenis Pekerjaan',
                    hint: 'jenis pekerjaan',
                    onSave: (value) => _jenisPekerjaan = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Jenis Pekerjaan tidak boleh kosong';
                      }
                      return null;
                    },
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
                      onSave: (value) => _statusPerkawinan = value,
                      backgroundColor: Color(0xFFE0E5E7),
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
                  _buildSubTitle('Kartu Keluarga'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // ini buat handle upload document nya thin
                            await _pickFile((file) {
                              _kartuKeluarga = file;
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
                                _removeFile(() {
                                  _kartuKeluarga = null;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_alasanPembuatan == 'Telah berusia 17 tahun') ...[
                    _buildSubTitle('Surat Pengantar Desa/Kelurahan'),
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
                  ] else if (_alasanPembuatan == 'KTP hilang/rusak') ...[
                    _buildSubTitleWithItalic('KTP Lama', ' atau',
                        '\nSurat Kehilangan dari Kepolisian'),
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
                  ],
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Center(
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

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String hint,
    required FormFieldSetter<String> onSave,
    required FormFieldValidator<String> validator,
    TextInputType keyboardType = TextInputType.text,
    bool isDateField = false,
    DateTime? selectedDate,
    ValueChanged<DateTime>? onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubTitle(label),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextFormField(
            keyboardType: keyboardType,
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
                    if (date != null && onSelect != null) {
                      onSelect(date);
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
            validator: validator,
            onSaved: onSave,
            controller: isDateField && selectedDate != null
                ? TextEditingController(
                    text: "${selectedDate.toLocal()}".split(' ')[0])
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(BuildContext context, List<String> items,
      {String? label, Color backgroundColor = Colors.white, Function(String?)? onSave}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) _buildSubTitle(label),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: DropdownButtonFormField<String>(
            value: items.contains(_alasanPembuatan) ? _alasanPembuatan : items.contains(_statusPerkawinan) ? _statusPerkawinan : null,
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
                .map((label) => DropdownMenuItem<String>(
                      value: label,
                      child: Text(
                        label,
                        style: TextStyle(
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                if (items.contains(_alasanPembuatan)) {
                  _alasanPembuatan = value!;
                } else if (items.contains(_statusPerkawinan)) {
                  _statusPerkawinan = value!;
                }
              });
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
          ),
        ),
      ],
    );
  }

  Widget _buildRadioButton(String title, String? groupValue, {Function(String?)? onSave}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: RadioListTile<String>(
        title: Text(title, style: TextStyle(fontFamily: 'Ubuntu')),
        value: title,
        groupValue: groupValue,
        onChanged: (value) {
          setState(() {
            _jenisKelamin = value;
          });
        },
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  Widget _buildRadioButtonGroup({required String label, Function(String?)? onSave}) {
    return FormField<String>(
      onSaved: onSave,
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
            _buildSubTitle(label),
            _buildRadioButton('Pria', _jenisKelamin, onSave: (value) {
              state.didChange(value);
              _jenisKelamin = value;
            }),
            _buildRadioButton('Wanita', _jenisKelamin, onSave: (value) {
              state.didChange(value);
              _jenisKelamin = value;
            }),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                child: Text(
                  state.errorText!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
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