import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_user.dart';
import 'login.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _gender;
  String? _username;
  String? _password;
  String? _namaLengkap;
  String? _gambar = 'default_image_path'; // Placeholder for image path
  String? _tempatLahir;
  String? _alamatLengkap;
  String? _agama;
  String? _jenisPekerjaan;
  int? _noTelepon;
  int? _noRekening;

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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newUser = Register(
        username: _username!,
        password: _password!,
        namaLengkap: _namaLengkap!,
        gambar: _gambar!,
        tempatLahir: _tempatLahir!,
        tanggalLahir: _selectedDate!,
        alamatLengkap: _alamatLengkap!,
        agama: _agama!,
        jenisPekerjaan: _jenisPekerjaan!,
        jenisKelamin: _gender!,
        noTelepon: _noTelepon!,
        noRekening: _noRekening!,
      );

      final dbUser = DatabaseUser.instance;
      await dbUser.insertRegister(newUser);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF5F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/icon.png', height: 100),
                    SizedBox(height: 10),
                    Text(
                      'REGISTRASI AKUN',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sudah memiliki akun?',
                            style: TextStyle(fontFamily: 'Ubuntu')),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()
                              ),
                            );
                          },
                          child: Text(
                            'klik disini',
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF4297A0),
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(color: Color(0xFF4297A0)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        label: 'Username',
                        hint: 'buat username akun',
                        onSave: (value) => _username = value,
                      ),
                      _buildTextField(
                        label: 'Password',
                        hint: 'buat password yang aman',
                        onSave: (value) => _password = value,
                        obscureText: true,
                      ),
                      _buildTextField(
                        label: 'Nama Lengkap',
                        hint: 'tulis nama lengkap anda',
                        onSave: (value) => _namaLengkap = value,
                      ),
                      _buildTextField(
                        label: 'Tempat Lahir',
                        hint: 'tempat lahir',
                        onSave: (value) => _tempatLahir = value,
                      ),
                      _buildDateField(
                        hint: 'Tanggal Lahir',
                        selectedDate: _selectedDate,
                        onSelect: (date) => setState(() {
                          _selectedDate = date;
                        }),
                      ),
                      _buildTextField(
                        label: 'Alamat Lengkap',
                        hint: 'alamat sesuai KTP',
                        onSave: (value) => _alamatLengkap = value,
                      ),
                      _buildTextField(
                        label: 'Agama',
                        hint: 'agama',
                        onSave: (value) => _agama = value,
                      ),
                      _buildTextField(
                        label: 'Jenis Pekerjaan',
                        hint: 'jenis pekerjaan',
                        onSave: (value) => _jenisPekerjaan = value,
                      ),
                      _buildGenderField(),
                      _buildTextField(
                        label: 'No. Telepon',
                        hint: '+62...',
                        keyboardType: TextInputType.phone,
                        onSave: (value) => _noTelepon = int.parse(value!),
                      ),
                      _buildTextField(
                        label: 'No. Rekening',
                        hint: 'nomor rekening',
                        keyboardType: TextInputType.number,
                        onSave: (value) => _noRekening = int.parse(value!),
                      ),
                      SizedBox(height: 41),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2F5061),
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                          ),
                          child: Text(
                            'MASUK',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required FormFieldSetter<String> onSave,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Ubuntu',
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          onSaved: onSave,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label tidak boleh kosong';
            }
            return null;
          },
          obscureText: obscureText,
          keyboardType: keyboardType,
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
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildDateField({
    required String hint,
    required DateTime? selectedDate,
    required ValueChanged<DateTime> onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Ubuntu',
          ),
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2101),
            );
            if (picked != null) {
              onSelect(picked);
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? hint
                      : DateFormat('dd-MM-yyyy').format(selectedDate),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jenis Kelamin',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Ubuntu',
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: const Text('Laki-Laki',
                    style: TextStyle(fontFamily: 'Ubuntu')),
                leading: Radio<String>(
                  value: 'Laki-Laki',
                  groupValue: _gender,
                  onChanged: (String? value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text('Perempuan',
                    style: TextStyle(fontFamily: 'Ubuntu')),
                leading: Radio<String>(
                  value: 'Perempuan',
                  groupValue: _gender,
                  onChanged: (String? value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
