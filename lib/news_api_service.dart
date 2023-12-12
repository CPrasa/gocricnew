// news_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  static const String baseUrl =
      'https://cricbuzz-cricket.p.rapidapi.com/news/v1/index';

  static Future<Map<String, dynamic>?> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: {
        'X-RapidAPI-Key': 'your-api-key',
        'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
      });

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // Handle API error response
        print('API error: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      // Handle network error
      print('Network error: $error');
      return null;
    }
  }
}
