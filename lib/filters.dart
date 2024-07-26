import 'package:flutter/material.dart';

class FiltrelerWidget extends StatelessWidget {
  final List<String> filtreler;
  final List<String> selectedFiltreler;
  final Function(String) onSelectFiltre;

  FiltrelerWidget({
    required this.filtreler,
    required this.selectedFiltreler,
    required this.onSelectFiltre,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate((filtreler.length / 3).ceil(), (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (idx) {
                int realIndex = index * 3 + idx;
                if (realIndex < filtreler.length) {
                  bool secili = selectedFiltreler.contains(filtreler[realIndex]);
                  return GestureDetector(
                    onTap: () {
                      onSelectFiltre(filtreler[realIndex]);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: secili ? Colors.blue[900] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        filtreler[realIndex],
                        style: TextStyle(
                          color: secili ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
            ),
          );
        }),
      ),
    );
  }
}
