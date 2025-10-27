import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/event_model.dart';

class LocalAssetService {
  Future<List<EventModel>> loadEventsFromAssets() async {
    final raw = await rootBundle.loadString('assets/mock_events.json');
    final List<dynamic> jsonData = json.decode(raw);
    return jsonData.map((e) => EventModel.fromJson(e)).toList();
  }
}
