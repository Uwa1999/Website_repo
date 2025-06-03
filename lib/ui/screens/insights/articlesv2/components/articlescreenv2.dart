import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 🆕 More Articles Section
          MoreArticlesSection(),

          SizedBoxH50(),
        ],
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🆕 More Articles Section
          MoreArticlesSection(),

          SizedBoxH50(),
        ],
      ),
    );
  }
}


class MoreArticlesSection extends StatelessWidget {
  const MoreArticlesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double titleFontSize = screenWidth < 600
        ? 24
        : screenWidth < 1024
        ? 28
        : 36;

    double cardWidth = screenWidth < 600
        ? screenWidth * 0.9
        : screenWidth < 1024
        ? screenWidth / 2 - 32
        : 320;

    return Padding(
      padding: const EdgeInsets.only(left: 50, top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const SizedBox(height: 24),
          Text(
            'More Articles',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Articles Wrap
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              ArticleCard(
                imageUrl: 'assets/images/insight_news_card_cover.png',
                category: 'News',
                title: 'Success Journey through Digitalization',
                width: cardWidth,
              ),
              ArticleCard(
                imageUrl: 'assets/images/insight_news_card_cover.png',
                category: 'News',
                title: 'Bid Dawg in the Game!',
                width: cardWidth,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String title;
  final double width;

  const ArticleCard({
    Key? key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),

              // Category label
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

              // Title
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
    );
  }
}

