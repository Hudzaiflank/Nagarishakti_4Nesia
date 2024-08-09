import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditAdminProfilePage extends StatefulWidget {
  @override
  _EditAdminProfilePageState createState() => _EditAdminProfilePageState();
}

class _EditAdminProfilePageState extends State<EditAdminProfilePage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _gender;

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
                                    label: 'Nama Lengkap',
                                    hint: 'nama lengkap huruf kapital',
                                  ),
                                  _buildTextField(
                                    label: 'Nama Instansi',
                                    hint: 'nama instansi daerah',
                                  ),
                                  _buildBigTextField(
                                    label: 'Alamat Instansi',
                                    hint: 'alamat lengkap intansi',
                                  ),
                                  _buildTextField(
                                    label: 'Nomor Telepon',
                                    hint: '08...',
                                    keyboardType: TextInputType.phone,
                                  ),
                                  _buildTextField(
                                    label: 'Email',
                                    hint: 'rinapermata@itd.go.id',
                                  ),
                                  _buildTextField(
                                    label: 'Username',
                                    hint: 'rina_permata',
                                  ),
                                  _buildTextField(
                                    label: 'Password',
                                    hint: '********',
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
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Process data
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

  Widget buildProfilePictureFeature() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Foto Profil',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E5E7),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      'Pastikan foto terpilih',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // kode image_picker disini nanti ya thin
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2F5061),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  'Pilih Foto',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
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
            keyboardType: keyboardType,
            obscureText: obscureText,
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
            maxLines: null,
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
