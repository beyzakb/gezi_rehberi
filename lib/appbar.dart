import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          print("Menu icon clicked!");
        },
      ),
      title: Text("Gezi Rehberim"),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            print("Person icon clicked!");
          },
        ),
      ],
      backgroundColor: Colors.blue[900],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
