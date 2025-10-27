class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String category;
  final int totalSeats;
  final int bookedSeats;
  final int remainingSeats;
  final String imageUrl;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.category,
    this.totalSeats = 0,
    this.bookedSeats = 0,
    this.remainingSeats = 0,
    this.imageUrl = '',
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      totalSeats: json['totalSeats'] ?? json['capacity'] ?? 0,
      bookedSeats: json['bookedSeats'] ?? 0,
      remainingSeats: json['remainingSeats'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'date': date.toIso8601String(),
        'location': location,
        'category': category,
        'totalSeats': totalSeats,
        'bookedSeats': bookedSeats,
        'remainingSeats': remainingSeats,
        'imageUrl': imageUrl,
      };
  String get assetImage {
    // If imageUrl empty, use a fallback from 1–7
    int imgIndex = int.tryParse(id) ?? 1;
    if (imgIndex > 7) imgIndex = (imgIndex % 7) + 1;
    return imageUrl.isNotEmpty ? imageUrl : 'assets/images/$imgIndex.jpg';
  }
}
