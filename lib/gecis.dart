import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gezi_rehberi/anasayfa.dart';



class GecisScreen extends StatefulWidget {
  @override
  _GecisScreenState createState() => _GecisScreenState();
}

class _GecisScreenState extends State<GecisScreen> {
  @override
  void initState() {
    super.initState();
    // 3 saniye sonra MainScreen'e geçiş
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Anasayfa()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/travel.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
