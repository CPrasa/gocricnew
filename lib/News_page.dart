import 'package:flutter/material.dart';
import 'package:gocric/Widget/newscard.dart';
import 'news_api_service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic>? newsList; // Change the type to a nullable dynamic list
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNewsData();
  }

  Future<void> fetchNewsData() async {
    try {
      final newsData = await NewsApiService.fetchNews();

      if (newsData != null && newsData['storyList'] != null) {
        setState(() {
          newsList = newsData['storyList'];
          isLoading = false;
        });
      } else {
        // Handle null or empty response
        print('News data is null or empty');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      // appBar: AppBar(
      //   title: const Text(
      //     'GoCric News',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       color: Colors.deepPurple,
      //       fontSize: 30,
      //     ),
      //   ),
      //   backgroundColor: Colors.deepPurple.shade200,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(
      //         Icons.home,
      //         size: 30,
      //       ),
      //       onPressed: () {
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (context) => const HomePage()),
      //         );
      //       },
      //     ),
      //     IconButton(
      //       icon: const Icon(
      //         Icons.newspaper_rounded,
      //         size: 30,
      //         color: Colors.deepPurple,
      //       ),
      //       onPressed: () {
      //         // Add your favorite logic here
      //         // ...
      //       },
      //     ),
      //   ],
      // ),
      // drawer: NavBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (newsList != null && newsList!.isNotEmpty)
              ? ListView.builder(
                  itemCount: newsList!.length,
                  itemBuilder: (context, index) {
                    final news = newsList![index]['story'];
                    if (news != null) {
                      return NewsCard(
                        headline: news['hline'] ?? '',
                        introduction: news['intro'] ?? '',
                        publicationTime: _formatTimeDifference(news['pubTime']),
                      );
                    } else {
                      return const SizedBox
                          .shrink(); // Return an empty widget if news is null
                    }
                  },
                )
              : const Center(
                  child: Text('No news data available'),
                ),
    );
  }

  String _formatTimeDifference(String pubTime) {
    final DateTime now = DateTime.now();
    final DateTime pubDateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(pubTime));

    final Duration difference = now.difference(pubDateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}
