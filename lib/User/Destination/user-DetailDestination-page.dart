import 'package:flutter/material.dart';
import 'user-Destination-page.dart';
import '/Database/database_destinasi.dart';
import '/Database/database_detailDestinasi.dart';

class UserDetailDestinationPage extends StatefulWidget {
  final Destinasi destination;
  final DetailDestinasi detaildestinasi;

  const UserDetailDestinationPage(
      {super.key, required this.destination, required this.detaildestinasi});

  @override
  _UserDetailDestinationPageState createState() =>
      _UserDetailDestinationPageState();
}

class _UserDetailDestinationPageState extends State<UserDetailDestinationPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press here, if we need it, but actually we dont need that
        return true; // Return true if the route can be popped, guess what, it cant return anything at all :D
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                widget.detaildestinasi.gambar,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 40.0,
              left: 16.0,
              child: CircleAvatar(
                backgroundColor: Color(0xFFE2DED0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 300.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFCFCFA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.destination.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu',
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            widget.destination.bookmark
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: widget.destination.bookmark
                                ? Color(0xFF979797)
                                : Color(0xFF979797),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 24,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              widget.destination.location,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Ubuntu',
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Deskripsi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu',
                          color: Color(0xFF285B60),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.detaildestinasi.deskripsi,
                        style: const TextStyle(
                            color: Colors.black, fontFamily: 'Ubuntu'),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Gambar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu',
                          color: Color(0xFF285B60),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              width: 200,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child:
                                    Image.asset(widget.detaildestinasi.gambar),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Fasilitas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu',
                          color: Color(0xFF285B60),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 11.0, horizontal: 7.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F5F0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        width: double.infinity,
                        child: Text(
                          widget.detaildestinasi.fasilitas,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                              height: 1.7),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Harga Tiket',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu',
                          color: Color(0xFF285B60),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 11.0, horizontal: 7.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F5F0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        width: double.infinity,
                        child: Text(
                          widget.detaildestinasi.hargaTiket,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ubuntu',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}