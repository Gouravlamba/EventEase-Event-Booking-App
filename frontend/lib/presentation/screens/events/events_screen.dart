import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state_management/providers/event_provider.dart';
import '../../widgets/event_card.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<EventProvider>(context, listen: false);
    provider.fetchEvents(null); 
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);

    return provider.loading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.events.length,
            itemBuilder: (_, index) {
              final event = provider.events[index];
              return EventCard(event: event);
            },
          );
  }
}
