import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  final String baseUrl = 'https://app.ticketmaster.com/discovery/v2/events.json?countryCode=US&apikey=AJIubp2Y9E8NY4rBrYmVt2nJqHjghF8S&size=30';
  DebugPrintCallback debugPrint = debugPrintThrottled;

  Future<List<dynamic>> fetchEvents() async {

    final response = await http.get(Uri.parse('$baseUrl'));
    final parseResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return parseResponse["_embedded"]["events"];
    } else {
      throw Exception('Failed to fetch events');
    }
  }
}
