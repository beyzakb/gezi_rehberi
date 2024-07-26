import 'package:flutter/material.dart';
import 'appbar.dart';
import 'navbar.dart';
import 'map_sample.dart';

class FinalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              "Planınız başarıyla oluşturuldu!",
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: MapSample(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          // BottomNavigationBar'dan index değişikliği için işlemler buraya yazılabilir.
        },
      ),
    );
  }
}
