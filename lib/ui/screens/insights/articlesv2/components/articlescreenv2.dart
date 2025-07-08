import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../articlev2main.dart';

class ArticleDescScreen extends StatefulWidget {
  const ArticleDescScreen({Key? key}) : super(key: key);

  @override
  State<ArticleDescScreen> createState() => _ArticleDescScreenState();
}

class _ArticleDescScreenState extends State<ArticleDescScreen> {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context))
        ? const DesktopArticleDescScreenInsidev2()
        : const MobileArticleDescSectionInsidev2();
  }
}

// Desktop Screen
class DesktopArticleDescScreenInsidev2 extends StatefulWidget {
  const DesktopArticleDescScreenInsidev2({Key? key}) : super(key: key);

  @override
  State<DesktopArticleDescScreenInsidev2> createState() =>
      _DesktopArticleDescScreenInsidev2State();
}

class _DesktopArticleDescScreenInsidev2State
    extends State<DesktopArticleDescScreenInsidev2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MoreArticlesSection(),
            SizedBoxH50(),
          ],
        ),
      ),
    );
  }
}

// Mobile Screen
class MobileArticleDescSectionInsidev2 extends StatefulWidget {
  const MobileArticleDescSectionInsidev2({Key? key}) : super(key: key);

  @override
  State<MobileArticleDescSectionInsidev2> createState() =>
      _MobileArticleDescSectionInsidev2State();
}

class _MobileArticleDescSectionInsidev2State
    extends State<MobileArticleDescSectionInsidev2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MoreArticlesSection(),
            SizedBoxH50(),
          ],
        ),
      ),
    );
  }
}

class MoreArticlesSection extends StatefulWidget {
  const MoreArticlesSection({Key? key}) : super(key: key);

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
          articles = (data['data']['data'] as List).where((article) {
            if (article['category'] == 'Articles') {
              return article['remarks'] != 'Main';
            }
            return true;
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

  Widget _buildSection(String title, String category) {
    double screenWidth = MediaQuery.of(context).size.width;

    double titleFontSize = screenWidth < 600 ? 24 : screenWidth < 1024 ? 28 : 36;
    double cardWidth = screenWidth < 600
        ? screenWidth * 0.85
        : screenWidth < 1024
        ? screenWidth / 2 - 32
        : 320;

    List<dynamic> filteredArticles = articles
        .where((article) =>
    article['is_published'] == true && article['category'] == category)
        .toList();

    if (filteredArticles.isEmpty) return const SizedBox();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 50, top: 30, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 24,
            runSpacing: 24,
            children: filteredArticles
                .map((article) => ArticleCard(
              imageUrl: article['image_path'] ?? '',
              category: article['category'] ?? '',
              title: article['title'] ?? '',
              width: cardWidth,
              article: article,
              onTap: () => _navigateToArticleDetails(article),
            ))
                .toList(),
          ),
        ],
      ),
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

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.only(left: 50),
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.left,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection('More Articles', 'Articles'),
        _buildSection('More News', 'News'),
        _buildSection('More Announcements', 'Announcements'),
        _buildSection('More Events', 'Events'),
      ],
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