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
  DateTime? _selectedDateLahir;
  String? _jenisKelamin;
  String? _alamatLengkap;
  String? _agama;
  String? _jenisPekerjaan;
  String? _statusPerkawinan;
  File? _kartuKeluarga;
  File? _suratPengantar;
  File? _buktiKehilangan;

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

      bool isValid = true;

      // Validasi dokumen berdasarkan alasan pembuatan
      if (_alasanPembuatan == 'Telah berusia 17 tahun') {
        if (_suratPengantar == null) {
          isValid = false;
          print("Error: _suratPengantar is null for Telah berusia 17 tahun.");
        }
      } else if (_alasanPembuatan == 'KTP hilang/rusak') {
        if (_buktiKehilangan == null) {
          isValid = false;
          print("Error: _buktiKehilangan is null for KTP hilang/rusak.");
        }
      }

      if (isValid) {
        final newKtp = Ktp(
          alasanPembuatan: _alasanPembuatan!,
          nik: _nik!,
          namaLengkap: _namaLengkap!,
          tempatLahir: _tempatLahir!,
          tanggalLahir: _selectedDateLahir!,
          alamatLengkap: _alamatLengkap!,
          agama: _agama!,
          jenisPekerjaan: _jenisPekerjaan!,
          jenisKelamin: _jenisKelamin!,
          statusPerkawinan: _statusPerkawinan!,
          kartuKeluarga: _kartuKeluarga?.path ?? '',
          suratPengantar: _suratPengantar?.path ?? '',
          buktiKehilangan: _buktiKehilangan?.path ?? '',
        );

        final dbKtp = DatabaseKtp.instance;
        await dbKtp.insertKtp(newKtp);

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
                    _buildCustomDropdownField(
                        context: context, 
                        label: 'Alasan Pembuatan',
                        items: ['Telah berusia 17 tahun', 'KTP hilang/rusak'],
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
                      _buildTextField(
                        context: context,
                        label: 'NIK',
                        hint: 'nomor induk kependudukan',
                        isNumber: true,
                        onSave: (value) => _nik = value != null ? int.tryParse(value) : null,
                      ),
                      _buildTextField(
                        context: context,
                        label: 'Nama Lengkap',
                        hint: 'nama lengkap huruf kapital',
                        onSave: (value) => _namaLengkap = value,
                      ),
                      _buildTextField(
                        context: context,
                        label: 'Tempat Lahir',
                        hint: 'tempat lahir',
                        onSave: (value) => _tempatLahir = value,
                      ),
                      _buildDatePickerField(
                        context: context,
                        label: 'Tanggal Lahir',
                        hint: 'TTTT-BB-HH',
                        selectedDate: _selectedDateLahir,
                        onSelect: (date) {
                          setState(() {
                            _selectedDateLahir = date;
                          });
                        },
                        onSave: (value) => null,
                        validator: (value) {
                          if (_selectedDateLahir == null) {
                            return 'Tanggal Lahir tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      _buildRadioField(
                        context: context,
                        label: 'Jenis Kelamin',
                        items: ['Laki-laki', 'Perempuan'],
                        groupValue: _jenisKelamin,
                        onSaved: (value) => _jenisKelamin = value,
                      ),
                      _buildTextField(
                        context: context,
                        label: 'Alamat Lengkap',
                        hint: 'alamat sesuai KTP',
                        onSave: (value) => _alamatLengkap = value,
                      ),
                      _buildTextField(
                        context: context,
                        label: 'Agama',
                        hint: 'agama',
                        onSave: (value) => _agama = value,
                      ),
                      _buildTextField(
                        context: context,
                        label: 'Jenis Pekerjaan',
                        hint: 'jenis pekerjaan',
                        onSave: (value) => _jenisPekerjaan = value,
                      ),
                      _buildDropdownField(
                          context: context,
                          label: 'Status Perkawinan',
                          items: [
                            'Belum menikah',
                            'Sudah menikah',
                            'Cerai hidup',
                            'Cerai mati'
                          ],
                          currentValue: _statusPerkawinan,
                          onSave: (value) => _statusPerkawinan = value,
                           validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Status Perkawinan tidak boleh kosong';
                            }
                            return null;
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
                    _buildSubTitle('Kartu Keluarga',),
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
                                          _kartuKeluarga != null
                                              ? _kartuKeluarga!.path.split('/').last
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
                          if (_kartuKeluarga != null)
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

  Widget _buildCustomDropdownField({
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
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

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required List<String> items,
    String? currentValue,
    required FormFieldSetter<String?> onSave,
    required FormFieldValidator<String?> validator,
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
              color: const Color(0xFFE0E5E7), 
              borderRadius: BorderRadius.circular(7), 
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                fillColor: Color(0xFFE0E5E7),
                filled: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              value: items.contains(currentValue) ? currentValue : null,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _statusPerkawinan = value;
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

  Widget _buildDatePickerField({
    required BuildContext context,
    required String label,
    required String hint,
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
            style: const TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
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
              suffixIcon: const Icon(Icons.calendar_today, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Color(0xFFE0E5E7),
            ),
            onSaved: onSave,
            validator: validator,
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