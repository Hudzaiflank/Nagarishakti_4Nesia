import 'package:flutter/material.dart';
import '/Database/database_pengajuanDokumen.dart'; 

class PengajuanDokumenPage extends StatefulWidget {
  const PengajuanDokumenPage({super.key});

  @override
  _PengajuanDokumenPageState createState() => _PengajuanDokumenPageState();
}

class _PengajuanDokumenPageState extends State<PengajuanDokumenPage> {
  List<PengajuanDokumen> _pengajuanDokumens = [];

  @override
  void initState() {
    super.initState();
    _loadDokumensFromDB();
  }

  Future<void> _loadDokumensFromDB() async {
    final DatabasePengajuanDokumen db = DatabasePengajuanDokumen.instance;
    final List<PengajuanDokumen> pengajuanDokumens = await db.getPengajuanDokumen();
    setState(() {
      _pengajuanDokumens = pengajuanDokumens;
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
                'PENGAJUAN DOKUMEN',
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
            for (var pengajuanDokumen in _pengajuanDokumens)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildStatusContainer(
                  pengajuanDokumen.title,
                  pengajuanDokumen.tanggalDokumen,
                  pengajuanDokumen.statusDokumen,
                ),
              ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'STATISTIK DOKUMEN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2F5061),
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
            SizedBox(height: 10),
            for (var pengajuanDokumen in _pengajuanDokumens)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildStatisticContainer(
                  pengajuanDokumen.jenisDokumen,
                  pengajuanDokumen.jumlahDokumen.toString(),
                  Color(pengajuanDokumen.warnaBackground),
                ),
              ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusContainer(String title, String tanggalDokumen, String statusDokumen) {
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
                tanggalDokumen,
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                ),
              ),
            ],
          ),
          Text(
            statusDokumen,
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

  Widget _buildStatisticContainer(String jenisDokumen, String jumlahDokumen, Color warnaBackground) {
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
            jenisDokumen,
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
            jumlahDokumen,
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
}
