import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final Function(DateTime, DateTime) onDaySelected;

  CalendarWidget({
    required this.selectedDay,
    required this.focusedDay,
    required this.calendarFormat,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      focusedDay: focusedDay,
      firstDay: DateTime.utc(2020, 01, 01),
      lastDay: DateTime.utc(2030, 12, 31),
      calendarFormat: calendarFormat,
      onFormatChanged: (format) {},
      onDaySelected: (selectedDay, focusedDay) {
        onDaySelected(selectedDay, focusedDay);
      },
    );
  }
}
