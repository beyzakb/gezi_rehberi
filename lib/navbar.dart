import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  MyBottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.travel_explore),
          label: 'Planlarım',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Plan Yap',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Ben',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.blue[900],
      unselectedItemColor: Colors.grey,
      onTap: onTap,
    );
  }
}
