import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/Database/database_user.dart';
import 'login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

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
  final String _gambar = 'assets/user-home/profile-logo.png'; 
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
        gambar: _gambar,
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
      await dbUser.insertRegisters(newUser);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF5F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/icon.png', height: 100),
                    const SizedBox(height: 10),
                    const Text(
                      'REGISTRASI AKUN',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sudah memiliki akun?',
                            style: TextStyle(fontFamily: 'Ubuntu')),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()
                              ),
                            );
                          },
                          child: const Text(
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
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF4297A0),
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(color: const Color(0xFF4297A0)),
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
                      const SizedBox(height: 41),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2F5061),
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                          ),
                          child: const Text(
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Ubuntu',
          ),
        ),
        const SizedBox(height: 5),
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
            hintStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
              fontFamily: 'Ubuntu',
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 15),
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Ubuntu',
          ),
        ),
        const SizedBox(height: 5),
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
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? hint
                      : DateFormat('dd-MM-yyyy').format(selectedDate),
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jenis Kelamin',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Ubuntu',
          ),
        ),
        const SizedBox(height: 5),
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
        const SizedBox(height: 15),
      ],
    );
  }
}
