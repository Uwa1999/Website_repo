import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:responsive_builder/responsive_builder.dart';

import '../../shared/widgets/buttons/footer.dart';
import '../articles/article_screen.dart';
import '../articles/article_section.dart';
import '../more_articles_section.dart';

class ArticleDescMainv2 extends StatefulWidget {
  static const String route = '/Article1';
  final String articleId;
  final Map<String, dynamic>? initialArticleData;

  const ArticleDescMainv2({
    Key? key,
    required this.articleId,
    this.initialArticleData,
  }) : super(key: key);

  @override
  State<ArticleDescMainv2> createState() => _ArticleDescMainv2State();
}

class _ArticleDescMainv2State extends State<ArticleDescMainv2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool isFabVisible = false;
  bool isLoading = true;
  Map<String, dynamic>? articleData;
  String? errorMessage;
  int clickCount = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    if (widget.initialArticleData != null) {
      articleData = widget.initialArticleData;
      isLoading = false;
    } else {
      _fetchArticleData();
    }
    // Trigger click count API when the page loads
    _incrementClickCount();
  }

  Future<void> _incrementClickCount() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/insights/show/${widget.articleId}'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          clickCount = jsonResponse['data']['click_count'] ?? 0;
        });
      } else {
        print('Failed to increment click count: ${response.statusCode}');
      }
    } catch (e) {
      print('Error incrementing click count: $e');
    }
  }

  Future<void> _fetchArticleData() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/insights/index'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final articles = jsonResponse['data']['data'] as List;

        var foundArticle = articles.firstWhere(
              (article) => article['id'].toString() == widget.articleId,
          orElse: () => null,
        );

        if (foundArticle != null) {
          setState(() {
            articleData = foundArticle;
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = "Article not found";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = "Failed to load data: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching data: $e";
        isLoading = false;
      });
    }
  }

  void _scrollListener() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll - 100) {
      if (!isFabVisible) setState(() => isFabVisible = true);
    } else {
      if (isFabVisible) setState(() => isFabVisible = false);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  String _getMoreSectionTitle(String category) {
    switch (category) {
      case 'Articles':
        return 'More Articles';
      case 'News':
        return 'More News';
      case 'Announcements':
        return 'More Announcements';
      case 'Events':
        return 'More Events';
      default:
        return 'More Content';
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      key: _scaffoldKey,
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          backgroundColor: AppColors.maroon08,
          child: Icon(
            Icons.expand_less,
            size: Sizes.ICON_SIZE_18,
            color: AppColors.white,
          ),
          onPressed: _scrollToTop,
        ),
      ),
      drawer: ResponsiveBuilder(
        refinedBreakpoints: RefinedBreakpoints(),
        builder: (context, sizingInformation) {
          double screenWidth = sizingInformation.screenSize.width;
          return screenWidth < RefinedBreakpoints().desktopSmall
              ? SideMenu()
              : const SizedBox();
        },
      ),
      body: Column(
        children: [
          ResponsiveBuilder(
            refinedBreakpoints: RefinedBreakpoints(),
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;
              return Column(
                children: [
                  if (screenWidth < RefinedBreakpoints().desktopSmall)
                    NavSectionMobile(scaffoldKey: _scaffoldKey)
                  else
                    HeaderSection(),
                  // Back button positioned below the header/navigation
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back,
                            color: AppColors.black,
                            size: Sizes.ICON_SIZE_30),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : errorMessage != null
                  ? Center(child: Text(errorMessage!))
                  : Column(
                children: [
                  // Display click count (optional - you can remove this if you don't want to show it)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Views: $clickCount',
                      style: TextStyle(
                        color: AppColors.grey50,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  ArticleDescSectionInside(
                    title: articleData?['title'] ?? 'No Title',
                    imageUrl: articleData?['image_path'] ?? '',
                    remarks: articleData?['remarks'] ?? '',
                    date: articleData?['published_at'] ?? '',
                  ),
                  ArticleDescScreenInside(
                    content: articleData?['content'] ?? 'No Content',
                  ),
                  if (articleData != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getMoreSectionTitle(
                                articleData!['category']),
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          MoreArticlesSection(
                            currentArticleId: widget.articleId,
                            categoryFilter: articleData!['category'],
                          ),
                        ],
                      ),
                    ),
                  SizedBoxH10(),
                  FooterSectionv2(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}