import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:frontend/presentation/screens/bookings/calendar_view.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  testWidgets('Calendar displays correctly', (tester) async {
    await tester.pumpWidget(MaterialApp(home: const CalendarView()));
    expect(find.byType(TableCalendar), findsOneWidget);
  });
}
