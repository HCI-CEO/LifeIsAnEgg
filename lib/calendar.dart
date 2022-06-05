import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        focusedDay: focusedDay,
        firstDay: DateTime(2020),
        lastDay: DateTime(2030),
        calendarFormat: format,
        onFormatChanged: (CalendarFormat _format) {
          setState(() {
            format = _format;
          });
        },
        daysOfWeekVisible: true,

        // Day Changed
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          setState(() {
            selectedDay = selectDay;
            focusedDay = focusDay;
          });
          print(focusedDay);
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },

        // Style
        calendarStyle: CalendarStyle(
          // isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: Color(0xffFFF1CD),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
          selectedTextStyle: TextStyle(color: Color(0xff2E2E2E)),
          todayDecoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffCBEBD8),
              width: 5.0
            ),
            // color: Color(0xffCBEBD8),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
          todayTextStyle: TextStyle(color: Color(0xff2E2E2E)),
        ),
        headerStyle: HeaderStyle(
          headerMargin: EdgeInsets.only(bottom: 12),
          formatButtonVisible: false,
          titleCentered: true,
          decoration: BoxDecoration(
            color: Color(0xffCBEBD8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              // bottomLeft: Radius.circular(10),
              // bottomRight: Radius.circular(10)
            ),
          ),
        ),
      ),
    );
  }
}