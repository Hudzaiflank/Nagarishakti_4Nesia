import 'package:flutter/material.dart';
import '/Database/database_pengajuanKeluhan.dart';

class PengajuanKeluhanPage extends StatefulWidget {
  const PengajuanKeluhanPage({super.key});

  @override
  _PengajuanKeluhanPageState createState() => _PengajuanKeluhanPageState();
}

class _PengajuanKeluhanPageState extends State<PengajuanKeluhanPage> {
  List<PengajuanKeluhan> _pengajuanKeluhans = [];

  @override
  void initState() {
    super.initState();
    _loadKeluhansFromDB();
  }

  Future<void> _loadKeluhansFromDB() async {
    final DatabasePengajuanKeluhan db = DatabasePengajuanKeluhan.instance;
    final List<PengajuanKeluhan> pengajuanKeluhans = await db.getPengajuanKeluhan();
    setState(() {
      _pengajuanKeluhans = pengajuanKeluhans;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF5F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                children: [
                  Container(
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
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'PENGAJUAN KELUHAN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'STATUS PENGAJUAN ANDA',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2F5061),
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildStatusContainer(
                'Kerusakan Jalan', 'Diajukan 10/07/2024', 'diproses'),
            SizedBox(height: 10),
            _buildStatusContainer(
                'Kurang Infrastruktur', 'Diajukan 10/07/2024', 'diajukan'),
            SizedBox(height: 10),
            _buildStatusContainer(
                'Lampu Lalu Lintas Mati', 'Diajukan 22/03/2024', 'selesai'),
            SizedBox(height: 20),
            Center(
              child: Text(
                'STATISTIK KELUHAN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2F5061),
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
            SizedBox(height: 10),
            for (var pengajuanKeluhan in _pengajuanKeluhans)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildStatisticContainer(
                  pengajuanKeluhan.title,
                  pengajuanKeluhan.jumlahKeluhan.toString(),
                  Color(pengajuanKeluhan.warnaBackground),
                ),
              ),
            SizedBox(height: 20),
            _buildButtonContainer(
                'Ajukan Keluhan Lainnya', Icons.arrow_forward),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusContainer(String title, String date, String status) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFC4DFE2),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                ),
              ),
              SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                ),
              ),
            ],
          ),
          Text(
            status,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w100,
              fontFamily: 'Ubuntu',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticContainer(String title, String jumlahKeluhan, Color warnaBackground) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warnaBackground,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            jumlahKeluhan,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonContainer(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE2DED0),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(icon, color: Colors.black),
        ],
      ),
    );
  }
}
