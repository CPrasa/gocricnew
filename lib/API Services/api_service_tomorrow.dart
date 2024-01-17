import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceTomorrow {
  static Future<Map<String, dynamic>?> fetchDataTomorrow() async {
    String datelist = 'list-by-date';
    final String apiUrl =
        'https://livescore6.p.rapidapi.com/matches/v2/$datelist';

    final Map<String, String> headers = {
      'X-RapidAPI-Key': '889b3cc290msh3a6002ff66b137dp1c409bjsn0d6ab11fc890',
      'X-RapidAPI-Host': 'livescore6.p.rapidapi.com',
    };

    final Map<String, String> params = {
      'Category': 'cricket',
      'Timezone': '-7',
      'Date': _getTomorrowDate(),
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  static String _getTomorrowDate() {
    // Get tomorrow's date in the format needed for the API call
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    String formattedDate =
        '${tomorrow.year}${_formatTwoDigits(tomorrow.month)}${_formatTwoDigits(tomorrow.day)}';
    return formattedDate;
  }

  static String _formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }
}
