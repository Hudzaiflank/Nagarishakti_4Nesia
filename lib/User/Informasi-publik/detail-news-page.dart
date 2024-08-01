import 'package:flutter/material.dart';

class DetailNewsPage extends StatelessWidget {
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
                'Pemerintah Daerah Menjalin Kerjasama dengan PT 4nesia untuk menyatukan kuasa',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '23-11-2023 07:30 | Illa Alfira',
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
                child: Image.asset('assets/contoh-gambar.png'),
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
                      'Dalam upaya meningkatkan pelayanan kepada masyarakat, Pemerintah Daerah telah resmi menjalin kerjasama dengan PT 4nesia. Kerjasama ini bertujuan untuk menyatukan berbagai layanan yang ada dengan integrasi ketersediaan pemerintah daerah dan instansi terkait.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Acara peresmian kerjasama ini dilakukan di aula kantor pemerintah daerah dengan dihadiri oleh para pejabat dan perwakilan dari PT 4nesia. Dalam sambutannya, Bupati menyatakan bahwa kolaborasi ini diharapkan dapat meningkatkan kualitas pelayanan publik di daerah ini.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Kerjasama dengan PT 4nesia ini merupakan langkah strategis dalam upaya kita untuk memperluas kualitas pelayanan kepada masyarakat. Dengan integrasi yang baik, kita berharap proses administrasi dan pelayanan publik bisa menjadi lebih cepat, transparan, dan mudah diakses oleh masyarakat, ujar Bupati.',
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
                      child: Image.asset('assets/contoh-gambar.png'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'PT 4nesia sebagai mitra teknologi, akan membantu pemerintah daerah dalam mengembangkan sistem integrasi yang lebih efisien dan terintegrasi dengan baik. Selain itu, PT 4nesia juga akan memberikan pelatihan dan pendampingan teknis bagi para pegawai di pemerintah daerah agar sistem yang digunakan dapat berjalan dengan baik dan bisa diakses oleh seluruh lapisan masyarakat melalui perangkat mobile.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Direktur utama PT 4nesia dalam kesempatan yang sama, menyampaikan bahwa kerjasama ini merupakan wujud nyata komitmen PT 4nesia dalam mendukung inovasi dan kemajuan daerah. Sinergi antara pemerintah daerah dan PT 4nesia diharapkan bisa membawa dampak positif bagi masyarakat luas, terutama dalam hal akses informasi, perbaikan mutu layanan publik, dan penyediaan layanan publik yang lebih baik dan efisien.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Kerjasama ini juga mencakup pengembangan aplikasi berbasis mobile yang dapat membantu mempermudah masyarakat dalam mengakses berbagai layanan, mulai dari pendaftaran online, pemrosesan dokumen, hingga pelayanan informasi publik. Diharapkan dengan adanya aplikasi ini, masyarakat bisa lebih mudah mendapatkan layanan tanpa harus datang langsung ke kantor pemerintah daerah, menghemat waktu dan biaya.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Dengan kerjasama ini, Pemerintah Daerah dan PT 4nesia berharap bisa memberikan layanan yang terbaik bagi seluruh masyarakat di daerah ini. Semoga langkah ini menjadi awal yang baik dalam mempererat hubungan kerjasama yang lebih baik dalam pelayanan publik di masa yang akan datang.',
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
