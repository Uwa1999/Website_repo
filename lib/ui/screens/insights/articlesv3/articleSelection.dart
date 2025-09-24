import 'dart:convert';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv3/viewMainEvents.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv3/viewMainNews.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/components/articlescreenv2.dart';
import 'package:provider/provider.dart';
import '../../../../core/provider/article_provider.dart';
import '../../insights/articlesv3/viewMainArticle.dart';

class ArticleSelection extends StatefulWidget {
  const ArticleSelection({super.key});

  @override
  State<ArticleSelection> createState() => _ArticleSelectionState();
}

class _ArticleSelectionState extends State<ArticleSelection> {
  List<Map<String, dynamic>> articleList = [];
  List<Map<String, dynamic>> newsList = [];
  List<Map<String, dynamic>> eventList = [];
  bool isLoading = true;

  @override
  void initState() {
    fetchAllArticles();
    super.initState();
  }

  Future<void> fetchAllArticles() async {
    try {
      final response = await http.get(
          Uri.parse(
              'https://dev-api-janus.fortress-asya.com:18043/api/public/v1/insights/index'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> imgData = jsonResponse['data']['data'];

        if (mounted) {
          setState(() {
            articleList = imgData.where((data) => data['category'] == 'Articles')
                .map((data) => Map<String, dynamic>.from(data)).toList();

            newsList = imgData.where((data) => data['category'] == 'News')
                .map((data) => Map<String, dynamic>.from(data)).toList();

            eventList = imgData.where((data) => data['category'] == 'Events')
                .map((data) => Map<String, dynamic>.from(data)).toList();

            isLoading = false;
          });
        }
      } else {
        print('Failed to load images: ${response.statusCode}');
        if (mounted) setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error fetching images: $e');
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else ...[
            // --- Articles Section ---
            const Text(
              'More Articles',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 16),
            _buildArticleList(context, articleList),
            const SizedBox(height: 40),
            // --- News Section ---
            const Text(
              'More News',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 16),
            _buildArticleList(context, newsList),
            const SizedBox(height: 40),
            // --- Events Section ---
            const Text(
              'More Events',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 16),
            _buildArticleList(context, eventList),
          ],
        ],
      ),
    );
  }

  Widget _buildArticleList(BuildContext context, List<Map<String, dynamic>> list) {
    if (list.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: Text('No items found.'),
        ),
      );
    }

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final article = list[index];
          final cardWidth = MediaQuery.of(context).size.width * 0.3;

          return Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: SizedBox(
              width: cardWidth,
              child: ArticleCard(
                imageUrl: article['image_path'] ?? '',
                category: article['category'] ?? '',
                title: article['title'] ?? '',
                width: cardWidth,
                article: article,
                onTap: () {
                  final provider = Provider.of<ArticleProvider>(context, listen: false);
                  provider.setArticleData(article);

                  if (article['category'] == 'Articles') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainArticle(
                          imgPath: article['image_path'],
                          publishedAt: article['published_at'],
                          id: article['id'].toString(),
                          articleData: article,
                        ),
                      ),
                    );
                  } else if (article['category'] == 'News') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainNews(
                          id: article['id'].toString(),
                          imgPath: article['image_path'],
                          publishedAt: article['published_at'],
                          articleData: article,
                        ),
                      ),
                    );
                  } else if (article['category'] == 'Events') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainEvents(
                          id: article['id'].toString(),
                          imgPath: article['image_path'],
                          publishedAt: article['published_at'],
                          articleData: article,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}