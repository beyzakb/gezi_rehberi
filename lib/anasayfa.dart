import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gezi_rehberi/plan_yap.dart';


class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  final TextEditingController _isimController = TextEditingController();
  final TextEditingController _soyisimController = TextEditingController();


  bool _isTextVisible = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        _isTextVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/travel.jpg',
            fit: BoxFit.cover, // Resmin kapsayıcıyı kaplaması
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_isTextVisible)
                  Column(
                    children: [
                      // Hoşgeldiniz metnini içeren kutu
                      Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.black54, // Arka plan rengi
                          borderRadius: BorderRadius.circular(8.0), // Köşe yuvarlama
                        ),
                        child: Text(
                          "Hoşgeldiniz",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Metin ve input alanı arasına boşluk
                      // İsim için text field
                      TextField(
                        controller: _isimController,
                        decoration: InputDecoration(
                          labelText: "İsim",
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 10), // İsim ve soyisim input alanları arasına boşluk
                      TextField(
                        controller: _soyisimController,
                        decoration: InputDecoration(
                          labelText: "Soyisim",
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 20), // Soyisim input alanı ile buton arasına boşluk
                      // Kaydet butonu
                      ElevatedButton(
                        onPressed: () {
                          // Kullanıcıdan alınan isim ve soyisim
                          String isim = _isimController.text;
                          String soyisim = _soyisimController.text;
                          // PlanYap sayfasına geçiş
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => PlanYap(isim: isim, soyisim: soyisim),
                            ),
                          );
                        },
                        child: Text("Kaydet"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
