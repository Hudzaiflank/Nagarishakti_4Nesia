import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '/Database/database_user.dart';
import 'dart:io';

class EditUserProfilePage extends StatefulWidget {
  const EditUserProfilePage({super.key});

  @override
  _EditUserProfilePageState createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _gender;
  File? _image;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _namaLengkapController;
  late TextEditingController _gambarController;
  late TextEditingController _tempatLahirController;
  late TextEditingController _tanggalLahirController;
  late TextEditingController _alamatLengkapController;
  late TextEditingController _agamaController;
  late TextEditingController _jenisPekerjaanController;
  late TextEditingController _jenisKelaminController;
  late TextEditingController _noTeleponController;
  late TextEditingController _noRekeningController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _namaLengkapController = TextEditingController();
    _gambarController = TextEditingController();
    _tempatLahirController = TextEditingController();
    _tanggalLahirController = TextEditingController();
    _alamatLengkapController = TextEditingController();
    _agamaController = TextEditingController();
    _jenisPekerjaanController = TextEditingController();
    _jenisKelaminController = TextEditingController();
    _noTeleponController = TextEditingController();
    _noRekeningController = TextEditingController();
    _loadUserInfo();
  }

    Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('loggedInUsername') ?? '';

    if (username.isNotEmpty) {
      final dbUser = DatabaseUser.instance;
      final registers = await dbUser.getRegisters();

      final user = registers.firstWhere(
        (register) => register.username == username,
        orElse: () => Register(
          username: 'N/A',
          password: 'N/A',
          gambar: 'assets/user-home/profile-logo.png',
          namaLengkap: 'N/A',
          tempatLahir: 'N/A',
          tanggalLahir: DateTime(2000, 2, 29),
          alamatLengkap: 'N/A',
          agama: 'N/A',
          jenisPekerjaan: 'N/A',
          jenisKelamin: 'N/A',
          noTelepon: 0,
          noRekening: 0,
        ),
      );

      setState(() {
        _usernameController.text = user.username;
        _passwordController.text = user.password;
        _namaLengkapController.text = user.namaLengkap;
        _gambarController.text = user.gambar;
        _image = File(user.gambar);
        _tempatLahirController.text = user.tempatLahir;
        _selectedDate = user.tanggalLahir;
        _tanggalLahirController.text = DateFormat('yyyy-MM-dd').format(user.tanggalLahir);
        _alamatLengkapController.text = user.alamatLengkap;
        _agamaController.text = user.agama;
        _jenisPekerjaanController.text = user.jenisPekerjaan;
        _gender = user.jenisKelamin;
        _noTeleponController.text = user.noTelepon.toString();
        _noRekeningController.text = user.noRekening.toString();
      });
    }
  }

  @override
  void dispose() {
    _gambarController.dispose();
    _namaLengkapController.dispose();
    _tempatLahirController.dispose();
    _tanggalLahirController.dispose();
    _alamatLengkapController.dispose();
    _agamaController.dispose();
    _jenisPekerjaanController.dispose();
    _jenisKelaminController.dispose();
    _noTeleponController.dispose();
    _noRekeningController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4297A0), // Background color
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFE2DED0),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 60), // Space from top to title
                const Center(
                  child: Text(
                    'UBAH PROFIL',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FCFC),
                              borderRadius: BorderRadius.circular(7.0),
                              border: Border.all(color: const Color(0xFF4297A0)),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildProfilePictureFeature(),
                                  _buildTextField(
                                    label: 'Nama Lengkap',
                                    hint: 'BUDI WIJAYA',
                                    controller: _namaLengkapController,
                                  ),
                                  _buildTextField(
                                    label: 'Tempat Lahir',
                                    hint: 'Sukabumi',
                                    controller: _tempatLahirController,
                                  ),
                                  _buildDateField(
                                    hint: _tanggalLahirController.text,
                                    selectedDate: _selectedDate,
                                    onSelect: (date) => setState(() {
                                      _selectedDate = date;
                                      _tanggalLahirController.text = DateFormat('yyyy-MM-dd').format(date);
                                    }),
                                  ),
                                  _buildTextField(
                                    label: 'Alamat Lengkap',
                                    hint: 'Jl. Veteran II, Selabatu, Kec. Cikole, Sukabumi',
                                    controller: _alamatLengkapController,
                                  ),
                                  _buildTextField(
                                    label: 'Agama',
                                    hint: 'Islam',
                                    controller: _agamaController,
                                  ),
                                  _buildTextField(
                                    label: 'Jenis Pekerjaan',
                                    hint: 'Karyawan Swasta',
                                    controller: _jenisPekerjaanController,
                                  ),
                                  _buildGenderField(),
                                  _buildTextField(
                                    label: 'Nomor Telepon',
                                    hint: '081236484878',
                                    controller: _noTeleponController,
                                    keyboardType: TextInputType.phone,
                                  ),
                                  _buildTextField(
                                    label: 'Nomor Rekening',
                                    hint: '13122349826',
                                    controller: _noRekeningController,
                                    keyboardType: TextInputType.number,
                                  ),
                                  _buildTextField(
                                    label: 'Username',
                                    hint: 'budywjy_',
                                    controller: _usernameController,
                                  ),
                                  _buildTextField(
                                    label: 'Password',
                                    hint: '********',
                                    controller: _passwordController,
                                    obscureText: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 41),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final updatedRegister = Register(
                                        username: _usernameController.text,
                                        password: _passwordController.text,
                                        namaLengkap: _namaLengkapController.text,
                                        gambar: _gambarController.text,
                                        tempatLahir: _tempatLahirController.text,
                                        tanggalLahir: _selectedDate ?? DateTime.now(),
                                        alamatLengkap: _alamatLengkapController.text,
                                        agama: _agamaController.text,
                                        jenisPekerjaan: _jenisPekerjaanController.text,
                                        jenisKelamin: _gender ?? '',
                                        noTelepon: int.tryParse(_noTeleponController.text) ?? 0,
                                        noRekening: int.tryParse(_noRekeningController.text) ?? 0,
                                      );

                                      final dbUser = DatabaseUser.instance;
                                      await dbUser.updateRegister(updatedRegister);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Data berhasil diubah')),
                                      );

                                      Navigator.pop(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFCDC2AE),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6.0, // Top and bottom padding
                                      horizontal:
                                          45.0, // Left and right padding
                                    ),
                                  ),
                                  child: const Text(
                                    'SIMPAN',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Ubuntu',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    height: 23), // Space from button to bottom
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

    Widget buildProfilePictureFeature() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Foto Profil',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            backgroundImage: _image != null ? FileImage(_image!) : const AssetImage('assets/user-home/profile-logo.png') as ImageProvider<Object>,
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: () {
                _showImagePickerOptions(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showImagePickerOptions(BuildContext context) async {
    final picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Ambil dari Kamera'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari Galeri'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget buildProfilePictureFeature() {
  //   return Column(
  //     children: [
  //       Center(
  //         child: GestureDetector(
  //           onTap: _pickImage,
  //           child: CircleAvatar(
  //             radius: 50,
  //             backgroundImage: _image != null
  //                 ? FileImage(_image!)
  //                 : const AssetImage('assets/user-home/profile-logo.png') as ImageProvider,
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 10),
  //       const Center(
  //         child: Text(
  //           'Ubah Foto Profil',
  //           style: TextStyle(
  //             fontFamily: 'Ubuntu',
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold,
  //             color: Color(0xFF4297A0),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Future<void> _pickImage() async {
  //   final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //       _gambarController.text = pickedFile.path; // Update gambarController
  //     });
  //   }
  // }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFE0E5E7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
              hintText: hint,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDateField({
    required String hint,
    required DateTime? selectedDate,
    required void Function(DateTime) onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tanggal Lahir',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFE0E5E7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                      hintText: hint,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != selectedDate) {
                        onSelect(picked);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && picked != selectedDate) {
                    onSelect(picked);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F5061),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Icon(Icons.calendar_today, color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
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
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            Row(
              children: [
                Radio(
                  value: 'Laki-Laki',
                  groupValue: _gender,
                  onChanged: (String? value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                const Text('Laki-Laki'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 'Perempuan',
                  groupValue: _gender,
                  onChanged: (String? value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                const Text('Perempuan'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

    // Widget buildProfilePictureFeature() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'Foto Profil',
  //         style: TextStyle(
  //           fontFamily: 'Ubuntu',
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       const SizedBox(height: 10),
  //       SizedBox(
  //         height: 40,
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: Container(
  //                 height: 40,
  //                 decoration: BoxDecoration(
  //                   color: const Color(0xFFE0E5E7),
  //                   borderRadius: BorderRadius.circular(7),
  //                 ),
  //                 child: const Center(
  //                   child: Text(
  //                     'Pastikan foto terpilih',
  //                     style: TextStyle(
  //                       fontFamily: 'Ubuntu',
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(width: 10),
  //             ElevatedButton(
  //               onPressed: () {
  //                 // kode image_picker disini nanti ya thin
  //                 _showImagePickerOptions();
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: const Color(0xFF2F5061),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(7),
  //                 ),
  //               ),
  //               child: const Text(
  //                 'Pilih Foto',
  //                 style: TextStyle(
  //                   fontFamily: 'Ubuntu',
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 10),
  //     ],
  //   );
  // }

  // void _showImagePickerOptions() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return SafeArea(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListTile(
  //               leading: const Icon(Icons.camera),
  //               title: const Text('Take a photo'),
  //               onTap: () {
  //                 _pickImage(ImageSource.camera);
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.photo_library),
  //               title: const Text('Choose from gallery'),
  //               onTap: () {
  //                 _pickImage(ImageSource.gallery);
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<void> _pickImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() {
  //       // Update the image
  //     });
  //   }
  // }
}
