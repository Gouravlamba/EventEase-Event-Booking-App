import 'package:flutter/material.dart';
import 'package:frontend/state_management/providers/event_provider.dart';
import 'package:provider/provider.dart';

class EventFilter extends StatefulWidget {
  const EventFilter({super.key});

  @override
  State<EventFilter> createState() => _EventFilterState();
}

class _EventFilterState extends State<EventFilter> {
  final _searchController = TextEditingController();
  DateTime? _selectedDate;
  String? _category;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);

    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search by title/location/category',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) => setState(() {}),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2030),
                );
                setState(() => _selectedDate = date);
              },
              child: const Text('Filter by Date'),
            ),
            const SizedBox(width: 10),
            DropdownButton<String>(
              hint: const Text('Category'),
              value: _category,
              items: ['Music', 'Sports', 'Tech', 'Art']
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => _category = value),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: provider.events
                .where((e) {
                  final searchMatch = _searchController.text.isEmpty ||
                      e.title
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()) ||
                      e.location
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()) ||
                      e.category
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase());

                  final dateMatch = _selectedDate == null ||
                      (e.date.year == _selectedDate!.year &&
                          e.date.month == _selectedDate!.month &&
                          e.date.day == _selectedDate!.day);

                  final categoryMatch =
                      _category == null || e.category == _category;

                  return searchMatch && dateMatch && categoryMatch;
                })
                .map((e) => Text('${e.title} | ${e.remainingSeats} seats'))
                .toList(),
          ),
        ),
      ],
    );
  }
}
