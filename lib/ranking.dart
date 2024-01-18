import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceRank {
  static const String baseUrl =
      'https://cricbuzz-cricket.p.rapidapi.com/stats/v1/rankings/batsmen';

  static Future<Map<String, dynamic>?> fetchRanking(
      {String formatType = 't20'}) async {
    final Uri url = Uri.parse(baseUrl);

    final Map<String, String> headers = {
      'X-RapidAPI-Key': '889b3cc290msh3a6002ff66b137dp1c409bjsn0d6ab11fc890',
      // //'X-RapidAPI-Key': '4b22548360msh6e7148078d97ae8p180705jsn11d44b0880f0',
      'X-RapidAPI-Key': 'cec61bf002mshae792f4044c9c8bp1fb688jsnfe5dfb44071c',
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

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  List<dynamic>? rankList;
  bool isLoading = true;
  String formatType = 't20'; // Default formatType

  @override
  void initState() {
    super.initState();
    fetchRanking();
  }

  Future<void> fetchRanking() async {
    try {
      final rankData =
          await ApiServiceRank.fetchRanking(formatType: formatType);

      if (rankData != null && rankData['rank'] != null) {
        setState(() {
          rankList = rankData['rank'];
          isLoading = false;
        });

        // Print the name of the first player
      } else {
        print('Ranking data is null or empty');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      debugPrint('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateFormatType(String newFormatType) {
    setState(() {
      formatType = newFormatType;
      fetchRanking();
    });
  }

  Widget _buildFilterChip(
      String label, bool selected, VoidCallback onSelected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (selected) => onSelected(),
      backgroundColor: selected ? Colors.blue : Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      labelStyle: const TextStyle(
        fontSize: 16,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      side: const BorderSide(
        color: Color.fromRGBO(0, 0, 0, 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // Chips for T20, ODI, and Test
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text(
                'Cricket Ranking',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Wrap(
                spacing: 8.0,
                children: [
                  _buildFilterChip(
                    'T20',
                    formatType == 't20',
                    () => updateFormatType('t20'),
                  ),
                  _buildFilterChip(
                    'ODI',
                    formatType == 'odi',
                    () => updateFormatType('odi'),
                  ),
                  _buildFilterChip(
                    'Test',
                    formatType == 'test',
                    () => updateFormatType('test'),
                  ),
                ],
              ),
            ),
            // Display rankings
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: rankList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            'Rank ${index + 1}: ${rankList?[index]['name'] ?? 'N/A'}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(rankList?[index]['country'] ?? 'N/A'),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
