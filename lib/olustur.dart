import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gezi_rehberi/final.dart';
import 'package:table_calendar/table_calendar.dart';
import 'appbar.dart';
import 'navbar.dart';
import 'calendar.dart';
import 'filters.dart';

class Olustur extends StatefulWidget {
  @override
  _OlusturState createState() => _OlusturState();
}

class _OlusturState extends State<Olustur> {
  List<String> _ilceler = [];
  List<String> _filteredIlceler = [];
  List<String> _selectedIlceler = [];
  List<String> _selectedFiltreler = [];
  TextEditingController _ilceAraController = TextEditingController();
  bool _showIlceler = false;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<String> _filtreler = [
    'Doğa',
    'Tarih',
    'Eğlence',
    'Sanat',
    'Kültür',
    'Alışveriş',
  ];

  @override
  void initState() {
    super.initState();
    _loadIlceler();
  }

  Future<void> _loadIlceler() async {
    try {
      final String response = await rootBundle.loadString('assets/ilceler.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        _ilceler = List<String>.from(data);
        _filteredIlceler = _ilceler;
      });
    } catch (e) {
      print('ilceler.json yüklenirken hata oluştu: $e');
    }
  }

  void _filterIlceler(String query) {
    setState(() {
      _filteredIlceler = _ilceler.where((ilce) => ilce.toLowerCase().contains(query.toLowerCase())).toList();
      _showIlceler = true;
    });
  }

  void _selectIlce(String ilce) {
    setState(() {
      if (!_selectedIlceler.contains(ilce)) {
        _selectedIlceler.add(ilce);
      }
      _ilceAraController.text = '';
      _showIlceler = false;
    });
  }

  void _selectFiltre(String filtre) {
    setState(() {
      if (!_selectedFiltreler.contains(filtre)) {
        _selectedFiltreler.add(filtre);
      } else {
        _selectedFiltreler.remove(filtre);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // İlçe seçme container'ı
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showIlceler = !_showIlceler;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedIlceler.isEmpty ? "İlçe seçin" : _selectedIlceler.join(", "),
                        style: TextStyle(
                          color: _selectedIlceler.isEmpty ? Colors.grey : Colors.black,
                        ),
                      ),
                      Icon(_showIlceler ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
            ),
            if (_showIlceler && _filteredIlceler.isNotEmpty)
              Container(
                height: 200,
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: _filteredIlceler.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_filteredIlceler[index]),
                      onTap: () {
                        _selectIlce(_filteredIlceler[index]);
                      },
                    );
                  },
                ),
              ),
            SizedBox(height: 16),

            // Seçilen ilçelerin kutusu
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                children: _selectedIlceler.map((ilce) {
                  return Chip(
                    label: Text(
                      ilce,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue[900],
                    deleteIcon: Icon(Icons.clear, color: Colors.white),
                    onDeleted: () {
                      setState(() {
                        _selectedIlceler.remove(ilce);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),

            // Takvim widget'ı
            CalendarWidget(
              calendarFormat: _calendarFormat,
              selectedDay: _selectedDay,
              focusedDay: _focusedDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),

            SizedBox(height: 16),

            // Filtreler
            FiltrelerWidget(
              filtreler: _filtreler,
              selectedFiltreler: _selectedFiltreler,
              onSelectFiltre: _selectFiltre,
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          // BottomNavigationBar'dan tıklanan öğeye göre işlem yapabilirsiniz
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          print("Hadi Gidelim clicked!");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FinalPage()), // FinalPage'e geçiş
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            "Hadi Gidelim",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
