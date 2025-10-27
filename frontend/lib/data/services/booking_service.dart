import 'api_service.dart';
import '../../config/api_endpoints.dart';
import '../models/booking_model.dart';

class BookingService {
  final ApiService api;

  BookingService(this.api);

  Future<List<BookingModel>> fetchBookings() async {
    final data = await api.get(ApiEndpoints.bookings);
    return (data['bookings'] as List)
        .map((b) => BookingModel.fromJson(b))
        .toList();
  }

  Future<BookingModel> createBooking(String eventId, int seats) async {
    final data = await api.post(ApiEndpoints.bookings, {
      'eventId': eventId,
      'seats': seats,
    });
    return BookingModel.fromJson(data['booking']);
  }
}
