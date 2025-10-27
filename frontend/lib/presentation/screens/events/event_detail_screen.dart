import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/event_model.dart';
import '../../../state_management/providers/booking_provider.dart';

class EventDetailScreen extends StatelessWidget {
  final EventModel event;
  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(title: Text(event.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(event.assetImage,
                width: double.infinity, height: 250, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(event.description, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("Location: ${event.location}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                      "Date: ${event.date.day}/${event.date.month}/${event.date.year}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        bookingProvider.createBooking(event);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Booking Successful!")),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("Book Now"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
