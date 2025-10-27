import '../models/booking_model.dart';
import '../services/booking_service.dart';

class BookingRepository {
  final BookingService service;
  BookingRepository(this.service);

  Future<List<BookingModel>> getAllBookings() => service.fetchBookings();
  Future<BookingModel> createBooking(String eventId, int seats) =>
      service.createBooking(eventId, seats);
}
