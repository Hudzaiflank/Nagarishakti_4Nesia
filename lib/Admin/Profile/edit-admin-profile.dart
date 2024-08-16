import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/Database/database_admin.dart';
import 'dart:io';

class EditAdminProfilePage extends StatefulWidget {
  @override
  _EditAdminProfilePageState createState() => _EditAdminProfilePageState();
}

class _EditAdminProfilePageState extends State<EditAdminProfilePage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  final TextEditingController _gambarController = TextEditingController();
  late TextEditingController _namaInstansiController;
  late TextEditingController _alamatInstansiController;
  late TextEditingController _noTeleponController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _namaInstansiController = TextEditingController();
    _alamatInstansiController = TextEditingController();
    _noTeleponController = TextEditingController();
    _emailController = TextEditingController();
    _loadAdminInfo();
  }

  Future<void> _loadAdminInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('loggedInUsername') ?? '';

    if (username.isNotEmpty) {
      final dbAdmin = DatabaseAdmin.instance;
      final registersAdmin = await dbAdmin.getRegistersAdmin();

      final admin = registersAdmin.firstWhere(
        (RegisterAdmin) => RegisterAdmin.username == username,
        orElse: () => RegisterAdmin(
          username: 'N/A',
          password: 'N/A',
          gambar: 'assets/user-home/admin-profile.png',
          namaInstansi: 'N/A',
          alamatInstansi: 'N/A',
          noTelepon: 0,
          email: 'N/A',
        ),
      );

      setState(() {
        _usernameController.text = admin.username;
        _passwordController.text = admin.password;
        _gambarController.text = admin.gambar;
        _image = File(admin.gambar);
        _namaInstansiController.text = admin.namaInstansi;
        _alamatInstansiController.text = admin.alamatInstansi;
        _noTeleponController.text = admin.noTelepon.toString();
        _emailController.text = admin.email;
      });
    }
  }

  @override
  void dispose() {
    _gambarController.dispose();
    _namaInstansiController.dispose();
    _alamatInstansiController.dispose();
    _noTeleponController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4297A0), // Background color
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE2DED0),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 60), // Space from top to title
                Center(
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
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFF9FCFC),
                              borderRadius: BorderRadius.circular(7.0),
                              border: Border.all(color: Color(0xFF4297A0)),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildProfilePictureFeature(),
                                  _buildTextField(
                                    label: 'Nama Instansi',
                                    hint: 'nama instansi daerah',
                                    controller: _namaInstansiController,
                                  ),
                                  _buildBigTextField(
                                    label: 'Alamat Instansi',
                                    hint: 'alamat lengkap intansi',
                                    controller: _alamatInstansiController,
                                  ),
                                  _buildTextField(
                                    label: 'Nomor Telepon',
                                    hint: '08...',
                                    controller: _noTeleponController,
                                    keyboardType: TextInputType.phone,
                                  ),
                                  _buildTextField(
                                    label: 'Email',
                                    hint: 'rinapermata@itd.go.id',
                                    controller: _emailController,
                                  ),
                                  _buildTextField(
                                    label: 'Username',
                                    hint: 'rina_permata',
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
                          SizedBox(height: 41),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      final dbAdmin = DatabaseAdmin.instance;
                                            // Get existing admin by username
                                      final existingAdmin = await dbAdmin.getRegisterAdminByUsername(_usernameController.text);

                                      if (existingAdmin != null && existingAdmin.password == _passwordController.text) {
                                        // Process data if admin exists
                                        final updatedRegisterAdmin = RegisterAdmin(
                                          id: existingAdmin.id, // Use the existing ID for the update
                                          username: _usernameController.text,
                                          password: _passwordController.text,
                                          gambar: _gambarController.text,
                                          namaInstansi: _namaInstansiController.text,
                                          alamatInstansi: _alamatInstansiController.text,
                                          noTelepon: int.tryParse(_noTeleponController.text) ?? 0,
                                          email: _emailController.text,
                                        );

                                        await dbAdmin.updateRegistersAdmin(updatedRegisterAdmin);

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Data berhasil diubah')),
                                        );

                                        Navigator.pop(context);
                                      } else {
                                        // Show error if admin does not exist
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Admin tidak ditemukan atau kredensial salah')),
                                        );
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFCDC2AE),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 6.0, // Top and bottom padding
                                      horizontal:
                                          45.0, // Left and right padding
                                    ),
                                  ),
                                  child: Text(
                                    'SIMPAN',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Ubuntu',
                                    ),
                                  ),
                                ),
                                SizedBox(
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

  // Widget buildProfilePictureFeature() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Foto Profil',
  //         style: TextStyle(
  //           fontFamily: 'Ubuntu',
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(height: 10),
  //       Container(
  //         height: 40,
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: Container(
  //                 height: 40,
  //                 decoration: BoxDecoration(
  //                   color: Color(0xFFE0E5E7),
  //                   borderRadius: BorderRadius.circular(7),
  //                 ),
  //                 child: Center(
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
  //             SizedBox(width: 10),
  //             ElevatedButton(
  //               onPressed: () {
  //                 // kode image_picker disini nanti ya thin
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Color(0xFF2F5061),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(7),
  //                 ),
  //               ),
  //               child: Text(
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
  //       SizedBox(height: 10),
  //     ],
  //   );
  // }

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
            backgroundImage: _image != null ? FileImage(_image!) : const AssetImage('assets/user-home/admin-profile.png') as ImageProvider<Object>,
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
                      _gambarController.text = pickedFile.path;
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
                      _gambarController.text = pickedFile.path;
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
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
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
              fillColor: Color(0xFFE0E5E7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
              hintText: hint,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildBigTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 120,
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFE0E5E7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
              hintText: hint,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 70),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
