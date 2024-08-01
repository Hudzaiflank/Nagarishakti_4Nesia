import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<DestinasiAPI> fetchDestinasiAPI() async {
  final response = await http.get(
    Uri.parse('https://api-splp.layanan.go.id/t/bekasikota.go.id/Data_UMKM/1.0'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // Add any other headers required by the API here
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return DestinasiAPI.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load data');
  }
}

class DestinasiAPI {
  // Define the attributes based on the expected response from the API
  // Adjust these fields as per the actual response structure
  final String attribute1;
  final String attribute2;
  final String attribute3;

  const DestinasiAPI({
    required this.attribute1,
    required this.attribute2,
    required this.attribute3,
  });

  factory DestinasiAPI.fromJson(Map<String, dynamic> json) {
    return DestinasiAPI(
      attribute1: json['attribute1'] as String,
      attribute2: json['attribute2'] as String,
      attribute3: json['attribute3'] as String,
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<DestinasiAPI> futureDestinasiAPI;

  @override
  void initState() {
    super.initState();
    futureDestinasiAPI = fetchDestinasiAPI();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<DestinasiAPI>(
            future: futureDestinasiAPI,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Attribute 1: ${snapshot.data!.attribute1}'),
                    Text('Attribute 2: ${snapshot.data!.attribute2}'),
                    Text('Attribute 3: ${snapshot.data!.attribute3}'),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
