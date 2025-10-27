import 'package:flutter/material.dart';
import 'package:frontend/data/services/local_asset_service.dart';
import '../../data/models/event_model.dart';

class EventProvider with ChangeNotifier {
  List<EventModel> _events = [];
  bool _loading = false;

  List<EventModel> get events => _events;
  bool get loading => _loading;

 
  Future<void> fetchEvents([String? token]) async {
    _loading = true;
    notifyListeners();

    try {
   
      final localService = LocalAssetService();
      _events = await localService.loadEventsFromAssets();

     
      _events.sort((a, b) => a.date.compareTo(b.date));
    } catch (e) {
      debugPrint("Error loading local events: $e");
      _events = []; 
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  
  List<EventModel> searchEvents(String query) {
    if (query.isEmpty) return _events;
    return _events
        .where((e) =>
            e.title.toLowerCase().contains(query.toLowerCase()) ||
            e.location.toLowerCase().contains(query.toLowerCase()) ||
            e.category.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  
  List<EventModel> filterByDate(DateTime? date) {
    if (date == null) return _events;
    return _events
        .where((e) =>
            e.date.year == date.year &&
            e.date.month == date.month &&
            e.date.day == date.day)
        .toList();
  }


  List<EventModel> filterByCategory(String category) {
    if (category.isEmpty || category == 'All') return _events;
    return _events
        .where((e) => e.category.toLowerCase() == category.toLowerCase())
        .toList();
  }
}
