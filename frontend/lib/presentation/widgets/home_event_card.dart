import 'package:flutter/material.dart';
import '../../../data/models/event_model.dart';

class HomeEventCard extends StatelessWidget {
  final EventModel event;
  final double height; // <-- Add this

  const HomeEventCard({
    super.key,
    required this.event,
    this.height = 160, // default height
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Event Image
          SizedBox(
            height: height, // <-- use height here
            width: double.infinity,
            child: Image.asset(
              event.assetImage,
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay
          Container(
            height: height, // <-- use height here too
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Text overlay
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  event.location,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "Seats: ${event.totalSeats - event.bookedSeats} available",
                  style:
                      const TextStyle(color: Colors.orangeAccent, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
