import 'api_service.dart';
import '../../config/api_endpoints.dart';
import '../models/event_model.dart';

class EventService {
  final ApiService api;

  EventService(this.api);

  Future<List<EventModel>> fetchEvents() async {
    final data = await api.get(ApiEndpoints.events);
    return (data['events'] as List)
        .map((e) => EventModel.fromJson(e))
        .toList();
  }
}
