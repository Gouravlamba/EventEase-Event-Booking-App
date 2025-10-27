import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/data/models/event_model.dart';

void main() {
  test('Event remaining seats after booking', () {
    final event = EventModel(
      id: '1',
      title: 'Music Fest',
      description: '',
      category: 'Music',
      date: DateTime.now(),
      location: 'City',
      totalSeats: 50,
      bookedSeats: 20,
      imageUrl: '',
    );
    expect(event.remainingSeats, 30);
  });
}
