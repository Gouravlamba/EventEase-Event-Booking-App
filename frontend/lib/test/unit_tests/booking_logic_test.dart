import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/data/models/event_model.dart';

void main() {
  test('Event remaining seats calculation', () {
    final event = EventModel(
      id: '1',
      title: 'Test',
      description: '',
      category: '',
      date: DateTime.now(),
      location: '',
      totalSeats: 100,
      bookedSeats: 40,
      imageUrl: '',
    );
    expect(event.remainingSeats, 60);
  });
}
