import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gocric/Widget/newscard.dart';
import 'news_api_service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic>? newsList;
  bool isLoading = true;
  int activeIndex = 0;

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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (newsList != null && newsList!.isNotEmpty)
              ? ListView.builder(
                  itemCount: newsList!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Carousel Slider
                      return Column(
                        children: [
                          CarouselSlider.builder(
                            itemCount: 5,
                            itemBuilder: (context, index, realIndex) {
                              String image = 'assets/image_$index.jpg';
                              String name = 'News Headline $index';
                              return buildCarouselItem(image, name);
                            },
                            options: CarouselOptions(
                              height: 250,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Center(child: buildIndicator()),
                          SizedBox(height: 30.0),
                        ],
                      );
                    }

                    // Regular News Card
                    final news = newsList![index - 1]['story'];
                    if (news != null) {
                      return NewsCard(
                        headline: news['hline'] ?? '',
                        introduction: news['intro'] ?? '',
                        publicationTime: _formatTimeDifference(news['pubTime']),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                )
              : const Center(
                  child: Text('No news data available'),
                ),
    );
  }

  Widget buildCarouselItem(String image, String name) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                height: 250,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              height: 250,
              padding: EdgeInsets.only(left: 10.0),
              margin: EdgeInsets.only(top: 170.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  name,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: SlideEffect(
          dotWidth: 15,
          dotHeight: 15,
          activeDotColor: Colors.blue,
        ),
      );

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
