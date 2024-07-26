import 'package:flutter/material.dart';
import 'olustur.dart';
import 'appbar.dart';
import 'navbar.dart';

class PlanYap extends StatelessWidget {
  final String isim;
  final String soyisim;

  PlanYap({required this.isim, required this.soyisim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildPhotoCard('assets/bir.jpg'),
                SizedBox(height: 8),
                _buildPhotoCard('assets/iki.jpg'),
                SizedBox(height: 8),
                _buildPhotoCard('assets/uc.jpg'),
                SizedBox(height: 8),
              ],
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Olustur()),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                "Plan Yap",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: 1, // Seçili olan endeksi burada belirtin
        onTap: (index) {
        },
      ),
    );
  }

  Widget _buildPhotoCard(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0), // Köşeleri yuvarlatmak için ClipRRect kullanılır
      child: Container(
        height: 200, // Konteynerin yüksekliği 200
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          // Kenar çizgisi olarak açık gri renkli bir sınır ekler
        ),
        child: Image.asset(
          imagePath, // Verilen imagePath ile resmi yükler
          fit: BoxFit.cover, // Resmi konteyneri tamamen kaplayacak şekilde ölçeklendirir
        ),
      ),
    );
  }
}
