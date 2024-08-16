import 'package:flutter/material.dart';
import '/Database/database_berita.dart'; 
import '/Database/database_pengumuman.dart'; 
import '/Database/database_detailBerita.dart';
import 'package:nagarishakti/User/Informasi-publik/berita/detail-news-page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

//! JANGAN DI HAPUS
int _colorIndex = 0;

final List<Color> _colors = [
  Colors.grey[800]!,
  Colors.grey[700]!,
  Colors.grey[500]!,
  Colors.grey[300]!,
];

Color _getNextColor() {
  final Color color = _colors[_colorIndex % _colors.length];
  _colorIndex++;
  return color;
}

//! JANGAN DIHAPUS

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Berita> _beritas = [];
  List<Berita> _uniqueBeritas = [];
  List<Pengumuman> _pengumumans = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    _loadBeritasFromDB();
    _loadPengumumansFromDB();
  }

  Future<void> _loadPengumumansFromDB() async {
    final DatabasePengumuman db = DatabasePengumuman.instance;
    final List<Pengumuman> pengumumans = await db.getPengumuman();
    setState(() {
      _pengumumans = pengumumans;
    });
  }

  Future<void> _loadBeritasFromDB() async {
    final DatabaseBerita db = DatabaseBerita.instance;
    final List<Berita> beritas = await db.getBerita();
    setState(() {
      _beritas = beritas;
      _uniqueBeritas = _getUniqueBeritas(beritas);
    });
  }

  List<Berita> _getUniqueBeritas(List<Berita> beritas) {
    final uniqueKeys = <String>{};
    return beritas.where((brt) {
      final key = '${brt.title}_';
      if (uniqueKeys.contains(key)) {
        return false;
      } else {
        uniqueKeys.add(key);
        return true;
      }
    }).toList();
  }
  
  Future<void> _navigateToDetail(Berita news) async {
    final DatabaseDetailBerita dbDetail = DatabaseDetailBerita.instance;
    if (news.id != null) {
      final List<DetailBerita> detailBeritaList = await dbDetail.getDetailBerita(news.id!);

      if (detailBeritaList.isNotEmpty) {
        final DetailBerita newsDetail = detailBeritaList.first;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailNewsPage(
              news: news,
              newsDetail: newsDetail,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Detail berita tidak ditemukan')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID berita tidak valid')),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Berita> filteredBeritas = _uniqueBeritas.where((news) {
      final query = _searchQuery.toLowerCase();
      return news.title.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            backgroundColor: _tabController.index == 0
                ? Color(0xFFC4DFE2)
                : Color(0xFFFFFFFF),
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE2DED0),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              _tabController.index == 0 ? 'BERITA TERKINI' : 'PENGUMUMAN',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _tabController.animateTo(0);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _tabController.index == 0
                              ? Color(0xFFECF5F6)
                              : Color(0xFF2F5061),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Text(
                          'BERITA',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            color: _tabController.index == 0
                                ? Colors.black
                                : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _tabController.animateTo(1);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _tabController.index == 1
                              ? Color(0xFFECF5F6)
                              : Color(0xFF2F5061),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Text(
                          'PENGUMUMAN',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            color: _tabController.index == 1
                                ? Colors.black
                                : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: _tabController.index == 0
                ? Container(
                    color: Color(0xFFECF5F6),
                    child: ListView(
                      padding: EdgeInsets.all(8.0),
                      children: [
                        GestureDetector(
                          onTap: () {
                            //TODO ini buat handle search thin
                            setState(() {
                              filteredBeritas = _searchQuery.isNotEmpty
                                  ? filteredBeritas.where((news) {
                                      return news.title
                                          .toLowerCase()
                                          .contains(_searchQuery.toLowerCase());
                                    }).toList()
                                  : filteredBeritas;
                            });
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2DED0),
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: 'Cari Berita',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF8E98A8),
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Ubuntu',
                                ),
                                prefixIcon: const Padding(
                                  padding:
                                      EdgeInsets.only(left: 16.0, right: 12.0),
                                  child: Icon(Icons.search,
                                      color: Color(0xFF8E98A8)),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (query) {
                                setState(() {
                                  _searchQuery = query;
                                  filteredBeritas = _searchQuery.isNotEmpty
                                      ? filteredBeritas.where((news) {
                                          return news.title
                                              .toLowerCase()
                                              .contains(_searchQuery.toLowerCase());
                                        }).toList()
                                      : filteredBeritas;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ...filteredBeritas.map((news) {
                          // return _cardBeritaWidget(news.image, news.title);
                          return _cardBeritaWidget(news);
                        }).toList(),
                      ],
                    ),
                  )
                : Container(
                    color: Color(0xFFE3EFF1),
                    child: Column(
                      children: [
                        SizedBox(height: 42.0), // Memastikan SizedBox digunakan dengan benar
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.all(8.0),
                            itemCount: _pengumumans.length,
                            itemBuilder: (context, index) {
                              final announcement = _pengumumans[index];
                              return _pengumumanWidget(
                                announcement.date,
                                announcement.title,
                                announcement.subtitle,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
          ),
        ],
      ),
    );
  }

  Widget _pengumumanWidget(String date, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 22.0),
        Container(
          color: Color(0xFF4297A0),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.white),
              SizedBox(width: 4.0),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          color: Color(0xFFFbFAF8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Ubuntu',
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget _cardBeritaWidget(String image, String title) {
  //   return GestureDetector(
  //     onTap: () async {
  //       Navigator.push(
  //         //thin lu ntar detail nya ambil per id atau pk bebas, ganti kode dibawah ya
  //         //TODO dari sini
  //         context,
  //         MaterialPageRoute(builder: (context) => DetailNewsPage()),
  //         //TODO sampai sini
  //       );
  //     },
  //     child: Card(
  //       margin: EdgeInsets.symmetric(vertical: 8.0),
  //       child: Stack(
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(7.0),
  //             child: Image.asset(
  //               image,
  //               width: double.infinity,
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 0,
  //             left: 0,
  //             right: 0,
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: _getNextColor(), // Gunakan warna yang telah dipilih
  //                 borderRadius: BorderRadius.circular(7.0),
  //               ),
  //               padding: EdgeInsets.all(8.0),
  //               child: Text(
  //                 title,
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   fontFamily: 'Ubuntu',
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  
  Widget _cardBeritaWidget(Berita news) {
    return GestureDetector(
      onTap: () async {
        await _navigateToDetail(news);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7.0),
              child: Image.asset(
                news.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: _getNextColor(),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  news.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,                 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
