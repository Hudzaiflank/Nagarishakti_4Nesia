import 'package:flutter/material.dart';
import '/Database/database_agenda.dart'; 

class AgendaPemerintahan extends StatefulWidget {
  const AgendaPemerintahan({super.key});

  @override
  _AgendaPemerintahanState createState() => _AgendaPemerintahanState();
}

class _AgendaPemerintahanState extends State<AgendaPemerintahan> {
  List<Agenda> _agendas = [];

  @override
  void initState() {
    super.initState();
    _loadAgendasFromDB();
  }

  Future<void> _loadAgendasFromDB() async {
    final DatabaseAgenda db = DatabaseAgenda.instance;
    final List<Agenda> agendas = await db.getAgenda();
    setState(() {
      _agendas = agendas;
    });
  }

  @override
  Widget build(BuildContext context) {
    Set<String> displayedAgendas = {};

    return Scaffold(
      backgroundColor: const Color(0xFFC4DFE2),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Container(
          padding: const EdgeInsets.only(top: 20.0, bottom: 16.0),
          decoration: const BoxDecoration(
            color: Color(0xFFECF5F6),
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
                'AGENDA PEMERINTAHAN',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 22,
                  color: Colors.black,
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
                      color: Color(0xFFAC5F63),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 13),
              for (var schedule in _agendas)
                if (displayedAgendas.add(
                    '${schedule.judul}_${schedule.waktu}_${schedule.lokasi}'))
                  eventCard(
                    judul: schedule.judul,
                    waktu: schedule.waktu,
                    lokasi: schedule.lokasi,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget eventCard({
    required String judul,
    required String waktu,
    required String lokasi,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFEAEEEF),
            borderRadius: BorderRadius.circular(7.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Color(0xFFCE7277)),
                  SizedBox(width: 8),
                  Text(
                    waktu,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xFFCE7277)),
                  SizedBox(width: 8),
                  Text(
                    lokasi,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
