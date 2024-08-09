import 'package:flutter/material.dart';
import '/Database/database_acara.dart';

class UserTimelineFestival extends StatefulWidget {
  const UserTimelineFestival({super.key});

  @override
  _UserTimelineFestivalState createState() => _UserTimelineFestivalState();
}

class _UserTimelineFestivalState extends State<UserTimelineFestival> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Acara> _events = [];
  List<Acara> _uniqueEvents = [];
  List<Acara> _notificationEvents = [];

  @override
  void initState() {
    super.initState();
    _loadEventsFromDB();
  }

  Future<void> _loadEventsFromDB() async {
    final DatabaseAcara db = DatabaseAcara.instance;
    final List<Acara> events = await db.getAcara();
    setState(() {
      _events = events;
      _uniqueEvents = _getUniqueEvents(events);
      _notificationEvents = events.where((eve) => eve.notification).toList();
    });
  }

  List<Acara> _getUniqueEvents(List<Acara> events) {
    final uniqueKeys = <String>{};
    return events.where((eve) {
      final key = '${eve.title}_${eve.location}_${eve.date}';
      if (uniqueKeys.contains(key)) {
        return false;
      } else {
        uniqueKeys.add(key);
        return true;
      }
    }).toList();
  }

  Future<void> _updateNotification(Acara event) async {
    final DatabaseAcara db = DatabaseAcara.instance;
    event.notification = !event.notification;
    await db.updateAcara(event);
    setState(() {
      if (event.notification) {
        _notificationEvents.add(event);
      } else {
        _notificationEvents.removeWhere((eve) => eve.id == event.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Acara> filteredEvents = _uniqueEvents.where((event) {
      final query = _searchQuery.toLowerCase();
      return event.title.toLowerCase().contains(query) ||
          event.location.toLowerCase().contains(query) ||
          event.date.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Container(
          padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
          decoration: const BoxDecoration(
            color: Color(0xFF4297A0),
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
                      margin: const EdgeInsets.only(left: 10.0, top: 10.0),
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
                'TIMELINE \nACARA & FESTIVAL',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_pin, size: 16, color: Colors.red),
                  SizedBox(width: 4),
                  Text(
                    'Kota Bekasi',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 16,
                      color: Colors.red,
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
                hintText: 'Cari nama festival',
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
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFAAA79C),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0), // Remove padding to fill the container
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F5061),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(7), // Added border radius
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 3),
                                  ),
                                  child: Image.asset(
                                    event.image,
                                    width: 118, // Increased width by 18px
                                    height: 100, // Adjust height to fill the container
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.title,
                                      style: const TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis, // Add ellipsis
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            color: Colors.white, size: 14), // Change to white
                                        const SizedBox(width: 5),
                                        Text(
                                          event.date,
                                          style: const TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_pin,
                                            color: Colors.white, size: 14), // Change to white
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            event.location,
                                            style: const TextStyle(
                                              fontFamily: 'Ubuntu',
                                              color: Colors.white,
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis, // Add ellipsis
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: IconButton(
                                  icon: Icon(
                                    event.notification ? Icons.notifications : Icons.notifications_off,
                                    color: event.notification ? Colors.white : Colors.white
                                  ), 
                                  onPressed: () {
                                    _updateNotification(event);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Deskripsi:',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                event.description,
                                style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Informasi lebih lanjut',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: Color(0xFFCE7277),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFFCE7277),
                                    size: 14, // Match the text size
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
