import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://cricbuzz-cricket.p.rapidapi.com/stats/v1/rankings/batsmen';

  static Future<Map<String, dynamic>?> fetchRanking(
      {String formatType = 'test'}) async {
    final Uri url = Uri.parse(baseUrl);

    final Map<String, String> headers = {
      'X-RapidAPI-Key': '4b22548360msh6e7148078d97ae8p180705jsn11d44b0880f0',
      'X-RapidAPI-Host': 'cricbuzz-cricket.p.rapidapi.com',
    };

    final Map<String, String> params = {
      'formatType': formatType,
    };

    final response =
        await http.get(url.replace(queryParameters: params), headers: headers);

    try {
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
