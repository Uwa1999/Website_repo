import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../articlev2main.dart';

class ArticleDescSection extends StatefulWidget {
  const ArticleDescSection({Key? key}) : super(key: key);

  @override
  State<ArticleDescSection> createState() => _ArticleDescSectionState();
}

class _ArticleDescSectionState extends State<ArticleDescSection> {
  Map<String, dynamic>? articleData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchArticleData();
  }

  Future<void> fetchArticleData() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/insights/index'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['data']['data'] as List;

        // Find the first article with remarks "Main"
        final article = articles.firstWhere(
              (item) => item['remarks'] == 'Main',
          orElse: () => null,
        );

        if (article != null) {
          setState(() {
            articleData = article;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            errorMessage = 'No main article found';
          });
        }
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    if (articleData == null) {
      return const Center(child: Text('No article data available'));
    }

    return (!isMobile(context)) == (!isTab(context))
        ? DesktopArticleDescScreenInsidev2(articleData: articleData!)
        : MobileArticleDescScreenInsidev2(articleData: articleData!);
  }
}

class DesktopArticleDescScreenInsidev2 extends StatelessWidget {
  final Map<String, dynamic> articleData;

  const DesktopArticleDescScreenInsidev2({Key? key, required this.articleData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      child: Stack(
        children: [
          // Background image from API
          Positioned.fill(
            child: Image.network(
              articleData['image_path'] ?? '',
              fit: BoxFit.fitHeight,
              errorBuilder: (context, error, stackTrace) =>
              const Center(child: Icon(Icons.error)),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),

          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.maroon03.withOpacity(0.6),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),

          // Content
          Positioned(
              top: 500,
              left: 100,
              child: NimbusInfoInsightTitle(
                title1: articleData['title'] ?? 'No Title',
                title2: articleData['subtitle'] ?? '',
                body: articleData['content'] ?? 'No content available',
                remarks: articleData['remarks'],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ArticleDescMainv2.route,
                    arguments: {
                      'articleId': articleData['id'].toString(),
                      'articleData': articleData,
                    },
                  );
                },
              )
          ),
        ],
      ),
    );
  }
}

class MobileArticleDescScreenInsidev2 extends StatelessWidget {
  final Map<String, dynamic> articleData;

  const MobileArticleDescScreenInsidev2({Key? key, required this.articleData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            // Background image from API
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                articleData['image_path'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.error)),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),

            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.maroon03, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            // Content
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: NimbusInfoInsightTitle(
                  title1: articleData['title'] ?? 'No Title',
                  title2: articleData['subtitle'] ?? '',
                  body: articleData['content'] ?? 'No content available',
                  remarks: articleData['remarks'],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ArticleDescMainv2.route,
                      arguments: {
                        'articleId': articleData['id'].toString(),
                        'articleData': articleData,
                      },
                    );
                  },
                )
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}