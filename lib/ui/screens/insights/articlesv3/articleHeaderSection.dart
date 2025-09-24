import 'dart:convert';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv3/viewMainArticle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../core/provider/article_provider.dart';
import '../../shared/values/colors.dart';
import '../../shared/widgets/nimbus_info_section.dart';

class ArticleHeaderSection extends StatefulWidget {
  static const String route = '/MainArticle';
  const ArticleHeaderSection({super.key});

  @override
  State<ArticleHeaderSection> createState() => _ArticleHeaderSectionState();
}

class _ArticleHeaderSectionState extends State<ArticleHeaderSection> {
  Map<String, dynamic> articleData = {};
  String? headerImage;
  bool isLoading = true;

  @override
  void initState() {
    fetchInsightImg();
    super.initState();
  }

  Future<void> fetchInsightImg() async {
    try {
      final response = await http.get(
          Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/insights/index'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8'
          });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> imgData = jsonResponse['data']['data'];
        final headerImg = imgData.firstWhere(
                (image) => image['title'] == 'Article',
            orElse: () => null);

        if (headerImg != null) {
          final imageUrl = headerImg['image_path'];
          if (mounted) {
            setState(() {
              articleData = {
                'title': headerImg['title'],
                'content': headerImg['content'],
                'remarks': headerImg['remarks'],
                'publishedAt': headerImg['published_at'],
                'id': headerImg['id'],
                'imagePath': headerImg['image_path']
              };
              headerImage = imageUrl;
              isLoading = false;
            });
            precacheImage(CachedNetworkImageProvider(imageUrl), context);
          }
        } else {
          print('Image with name "article" not found.');
          if (mounted) setState(() => isLoading = false);
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

  bool _isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 800;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = _isDesktop(context);

    final double headerHeight = isDesktop ? MediaQuery.of(context).size.height * 0.9 : 250;

    return SizedBox(
      height: headerHeight,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              headerImage ?? '',
              fit: isDesktop ? BoxFit.fitHeight : BoxFit.fitWidth,
              alignment: Alignment.center,
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
          Positioned(
            bottom: isDesktop ? 100 : 50,
            left: isDesktop ? 100 : 20,
            right: isDesktop ? null : 20,
            child: NimbusInfoInsightTitle(
              title1: articleData['title'] ?? 'No Title',
              title2: articleData['subtitle'] ?? '',
              body: articleData['content'] ?? 'No content available',
              remarks: articleData['remarks'],
              onTap: () {
                final provider = Provider.of<ArticleProvider>(context, listen: false);
                provider.setArticleData(articleData);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainArticle(
                      id: articleData['id'].toString(),
                      imgPath: articleData['imagePath'],
                      publishedAt: articleData['publishedAt'],
                      articleData: articleData,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}