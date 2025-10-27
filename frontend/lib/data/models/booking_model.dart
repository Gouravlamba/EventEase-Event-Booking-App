import 'event_model.dart';

class BookingModel {
  final String id;
  final String bookingId;
  final String userId;
  final EventModel event;
  final int seats;
  final DateTime createdAt;
  final String pdfUrl;

  BookingModel({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.event,
    required this.seats,
    required this.createdAt,
    required this.pdfUrl,
  });


  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'].toString(),
      bookingId: json['bookingId'] ?? '',
      userId: json['userId'] ?? '',
      event: json['event'] != null
          ? EventModel.fromJson(json['event'])
          : EventModel(
              id: 'E1',
              title: 'Sample Event',
              description: 'Demo event',
              date: DateTime.now(),
              location: 'Virtual',
              category: 'General',
              // capacity: 100,
            ),
      seats: json['seats'] ?? 1,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      pdfUrl: json['pdfUrl'] ?? '',
    );
  }


  Map<String, dynamic> toJson() => {
        'id': id,
        'bookingId': bookingId,
        'userId': userId,
        'event': event.toJson(),
        'seats': seats,
        'createdAt': createdAt.toIso8601String(),
        'pdfUrl': pdfUrl,
      };
}
