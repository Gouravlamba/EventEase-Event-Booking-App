import '../models/event_model.dart';
import '../services/event_service.dart';

class EventRepository {
  final EventService service;
  EventRepository(this.service);

  Future<List<EventModel>> getAllEvents() => service.fetchEvents();
}
