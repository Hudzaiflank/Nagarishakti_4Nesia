import 'package:flutter/material.dart';
import 'edit-user-profile.dart'; // Tambahkan import ini

class EditUserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Color(0xFFECF5F6), // Background color
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/profile-edit/rectangle-1.png',
              width: 100,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/profile-edit/rectangle-2.png',
              width: 100,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/profile-edit/rectangle-3.png',
              width: MediaQuery.of(context).size.width / 2.8,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.cover,
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 280.0,
                floating: false,
                pinned: true,
                backgroundColor: Color(0xFFECF5F6),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.only(top: 88),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              AssetImage('assets/user-home/profile-logo.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(height: 17),
                        Text(
                          'BUDI WIJAYA',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          '3518112408070003',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 24, 20, 50),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFF4297A0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildInfoRow('Username', 'budywjy_'),
                          buildInfoRow(
                              'Tempat Tanggal Lahir', 'Sukabumi, 23 Juli 1977'),
                          buildInfoRow('Alamat',
                              'Jl. Veteran II, Selabatu,\nKec. Cikole, Sukabumi'),
                          buildInfoRow('Agama', 'Islam'),
                          buildInfoRow('Jenis Pekerjaan', 'Karyawan Swasta'),
                          buildInfoRow('Jenis Kelamin', 'Pria'),
                          buildInfoRow('No Telepon', '081236484878'),
                          buildInfoRow('No Rekening', '13122349826'),
                        ],
                      ),
                    ),
                    SizedBox(height: 22),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditUserProfilePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC6B79B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        ),
                        child: Text(
                          'UBAH PROFIL',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 110),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2F5061),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                        ),
                        child: Text(
                          'KELUAR',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            child: Text(
              '$label',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            ':',
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w300,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
