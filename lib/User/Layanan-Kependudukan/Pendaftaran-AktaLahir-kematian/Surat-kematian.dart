import 'dart:io';
import 'package:flutter/material.dart';
import '/Database/database_suratKematian.dart';
import 'package:file_picker/file_picker.dart';

class SuratKematian extends StatefulWidget {
  const SuratKematian({super.key});

  @override
  _SuratKematianState createState() => _SuratKematianState();
}

class _SuratKematianState extends State<SuratKematian> {
  final _formKey = GlobalKey<FormState>();
  int? _nikPemohon;
  int? _umurPemohon;
  int? _nikAlmarhum;
  String? _namaPemohon;
  String? _hubunganPemohon;
  String? _namaAlmarhum;
  String? _jenisKelaminAlmarhum;
  String? _hariKematianAlmarhum;
  String? _waktuKematianAlmarhum;
  String? _tempatKematianAlmarhum;
  String? _penyebabKematianAlmarhum;
  String? _buktiKematianAlmarhum;
  DateTime? _selectedDateKematian;
  File? _suratKematianAlmarhum;
  File? _ktpPemohon;
  File? _ktpAlmarhum;
  File? _kkAlmarhum;

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

      final newKematian = Kematian(
        nikPemohon: _nikPemohon!,
        namaPemohon: _namaPemohon!,
        umurPemohon: _umurPemohon!,
        hubunganPemohon: _hubunganPemohon!,
        nikAlmarhum: _nikAlmarhum!,
        namaAlmarhum: _namaAlmarhum!,
        jenisKelaminAlmarhum: _jenisKelaminAlmarhum!,
        tanggalKematianAlmarhum: _selectedDateKematian!,
        hariKematianAlmarhum: _hariKematianAlmarhum!,
        waktuKematianAlmarhum: _waktuKematianAlmarhum!,
        tempatKematianAlmarhum: _tempatKematianAlmarhum!,      
        penyebabKematianAlmarhum: _penyebabKematianAlmarhum!,
        buktiKematianAlmarhum: _buktiKematianAlmarhum!,      
        suratKematianAlmarhum: _suratKematianAlmarhum!.path,
        ktpPemohon: _ktpPemohon!.path,
        ktpAlmarhum: _ktpAlmarhum!.path,
        kkAlmarhum: _kkAlmarhum!.path,
      );

      final dbKematian = DatabaseSuratKematian.instance;
      await dbKematian.insertSuratKematian(newKematian);

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
                        'FORMULIR PERMOHONAN SURAT KEMATIAN',
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
                  title: 'DATA PEMOHON',
                  fields: [
                    _buildTextField(
                      context: context,
                      label: 'NIK Pemohon',
                      hint: 'nomor induk kependudukan pelapor',
                      isNumber: true,
                      onSave: (value) => _nikPemohon = value != null ? int.tryParse(value) : null,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Nama Lengkap',
                      hint: 'tulis nama lengkap pelapor',
                      onSave: (value) => _namaPemohon = value,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Umur',
                      hint: 'Umur Pemohon',
                      isNumber: true,
                      onSave: (value) => _umurPemohon = value != null ? int.tryParse(value) : null,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Hubungan Dengan Yang Mati',
                      hint: '',
                      onSave: (value) => _hubunganPemohon = value,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildSection(
                  title: 'DATA YANG BERSANGKUTAN',
                  fields: [
                    _buildTextField(
                      context: context,
                      label: 'NIK',
                      hint: 'nomor induk kependudukan',
                      isNumber: true,
                      onSave: (value) => _nikAlmarhum = value != null ? int.tryParse(value) : null,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Nama Lengkap',
                      hint: 'tulis nama lengkap  dengan huruf kapital',
                      onSave: (value) => _namaAlmarhum = value,
                    ),
                    _buildRadioField(
                      context: context,
                      label: 'Jenis Kelamin',
                      items: ['Pria', 'Wanita'],
                      groupValue: _jenisKelaminAlmarhum,
                      onSaved: (value) => _jenisKelaminAlmarhum = value,
                    ),
                    _buildDropdownField(
                      context: context,
                      label: 'Hari Kematian',
                      items: [
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ],
                      currentValue: _hariKematianAlmarhum,
                      onSave: (value) => _hariKematianAlmarhum = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Hari Kematian tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    _buildDatePickerField(
                      context: context,
                      label: 'Tanggal Kematian',
                      selectedDate: _selectedDateKematian,
                      onSelect: (date) {
                        setState(() {
                          _selectedDateKematian = date;
                        });
                      },
                      onSave: (value) => null,
                      validator: (value) {
                        if (_selectedDateKematian == null) {
                          return 'Tanggal Kematian tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Waktu Kematian',
                      hint: 'jam Kematian',
                      onSave: (value) => _waktuKematianAlmarhum = value,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Tempat Kematian',
                      hint: 'Tempat Kematian',
                      onSave: (value) => _tempatKematianAlmarhum = value,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Penyebab Kematian',
                      hint: 'Penyebab Kematian',
                      onSave: (value) => _penyebabKematianAlmarhum = value,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Bukti Kematian',
                      hint: 'Penjelasan Bukti Kematian',
                      onSave: (value) => _buktiKematianAlmarhum = value,
                    ),
                  ],
                ),
                SizedBox(height: 34),
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
                      _textJustify('Surat Keterangan Kematian',
                          '\n dari Dokter jika meninggal di Rumah Sakit, atau dari Kepala Desa/Kelurahan jika meninggal di Rumah'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _suratKematianAlmarhum = file;
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
                                          _suratKematianAlmarhum != null
                                              ? _suratKematianAlmarhum!.path.split('/').last
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
                            if (_suratKematianAlmarhum != null)
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
                                        _suratKematianAlmarhum = null;
                                      });
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _buildSubTitle('KTP Pemohon'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _ktpPemohon = file;
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
                                          _ktpPemohon != null
                                              ? _ktpPemohon!.path.split('/').last
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
                            if (_ktpPemohon != null)
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
                                        _ktpPemohon = null;
                                      });
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _buildSubTitle('KTP yang Meninggal / Surat Domisili'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _ktpAlmarhum = file;
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
                                          _ktpAlmarhum != null
                                              ? _ktpAlmarhum!.path.split('/').last
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
                            if (_ktpAlmarhum != null)
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
                                        _ktpAlmarhum = null;
                                      });
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _buildSubTitle('KK Asli (masih dengan Almarhum)'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ini buat handle upload document nya thin
                                await _pickFile((file) {
                                  _kkAlmarhum = file;
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
                                          _kkAlmarhum != null
                                              ? _kkAlmarhum!.path.split('/').last
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
                            if (_kkAlmarhum != null)
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
                                        _kkAlmarhum = null;
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
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Form(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2F5061),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                        ),
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
              fillColor: Colors.white,
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
              value: currentValue, 
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (value) {},
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
}
