import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calandar extends StatefulWidget {
  final void Function(DateTime?) _onSelectNewDate;

  const Calandar({Key? key, required void Function(DateTime?) onSelectNewDate})
      : _onSelectNewDate = onSelectNewDate,
        super(key: key);

  @override
  State<Calandar> createState() => _CalandarState();
}

class _CalandarState extends State<Calandar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        widget._onSelectNewDate(_selectedDay);
      },
      headerStyle: HeaderStyle(
          rightChevronIcon:
              Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
          leftChevronIcon:
              Icon(Icons.chevron_left, color: Theme.of(context).primaryColor)),
      calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(200),
              shape: BoxShape.circle),
          selectedDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor, shape: BoxShape.circle)),
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
    );
  }
}
