import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceYesterday {
  static Future<Map<String, dynamic>?> fetchDataYesterday(
      {String? dateName, formtedDate}) async {
    String datelist = 'list-by-date';
    final String apiUrl =
        'https://livescore6.p.rapidapi.com/matches/v2/$datelist';

    final Map<String, String> headers = {
      //'X-RapidAPI-Key': '889b3cc290msh3a6002ff66b137dp1c409bjsn0d6ab11fc890',
      //'X-RapidAPI-Key': 'cec61bf002mshae792f4044c9c8bp1fb688jsnfe5dfb44071c',
      'X-RapidAPI-Key': '4b22548360msh6e7148078d97ae8p180705jsn11d44b0880f0',
      'X-RapidAPI-Host': 'livescore6.p.rapidapi.com',
    };

    final Map<String, String> params = {
      'Category': 'cricket',
      'Timezone': '-7',
      'Date': _getYesterdayDate(),
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

  static String _getYesterdayDate() {
    // Get yesterday's date in the format needed for the API call
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    String formattedDate =
        '${yesterday.year}${_formatTwoDigits(yesterday.month)}${_formatTwoDigits(yesterday.day)}';
    return formattedDate;
  }

  static String _formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }
}
