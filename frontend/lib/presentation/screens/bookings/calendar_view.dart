import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../../../state_management/providers/booking_provider.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);
    final bookings = provider.bookings;

    Map<DateTime, List> bookingsMap = {};
    for (var b in bookings) {
      final day = DateTime(b.createdAt.year, b.createdAt.month, b.createdAt.day);
      bookingsMap[day] = bookingsMap[day] == null ? [b] : [...bookingsMap[day]!, b];
    }

    return TableCalendar(
      firstDay: DateTime(2023),
      lastDay: DateTime(2030),
      focusedDay: DateTime.now(),
      eventLoader: (day) => bookingsMap[day] ?? [],
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        markerDecoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      ),
    );
  }
}
