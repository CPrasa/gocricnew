// news_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  static const String baseUrl =
      'https://cricbuzz-cricket.p.rapidapi.com/news/v1/index';

  static Future<Map<String, dynamic>?> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: {
        'X-RapidAPI-Key': '4b22548360msh6e7148078d97ae8p180705jsn11d44b0880f0',
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
