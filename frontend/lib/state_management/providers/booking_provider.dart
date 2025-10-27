import 'package:flutter/material.dart';
import '../../data/models/booking_model.dart';
import '../../data/models/event_model.dart';

class BookingProvider with ChangeNotifier {
  List<BookingModel> _bookings = [];
  bool _loading = false;

  List<BookingModel> get bookings => _bookings;
  bool get loading => _loading;

  /// Dummy events using assetImage getter
  final List<EventModel> dummyEvents = List.generate(7, (index) {
    return EventModel(
      id: "${index + 1}",
      title: "Event #${index + 1}",
      description: "This is the description for Event #${index + 1}.",
      category: "General",
      date: DateTime(2025, 10 + index, 18, 18, 0),
      location: "City ${index + 1}",
      totalSeats: 100 + index * 10,
      bookedSeats: index * 5,
      imageUrl: '', // empty so assetImage getter works
    );
  });

  /// Fetch dummy bookings (initially empty)
  Future<void> fetchBookings() async {
    _loading = true;
    notifyListeners();
    await Future.delayed(
        const Duration(milliseconds: 500)); // simulate network delay
    _bookings = []; // start empty
    _loading = false;
    notifyListeners();
  }

  /// Create a new dummy booking from an EventModel
  Future<void> createBooking(EventModel event) async {
    final booking = BookingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      bookingId: "BKG-${DateTime.now().month}${DateTime.now().year}-XYZ",
      userId: "1",
      event: event,
      seats: 1,
      createdAt: DateTime.now(),
      pdfUrl: "",
    );

    _bookings.add(booking);
    notifyListeners();
  }


  void cancelBooking(String bookingId) {
    _bookings.removeWhere((b) => b.id == bookingId);
    notifyListeners();
  }
}
