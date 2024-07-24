import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileDev extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Text('Profil Mahasiswa'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView(
        children: [
          ProfileCard(
            name: 'Zheand Rizky Pranasyach',
            birthPlace: 'Sidoarjo',
            birthDate: '05 Januari 2004',
            address:
                'Jl. Sono Indah Utara 3 Gang 10D, Sidokerto, Buduran, Sidoarjo',
            phoneNumber: '08993326813',
            email: 'zheandrizky@gmail.com',
            githubUrl: 'github.com/zheandrizky',
            educationHistory:
                'UPN "Veteran Jawa Timur"\n"SMK Antartika 2 Sidoarjo"',
            awards: '-',
            imagePath: 'assets/images/fotozheand.jpg',
          ),
          ProfileCard(
            name: 'Yumna Kamilah Mahdiyah',
            birthPlace: 'Surabaya',
            birthDate: '15 Mei 2004',
            address: 'Setro Utara 9 No. 7-A',
            phoneNumber: '089696771751',
            email: 'ymnkamilah@gmail.com',
            githubUrl: 'https://github.com/yumnakm',
            educationHistory: 'UPN "Veteran Jawa Timur"\n"SMA Al-Irsyad"',
            awards: '-',
            imagePath: 'assets/images/fotoyumna.png',
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String birthPlace;
  final String birthDate;
  final String address;
  final String phoneNumber;
  final String email;
  final String githubUrl;
  final String educationHistory;
  final String awards;
  final String imagePath;

  const ProfileCard({
    required this.name,
    required this.birthPlace,
    required this.birthDate,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.githubUrl,
    required this.educationHistory,
    required this.awards,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        child: Card(
          color: Color(0xFF4B39EF), // background color of the card
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(imagePath),
                ),
                SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // text color
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Tempat, Tanggal Lahir:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // text color
                  ),
                ),
                Text(
                  '$birthPlace, $birthDate',
                  style: TextStyle(
                    color: Colors.white, // text color
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Alamat:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // text color
                  ),
                ),
                Text(
                  '$address',
                  style: TextStyle(
                    color: Colors.white, // text color
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'No. HP:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // text color
                  ),
                ),
                Text(
                  '$phoneNumber',
                  style: TextStyle(
                    color: Colors.white, // text color
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Email:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // text color
                  ),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    _launchURL(
                        'mailto:$email'); // Panggil fungsi untuk membuka URL
                  },
                  child: Text(
                    email,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white, // text color
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Url Profil GitHub:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // text color
                  ),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    _launchURL(githubUrl); // Panggil fungsi untuk membuka URL
                  },
                  child: Text(
                    githubUrl,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white, // text color
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Riwayat Pendidikan:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // text color
                  ),
                ),
                Text(
                  '$educationHistory',
                  style: TextStyle(
                    color: Colors.white, // text color
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Penghargaan:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // text color
                  ),
                ),
                Text(
                  '$awards',
                  style: TextStyle(
                    color: Colors.white, // text color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
