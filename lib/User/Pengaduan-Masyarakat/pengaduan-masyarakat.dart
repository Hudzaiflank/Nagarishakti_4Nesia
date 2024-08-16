import 'dart:io';
import 'package:flutter/material.dart';
import '/Database/database_pengaduan.dart';
import 'package:file_picker/file_picker.dart';

class PengaduanMasyarakat extends StatefulWidget {
  const PengaduanMasyarakat({super.key});

  @override
  _PengaduanMasyarakat createState() => _PengaduanMasyarakat();
}

class _PengaduanMasyarakat extends State<PengaduanMasyarakat> {
  final _formKey = GlobalKey<FormState>();
  String? _subjekAduan;
  String? _deskripsi;
  DateTime? _selectedDateKejadian;
  String? _lokasiLengkap;
  String? _instansiTujuan;
  String? _anonimitas;
  String? _namaAnonimitas;
  int? _noTelepon;
  File? _kkOrangTua;

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

      final newPengaduan = Pengaduan(
        subjekAduan: _subjekAduan!,
        deskripsi: _deskripsi!,
        tanggalKejadian: _selectedDateKejadian!,
        lokasiLengkap: _lokasiLengkap!,
        instansiTujuan: _instansiTujuan!,
        anonimitas: _anonimitas!,
        namaAnonimitas: _namaAnonimitas!,
        noTelepon: _noTelepon!,
        kkOrangTua: _kkOrangTua!.path,
      );

      final dbPengaduan = DatabasePengaduan.instance;
      await dbPengaduan.insertPengaduanMasyarakat(newPengaduan);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFECF5F6),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Container(
            padding: const EdgeInsets.only(top: 35),
            decoration: const BoxDecoration(
              color: Color(0xFF3AB3B1),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(7.0)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE2DED0),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'AJUKAN KELUHAN',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  _buildSection(
                    title: '',
                    fields: [
                      _buildTextField(
                        context: context,
                        label: 'Subjek Aduan',
                        hint: 'tulis nama lengkap anda',
                        onSave: (value) => _subjekAduan = value,
                      ),
                      _buildTextField(
                        context: context,
                        label: 'Deskripsi',
                        hint: 'deskripsi lengkap',
                        onSave: (value) => _deskripsi = value,
                      ),
                      _buildDatePickerField(
                        context: context,
                        label: 'Tanggal Kejadian',
                        selectedDate: _selectedDateKejadian,
                        onSelect: (date) {
                          setState(() {
                            _selectedDateKejadian = date;
                          });
                        },
                        onSave: (value) => null,
                        validator: (value) {
                          if (_selectedDateKejadian == null) {
                            return 'Tanggal Kejadian tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        context: context,
                        label: 'Lokasi Lengkap',
                        hint: 'alamat subjek keluhan',
                        onSave: (value) => _lokasiLengkap = value,
                      ),
                      _buildDropdownField(
                        context: context,
                        label: 'Instansi Tujuan',
                        items: ['Disdukcapil', 'Kominfo', 'Dishub'],
                        onSave: (value) => _instansiTujuan = value,
                      ),
                      _buildRadioField(
                        context: context,
                        label: 'Anonimitas',
                        items: ['Anonim', 'Sertakan Nama'],
                        groupValue: _anonimitas,
                        onSaved: (value) => _anonimitas = value,
                        onChanged: (value) {
                          setState(() {
                            _anonimitas = value;
                          });
                        },
                      ),
                      _buildTextField(
                        context: context,
                        label: 'Nomor Telepon',
                        hint: '+62 ...',
                        isNumber: true,
                        onSave: (value) => _noTelepon = value != null ? int.tryParse(value) : null,
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
                                      // ini nanti buat remove nya thinnn mas broo);
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
                    ],
                  ),
                  SizedBox(height: 34),
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
                            'AJUKAN',
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
                ],
              ),
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
                SizedBox(height: 2),
              ],
            ),
          ),
          ...fields,
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

  Widget _buildRadioField({
    required BuildContext context,
    required String label,
    required List<String> items,
    required String? groupValue,
    required void Function(String?)? onSaved,
    required ValueChanged<String?> onChanged,
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
                      onChanged(value);
                      setState(() {
                        if (value == 'Sertakan Nama') {
                          _anonimitas = 'Sertakan Nama';
                        } else if (value == 'Anonim') {
                          _namaAnonimitas = null;
                        }
                      });
                    },
                    activeColor: Colors.black,
                  );
                }).toList(),
              ),
              if (groupValue == 'Sertakan Nama')
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _buildTextField(
                    context: context,
                    label: 'Nama Anonimitas',
                    hint: '',
                    onSave: (value) => _namaAnonimitas = value,
                  ),
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
