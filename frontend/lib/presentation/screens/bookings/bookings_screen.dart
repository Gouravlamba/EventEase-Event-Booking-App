import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state_management/providers/booking_provider.dart';
import '../../widgets/booking_card.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);
    final bookings = provider.bookings;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(title: const Text("My Bookings")),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : bookings.isEmpty
              ? const Center(child: Text("No bookings yet"))
              : ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return BookingCard(
                      booking: booking,
                      onCancel: () => provider.cancelBooking(booking.id),
                    );
                  },
                ),
    );
  }
}
