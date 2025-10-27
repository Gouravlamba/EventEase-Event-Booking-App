import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_endpoints.dart';

class ApiService {
  final String? token;

  ApiService({this.token});

  Map<String, String> _headers() => {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  Future<dynamic> get(String url) async {
    final response = await http.get(Uri.parse(url), headers: _headers());
    _handleResponse(response);
    return json.decode(response.body);
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: _headers(),
      body: json.encode(body),
    );
    _handleResponse(response);
    return json.decode(response.body);
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('API error: ${response.statusCode} → ${response.body}');
    }
  }
}
