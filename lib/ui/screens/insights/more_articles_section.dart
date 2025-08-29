import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'articlesv2/articlev2main.dart';

class MoreArticlesSection extends StatefulWidget {
  final String currentArticleId;
  final String categoryFilter;

  const MoreArticlesSection({
    Key? key,
    required this.currentArticleId,
    required this.categoryFilter,
  }) : super(key: key);

  @override
  State<MoreArticlesSection> createState() => _MoreArticlesSectionState();
}

class _MoreArticlesSectionState extends State<MoreArticlesSection> {
  List<dynamic> articles = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/insights/index'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          articles = (data['data']['data'] as List)
              .where((article) =>
          article['is_published'] == true &&
              article['category'] == widget.categoryFilter &&
              article['id'].toString() != widget.currentArticleId) // Exclude current article
              .toList();
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

  String _getNoArticlesMessage() {
    switch (widget.categoryFilter.toLowerCase()) {
      case 'news':
        return 'No more news found';
      case 'articles':
        return 'No more articles found';
      case 'updates':
        return 'No more updates found';
      case 'announcements':
        return 'No more announcements found';
    // Add more cases as needed for your categories
      default:
        return 'No more ${widget.categoryFilter.toLowerCase()} found';
    }
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

    if (articles.isEmpty) {
      return Center(child: Text(_getNoArticlesMessage()));
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth < 600
        ? screenWidth * 0.85
        : screenWidth < 1024
        ? screenWidth / 2 - 32
        : 320;

    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 24,
      runSpacing: 24,
      children: articles
          .map((article) => ArticleCard(
        imageUrl: article['image_path'] ?? '',
        category: article['category'] ?? '',
        title: article['title'] ?? '',
        width: cardWidth,
        article: article,
        onTap: () => _navigateToArticleDetails(article),
      ))
          .toList(),
    );
  }

  void _navigateToArticleDetails(Map<String, dynamic> article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDescMainv2(
          articleId: article['id'].toString(),
        ),
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String title;
  final double width;
  final Map<String, dynamic> article;
  final VoidCallback onTap;

  const ArticleCard({
    Key? key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.width,
    required this.article,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                    imageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 160,
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image),
                    ),
                  )
                      : Container(
                    height: 160,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}