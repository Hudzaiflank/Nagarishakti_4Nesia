import 'package:flutter/material.dart';
import 'user-DetailDestination-page.dart';
import '/Database/database_destinasi.dart';

class UserDestinationPage extends StatefulWidget {
  const UserDestinationPage({super.key});

  @override
  _UserDestinationPageState createState() => _UserDestinationPageState();
}

class _UserDestinationPageState extends State<UserDestinationPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Destinasi> _destinations = [];
  List<Destinasi> _uniqueDestinations = [];
  List<Destinasi> _bookmarkedDestinations = [];

  @override
  void initState() {
    super.initState();
    _loadDestinationsFromDB();
  }

  Future<void> _loadDestinationsFromDB() async {
    final DatabaseDestinasi db = DatabaseDestinasi.instance;
    final List<Destinasi> destinations = await db.getDestinasi();
    setState(() {
      _destinations = destinations;
      _uniqueDestinations = _getUniqueDestinations(destinations);
      _bookmarkedDestinations = destinations.where((dest) => dest.bookmark).toList();
    });
  }

  List<Destinasi> _getUniqueDestinations(List<Destinasi> destinations) {
    final uniqueKeys = <String>{};
    return destinations.where((dest) {
      final key = '${dest.title}_${dest.location}_${dest.savedBy}';
      if (uniqueKeys.contains(key)) {
        return false;
      } else {
        uniqueKeys.add(key);
        return true;
      }
    }).toList();
  }

  Future<void> _updateBookmark(Destinasi destination) async {
    final DatabaseDestinasi db = DatabaseDestinasi.instance;
    destination.bookmark = !destination.bookmark;
    await db.updateDestinasi(destination);
    setState(() {
      if (destination.bookmark) {
        _bookmarkedDestinations.add(destination);
      } else {
        _bookmarkedDestinations.removeWhere((dest) => dest.id == destination.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Destinasi> filteredDestinations = _uniqueDestinations.where((destination) {
      final query = _searchQuery.toLowerCase();
      return destination.title.toLowerCase().contains(query) ||
          destination.location.toLowerCase().contains(query) ||
          destination.savedBy.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Container(
          padding: const EdgeInsets.only(top: 35),
          decoration: const BoxDecoration(
            color: Color(0xFF3AB3B1),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(7.0)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE2DED0),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'DESTINASI PARIWISATA',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_pin, size: 16, color: Color(0xFFA53525)),
                  SizedBox(width: 4),
                  Text(
                    'Kota Bekasi',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 16,
                      color: Color(0xFFCDC2AE),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                filled: true,
                fillColor: const Color(0xFFE2DED0),
                hintText: 'Cari destinasi wisata',
                hintStyle: const TextStyle(
                    color: Color(0xFF8E98A8),
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Ubuntu'),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 12.0),
                  child: Icon(Icons.search, color: Color(0xFF8E98A8)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDestinations.length,
              itemBuilder: (context, index) {
                final destination = filteredDestinations[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      color: Color(destination.backgroundColor),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(destination.imagePath),
                        ),
                        title: Text(
                          destination.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_pin, size: 16, color: Colors.red),
                                const SizedBox(width: 4),
                                Text(
                                  destination.location,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.bookmark, size: 16, color: Colors.red),
                                const SizedBox(width: 4),
                                Text(
                                  destination.savedBy,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            destination.bookmark ? Icons.bookmark : Icons.bookmark_border,
                            color: destination.bookmark ? Colors.white : Colors.white,
                          ),
                          onPressed: () {
                            _updateBookmark(destination);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailDestinationPage(
                                destination: destination,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
