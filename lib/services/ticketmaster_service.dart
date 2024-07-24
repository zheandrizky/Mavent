import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mavent/models/event_model.dart';

class ApiService {
  static const String baseUrl =
      'https://app.ticketmaster.com/discovery/v2/events.json';
  static const String apiKey =
      'gssjyOaSPDXgnaCeHr5eYDrSerlYSNK0'; // Replace with your Ticketmaster API key

  Future<List<EventModel>> fetchEvents(String searchQuery) async {
    final response = await http
        .get(Uri.parse('$baseUrl?apikey=$apiKey&keyword=$searchQuery'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> events = data['_embedded']['events'];
      return events.map((json) => EventModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}
