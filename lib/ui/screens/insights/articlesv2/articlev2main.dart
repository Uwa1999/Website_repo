import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';

import '../../../../core/provider/article_provider.dart';
import '../../shared/widgets/buttons/footer.dart';
import '../articles/article_main.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadArticleData();
    });
  }

  Future<void> _loadArticleData() async {
    setState(() => isLoading = true);

    final provider = context.read<ArticleProvider>();

    // Priority 1: Use initial data if provided
    if (widget.initialArticleData != null) {
      await provider.setArticleData(widget.initialArticleData!);
      _initializeWithData(widget.initialArticleData!);
      return;
    }

    // Priority 2: Try to fetch by articleId if provided
    if (widget.articleId.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/insights/show/${widget.articleId}'),
        );

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          await provider.setArticleData(jsonResponse['data']);
          _initializeWithData(jsonResponse['data']);
          return;
        }
      } catch (e) {
        print('Error fetching article: $e');
      }
    }

    // Priority 3: Use provider data if available
    if (provider.articleData != null) {
      _initializeWithData(provider.articleData!);
      return;
    }

    // Priority 4: Fallback to fetching main article
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/insights/index'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['data']['data'] as List;
        final article = articles.firstWhere(
              (item) => item['remarks'] == 'Main',
          orElse: () => null,
        );

        if (article != null) {
          await provider.setArticleData(article);
          _initializeWithData(article);
          return;
        }
      }
    } catch (e) {
      print('Error fetching fallback article: $e');
    }

    // If all else fails
    setState(() {
      isLoading = false;
      errorMessage = 'No article data available';
    });
  }

  void _initializeWithData(Map<String, dynamic> data) {
    setState(() {
      articleData = data;
      isLoading = false;
    });
    _incrementClickCount();
  }


  Future<void> _incrementClickCount() async {
    final id = widget.articleId.isNotEmpty
        ? widget.articleId
        : articleData?['id']?.toString() ?? '';

    if (id.isEmpty) return;
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

  String formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMMM dd, yyyy').format(date);
    } catch (e) {
      return dateString; // Return original if parsing fails
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.maroon08),
          onPressed: () {
            Future.delayed(const Duration(milliseconds: 700), () {
              Navigator.pushNamed(
                context,
                ArticleDescMain.route, // Using the named route
              );
            });
          },
        ),
        automaticallyImplyLeading: true, // This shows the back button
      ),
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
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : errorMessage != null
                  ? Center(child: Text(errorMessage!))
                  : Column(
                children: [
                  // Display click count
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
                    date: formatDate(articleData?['published_at'] ?? ''),
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
