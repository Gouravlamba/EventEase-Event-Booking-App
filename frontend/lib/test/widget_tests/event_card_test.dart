import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';
import 'package:frontend/data/models/event_model.dart';
import 'package:frontend/presentation/widgets/event_card.dart';

void main() {
  testWidgets('EventCard shows title and seats', (tester) async {
    final event = EventModel(
      id: '1',
      title: 'Test Event',
      description: '',
      category: '',
      date: DateTime.now(),
      location: 'Test City',
      totalSeats: 100,
      bookedSeats: 50,
      imageUrl: '',
    );

    await tester.pumpWidget(MaterialApp(home: EventCard(event: event)));

    expect(find.text('Test Event'), findsOneWidget);
    expect(find.text('50 seats left'), findsOneWidget);
  });
}
