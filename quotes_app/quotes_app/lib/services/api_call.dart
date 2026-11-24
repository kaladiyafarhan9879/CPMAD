import 'dart:convert';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:http/http.dart' as http;
import '../models/quotes_model.dart';

class ApiCall {
  Future<Quotes?> fetchRandomQuote() async {
    try {
      // DummyJSON supports CORS in Chrome/Web browsers
      final url = Uri.parse('https://dummyjson.com/quotes/random');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Quotes.fromJson(data);
      } else {
        debugPrint('API Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Network Exception: $e');
    }
    return null;
  }
}
