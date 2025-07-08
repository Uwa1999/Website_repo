import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleDescSectionInside extends StatefulWidget {
  static const String route = '/Article Inside';
  final String title;
  final String imageUrl;
  final String remarks;
  final String date;

  const ArticleDescSectionInside({
    required this.title,
    required this.imageUrl,
    required this.remarks,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  State<ArticleDescSectionInside> createState() => _ArticleDescSectionInsideState();
}

class _ArticleDescSectionInsideState extends State<ArticleDescSectionInside> {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context))
        ? DesktopArticleDescScreen(
      title: widget.title,
      imageUrl: widget.imageUrl,
      category: widget.remarks,
      date: widget.date,
    )
        : MobileArticleDescScreen(
      title: widget.title,
      imageUrl: widget.imageUrl,
      category: widget.remarks,
      date: widget.date,
    );
  }
}

class DesktopArticleDescScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String category;
  final String date;

  const DesktopArticleDescScreen({
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopArticleDescScreen> createState() => _DesktopArticleDescScreenState();
}

class _DesktopArticleDescScreenState extends State<DesktopArticleDescScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isFabVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      if (currentScroll >= maxScroll - 50) {
        if (!isFabVisible) {
          setState(() => isFabVisible = true);
        }
      } else {
        if (isFabVisible) {
          setState(() => isFabVisible = false);
        }
      }
    });
  }

  void scrollToTop() {
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    // Parse the date string to a more readable format
    DateTime parsedDate = DateTime.parse(widget.date);
    String formattedDate = '${parsedDate.day} ${_getMonthName(parsedDate.month)} ${parsedDate.year}';

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.category,
                  style: textTheme.labelSmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: 900,
                padding: const EdgeInsets.only(top: 20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double fontSize = constraints.maxWidth * 0.045;
                    return Text(
                      widget.title,
                      style: GoogleFonts.inter(
                        fontSize: fontSize.clamp(24, 48),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Published on $formattedDate',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(widget.imageUrl),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
        if (isFabVisible)
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton(
              backgroundColor: AppColors.maroon08,
              onPressed: scrollToTop,
              child: const Icon(Icons.expand_less, color: Colors.white),
            ),
          ),
      ],
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return monthNames[month - 1];
  }
}

class MobileArticleDescScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String category;
  final String date;

  const MobileArticleDescScreen({
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  State<MobileArticleDescScreen> createState() => _MobileArticleDescScreenState();
}

class _MobileArticleDescScreenState extends State<MobileArticleDescScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isFabVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      if (currentScroll >= maxScroll - 50) {
        if (!isFabVisible) {
          setState(() => isFabVisible = true);
        }
      } else {
        if (isFabVisible) {
          setState(() => isFabVisible = false);
        }
      }
    });
  }

  void scrollToTop() {
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    // Parse the date string to a more readable format
    DateTime parsedDate = DateTime.parse(widget.date);
    String formattedDate = '${parsedDate.day} ${_getMonthName(parsedDate.month)} ${parsedDate.year}';

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.category,
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double fontSize = constraints.maxWidth * 0.07;
                        return Text(
                          widget.title,
                          style: GoogleFonts.inter(
                            fontSize: fontSize.clamp(20, 32),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Published on $formattedDate',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
        if (isFabVisible)
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton(
              backgroundColor: AppColors.maroon08,
              onPressed: scrollToTop,
              child: const Icon(Icons.expand_less, color: Colors.white),
            ),
          ),
      ],
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return monthNames[month - 1];
  }
}