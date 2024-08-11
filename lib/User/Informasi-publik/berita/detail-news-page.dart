import 'package:flutter/material.dart';
import 'news-page.dart';
import '/Database/database_berita.dart';
import '/Database/database_detailBerita.dart';
import 'package:nagarishakti/User/Informasi-publik/berita/news-page.dart';

class DetailNewsPage extends StatefulWidget {
  final Berita news;
  final DetailBerita newsDetail;

  const DetailNewsPage(
      {super.key, required this.news, required this.newsDetail});

  @override
  _DetailNewsPageState createState() =>
      _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF5F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFE2DED0),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.news.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.newsDetail.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 8),
              Divider(color: Colors.black),
              SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.asset(widget.newsDetail.firstImage),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.newsDetail.firstDescription,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.asset(widget.newsDetail.secondImage),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.newsDetail.secondDescription,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
