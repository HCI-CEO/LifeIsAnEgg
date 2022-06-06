import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:life_is_an_egg/global_data.dart' as data;

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}


class _CalendarState extends State<Calendar> {

  Widget _buildEventsMarkerNum(DateTime day, DateTime selectedDay) {
    return Transform.translate(
      offset: const Offset(0,-6),
      child: Container (
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          color:
          selectedDay.month == day.month && selectedDay.day == day.day ? const Color(0xffFFF1CD) : const Color(0xffCCEBD8)
        ),
        child: Center(
          child: Text(
            day.day.toString(),
            style: const TextStyle().copyWith(
              color: const Color(0xff2E2E2E),
            ),
          ),
        ),
      ),
    );
  }
  CalendarFormat format = CalendarFormat.month;

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    DateTime selectedDay = context.watch<data.CalendarData>().selectedDay;
    var calendar = context.watch<data.CalendarData>().calendar;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: TableCalendar(
        focusedDay: focusedDay,
        firstDay: DateTime(2022,1,1),
        lastDay: DateTime(2022,12,31),
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
            // selectedDay = selectDay;
            context.read<data.CalendarData>().changeDay(selectDay);
            focusedDay = focusDay;
          });
          // print(focusedDay);
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },
        // Style
        calendarStyle: CalendarStyle(
          // isTodayHighlighted: true,
          selectedDecoration: (selectedDay.month == DateTime.now().month && selectedDay.day == DateTime.now().day) ? BoxDecoration(
            border: Border.all(
                color: const Color(0xffCBEBD8),
                width: 5.0
            ),
              borderRadius: BorderRadius.circular(8.0),
          ) : BoxDecoration(
            color: const Color(0xffFFF1CD), // 노란색
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
          selectedTextStyle: const TextStyle(color: Color(0xff2E2E2E)),
          todayDecoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffCBEBD8),
              width: 5.0
            ),
            // color: Color(0xffCBEBD8),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
          todayTextStyle: const TextStyle(color: Color(0xff2E2E2E)),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
          weekendDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        availableCalendarFormats: const { CalendarFormat.month: 'Month'},
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (calendar.containsKey(date.month) && calendar[date.month]!.containsKey(date.day)) {
              if (!(DateTime.now().month == date.month && DateTime.now().day == date.day)) {
                return _buildEventsMarkerNum(date, selectedDay);
              }
            }
          }
        ),
        headerStyle: const HeaderStyle(
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