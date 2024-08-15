//!JANGAN DI UBAH STYLINGNYA
//!JANGAN DI UBAH STYLINGNYA
//!JANGAN DI UBAH STYLINGNYA
//!JANGAN DI UBAH STYLINGNYA
//!JANGAN DI UBAH STYLINGNYA

//TODO: buat sub judul tidak inline block jadi si icon download bisa di tengah
//TODO: buat popup notifikasi
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '/Database/database_dokumen.dart'; 
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:path/path.dart' as path;

class PublicDocumentPage extends StatefulWidget {
  const PublicDocumentPage({super.key});

  @override
  _PublicDocumentPageState createState() => _PublicDocumentPageState();
}

class _PublicDocumentPageState extends State<PublicDocumentPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Dokumen> _dokumens = [];
  List<Dokumen> _uniqueDokumens = [];

  @override
  void initState() {
    super.initState();
    _loadDokumensFromDB();
  }

  Future<void> _loadDokumensFromDB() async {
    final DatabaseDokumen db = DatabaseDokumen.instance;
    final List<Dokumen> dokumens = await db.getDokumen();
    setState(() {
      _dokumens = dokumens;
      _uniqueDokumens = _getUniqueDokumens(dokumens);
    });
  }

  List<Dokumen> _getUniqueDokumens(List<Dokumen> dokumens) {
    final uniqueKeys = <String>{};
    return dokumens.where((dok) {
      final key = '${dok.title}_${dok.date}_${dok.time}';
      if (uniqueKeys.contains(key)) {
        return false;
      } else {
        uniqueKeys.add(key);
        return true;
      }
    }).toList();
  }

  Future<void> _downloadFile(String assetPath, String fileName) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      final buffer = data.buffer.asUint8List();
      final Directory directory = await _getDirectory();
      final File file = File('${directory.path}/$fileName');

      await file.writeAsBytes(buffer);
      _showNotification('File berhasil di download ke ${file.path}');
    } catch (e) {
      _showNotification('Gagal download file: $e');
    }
  }

  Future<Directory> _getDirectory() async {
    if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    } else {
      final dir = Directory('/storage/emulated/0/Download/');
      if (!await dir.exists()) {
        final externalDir = await getExternalStorageDirectory();
        if (externalDir != null) {
          return externalDir;
        } else {
          throw Exception('External storage directory not found');
        }
      }
      return dir;
    }
  }

  void _showNotification(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Dokumen> filteredDokumens = _uniqueDokumens.where((document) {
      final query = _searchQuery.toLowerCase();
      return document.title.toLowerCase().contains(query) ||
          document.date.toLowerCase().contains(query) ||
          document.time.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Color(0xFFECF5F6),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE2DED0),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  // Handle back button press
                  Navigator.pop(context);
                },
              ),
            ),
            title: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFFE2DED0),
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Cari Dokumen Publik',
                  hintStyle: const TextStyle(
                    color: Color(0xFF8E98A8),
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Ubuntu',
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 12.0),
                    child: Icon(Icons.search, color: Color(0xFF8E98A8)),
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
            ),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFC4DFE2),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'AKSES DOKUMEN PUBLIK',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Ubuntu',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on, color: Color(0xFFAC5F63)),
                            SizedBox(width: 4),
                            Text(
                              'Kota Bekasi',
                              style: TextStyle(
                                color: Color(0xFFAC5F63),
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredDokumens.length,
                    itemBuilder: (context, index) {
                      final document = filteredDokumens[index];
                      return documentCard(
                        title: document.title,
                        date: document.date,
                        time: document.time,
                        fileUrl: document.fileUrl,
                        onDownload: _downloadFile,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget documentCard({
  required String title,
  required String date,
  required String time,
  required String fileUrl,
  required Future<void> Function(String, String) onDownload,
}) {
  return Card(
    color: Color(0xFFFBFAF8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  SizedBox(width: 7),
                  Text(
                    time,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Image.asset('assets/download-pdf.png',
                      width: 24, height: 24),
                  onPressed: () {
                    // TODO: thin buat handle download masing masing disini, panggil aja pk atau id nya
                    onDownload(fileUrl, path.basename(fileUrl));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
