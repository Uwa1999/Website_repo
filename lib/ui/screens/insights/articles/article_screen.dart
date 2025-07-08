import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleDescScreenInside extends StatefulWidget {
  final String content;

  const ArticleDescScreenInside({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  State<ArticleDescScreenInside> createState() => _ArticleDescScreenInsideState();
}

class _ArticleDescScreenInsideState extends State<ArticleDescScreenInside> {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context))
        ? DesktopArticleDescScreen(content: widget.content)
        : MobileArticleDescSection(content: widget.content);
  }
}

// Desktop Screen
class DesktopArticleDescScreen extends StatefulWidget {
  final String content;

  const DesktopArticleDescScreen({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopArticleDescScreen> createState() => _DesktopArticleDescScreenState();
}

class _DesktopArticleDescScreenState extends State<DesktopArticleDescScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBoxH30(),
            Padding(
              padding: EdgeInsets.only(
                left: Sizes.PADDING_100,
                right: Sizes.PADDING_100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Html(
                    data: widget.content,
                    style: {
                      "body": Style(
                        fontSize: FontSize(16.0),
                        lineHeight: LineHeight(1.6),
                        color: AppColors.black,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                      "p": Style(
                        margin: Margins.only(bottom: 16),
                        fontSize: FontSize(16.0),
                      ),
                      "h1": Style(
                        fontSize: FontSize(28.0),
                        fontWeight: FontWeight.w700,
                        margin: Margins.only(bottom: 24, top: 32),
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                      "h2": Style(
                        fontSize: FontSize(24.0),
                        fontWeight: FontWeight.w600,
                        margin: Margins.only(bottom: 20, top: 28),
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                      "h3": Style(
                        fontSize: FontSize(20.0),
                        fontWeight: FontWeight.w500,
                        margin: Margins.only(bottom: 16, top: 24),
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                      "strong": Style(
                        fontWeight: FontWeight.bold,
                      ),
                      "em": Style(
                        fontStyle: FontStyle.italic,
                      ),
                      "a": Style(
                        color: AppColors.maroon08,
                        textDecoration: TextDecoration.underline,
                      ),
                      "ul": Style(
                        margin: Margins.only(bottom: 16, left: 16),
                      ),
                      "ol": Style(
                        margin: Margins.only(bottom: 16, left: 16),
                      ),
                      "li": Style(
                        margin: Margins.only(bottom: 8),
                        fontSize: FontSize(16.0),
                      ),
                      "blockquote": Style(
                        padding: HtmlPaddings.symmetric(horizontal: 16),
                        border: Border(
                          left: BorderSide(
                            color: AppColors.grey50,
                            width: 4,
                          ),
                        ),
                        margin: Margins.only(bottom: 16),
                      ),
                    },
                    onLinkTap: (url, attributes, element) {
                      if (url != null) {
                        // Handle link taps (e.g., launch URL)
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBoxH50(),
          ],
        ),
      ),
    );
  }
}

// Mobile Screen
class MobileArticleDescSection extends StatefulWidget {
  final String content;

  const MobileArticleDescSection({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  State<MobileArticleDescSection> createState() => _MobileArticleDescSectionState();
}

class _MobileArticleDescSectionState extends State<MobileArticleDescSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBoxH30(),
          Padding(
            padding: EdgeInsets.only(
              left: Sizes.PADDING_40,
              right: Sizes.PADDING_40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Html(
                  data: widget.content,
                  style: {
                    "body": Style(
                      fontSize: FontSize(14.0),
                      lineHeight: LineHeight(1.6),
                      color: AppColors.black,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                    ),
                    "p": Style(
                      margin: Margins.only(bottom: 12),
                      fontSize: FontSize(14.0),
                    ),
                    "h1": Style(
                      fontSize: FontSize(24.0),
                      fontWeight: FontWeight.w700,
                      margin: Margins.only(bottom: 20, top: 28),
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                    "h2": Style(
                      fontSize: FontSize(20.0),
                      fontWeight: FontWeight.w600,
                      margin: Margins.only(bottom: 16, top: 24),
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                    "h3": Style(
                      fontSize: FontSize(18.0),
                      fontWeight: FontWeight.w500,
                      margin: Margins.only(bottom: 14, top: 20),
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                    "strong": Style(
                      fontWeight: FontWeight.bold,
                    ),
                    "em": Style(
                      fontStyle: FontStyle.italic,
                    ),
                    "a": Style(
                      color: AppColors.maroon08,
                      textDecoration: TextDecoration.underline,
                    ),
                    "ul": Style(
                      margin: Margins.only(bottom: 12, left: 12),
                    ),
                    "ol": Style(
                      margin: Margins.only(bottom: 12, left: 12),
                    ),
                    "li": Style(
                      margin: Margins.only(bottom: 6),
                      fontSize: FontSize(14.0),
                    ),
                    "blockquote": Style(
                      padding: HtmlPaddings.symmetric(horizontal: 12),
                      border: Border(
                        left: BorderSide(
                          color: AppColors.grey50,
                          width: 3,
                        ),
                      ),
                      margin: Margins.only(bottom: 12),
                    ),
                  },
                  onLinkTap: (url, attributes, element) {
                    if (url != null) {
                      // Handle link taps (e.g., launch URL)
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBoxH50(),
        ],
      ),
    );
  }
}