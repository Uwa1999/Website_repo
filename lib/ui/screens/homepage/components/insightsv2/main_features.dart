import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/provider/article_provider.dart';
import '../../../insights/articles/article_main.dart';
import '../../../insights/articlesv2/articlev2main.dart';
import '../../../insights/articlesv2/components/articlescreenv2.dart';
import '../../../shared/utils/responsive.dart';
import 'package:http/http.dart' as http;

class MainFeaturedSection extends StatefulWidget {
  const MainFeaturedSection({Key? key}) : super(key: key);

  @override
  State<MainFeaturedSection> createState() => _MainFeaturedSectionState();
}

class _MainFeaturedSectionState extends State<MainFeaturedSection> {
  List<dynamic> mainArticles = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchMainArticles();
  }

  Future<void> fetchMainArticles() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/insights/index'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          mainArticles = (data['data']['data'] as List).where((article) {
            return article['is_published'] == true &&
                article['remarks'] == 'Main';
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load articles: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching articles: $e';
      });
    }
  }

  void _navigateToArticleDetails(Map<String, dynamic> article) {
    final articleProvider = Provider.of<ArticleProvider>(context, listen: false);
    articleProvider.setArticleData(article); // update current article

    Navigator.pushNamed(
      context,
      ArticleDescMain.route, // Using the named route
    );
  }

  Widget _buildMainArticlesRow() {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth < 1024;

    // Calculate card width based on screen size
    double cardWidth;
    if (isMobile) {
      cardWidth = screenWidth * 0.85;
    } else if (isTablet) {
      cardWidth = screenWidth / 2 - 32;
    } else {
      cardWidth = 280; // Fixed width for desktop
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 75),
              child: Text(
                'Featured Insights',
                style: TextStyle(
                  fontSize: isMobile ? 28 : 46,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 75),
          child: SizedBox(
            height: isMobile ? null : 360,
            child: isMobile
                ? ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: mainArticles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ArticleCard(
                    imageUrl: mainArticles[index]['image_path'] ?? '',
                    category: mainArticles[index]['category'] ?? '',
                    title: mainArticles[index]['title'] ?? '',
                    width: cardWidth,
                    article: mainArticles[index],
                    onTap: () => _navigateToArticleDetails(mainArticles[index]),
                  ),
                );
              },
            )
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: mainArticles
                    .map((article) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ArticleCard(
                    imageUrl: article['image_path'] ?? '',
                    category: article['category'] ?? '',
                    title: article['title'] ?? '',
                    width: cardWidth,
                    article: article,
                    onTap: () => _navigateToArticleDetails(article),
                  ),
                ))
                    .toList(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (mainArticles.isEmpty) {
      return const SizedBox(); // Return empty if no main articles
    }

    return _buildMainArticlesRow();
  }
}