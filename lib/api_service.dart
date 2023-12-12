// api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> fetchData() async {
    String live = 'list-live';
    //String datelist;

    final String apiUrl = 'https://livescore6.p.rapidapi.com/matches/v2/$live';

    final Map<String, String> headers = {
      'X-RapidAPI-Key': '4b22548360msh6e7148078d97ae8p180705jsn11d44b0880f0',
      'X-RapidAPI-Host': 'livescore6.p.rapidapi.com',
    };

    final Map<String, String> params = {
      'Category': 'cricket',
      'Timezone': '-7',
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
