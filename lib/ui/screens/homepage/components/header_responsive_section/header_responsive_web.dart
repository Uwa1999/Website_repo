import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/widgets.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../shared/widgets/gradientcustomtext.dart';

class HeaderResponsiveWeb extends StatefulWidget {
  const HeaderResponsiveWeb({Key? key}) : super(key: key);

  @override
  _HeaderResponsiveWebState createState() => _HeaderResponsiveWebState();
}

class _HeaderResponsiveWebState extends State<HeaderResponsiveWeb> {
  String? _glassPhoneImageUrl;
  bool _isLoadingImage = true;

  @override
  void initState() {
    super.initState();
    _fetchImagesAndPrecache();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchImagesAndPrecache() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/images/index'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> imageData = jsonResponse['data'];
        final glassPhoneImage = imageData.firstWhere(
              (image) => image['name'] == 'glass-phone',
          orElse: () => null,
        );

        if (glassPhoneImage != null) {
          final imageUrl = glassPhoneImage['image_path'];
          if (mounted) {
            setState(() {
              _glassPhoneImageUrl = imageUrl;
              _isLoadingImage = false;
            });
            precacheImage(CachedNetworkImageProvider(imageUrl), context);
          }
        } else {
          print('Image with name "glass-phone" not found.');
          if (mounted) setState(() => _isLoadingImage = false);
        }
      } else {
        print('Failed to load images: ${response.statusCode}');
        if (mounted) setState(() => _isLoadingImage = false);
      }
    } catch (e) {
      print('Error fetching images: $e');
      if (mounted) setState(() => _isLoadingImage = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentArea(
      child: SingleChildScrollView(
        child: ResponsiveBuilder(
          builder: (context, sizingInfo) {
            final isMobile = sizingInfo.screenSize.width < 800;
            return isMobile ? _buildMobileHeader() : _buildDesktopHeader();
          },
        ),
      ),
    );
  }

  Widget _buildDesktopHeader() {
    return Column(
      children: [
        SizedBox(height: 8),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;
                  double dynamicFontSize = (screenWidth * 0.04).clamp(10.0, 60.0);
                  return GradientCustomText(
                    text: 'Trusted partner on your',
                    style: TextStyle(
                      fontSize: dynamicFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    gradient: linearGradient,
                  );
                },
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;
                  double dynamicFontSize = (screenWidth * 0.04).clamp(10.0, 60.0);
                  return GradientCustomText(
                    text: 'Digitalization Journey.',
                    style: TextStyle(
                      fontSize: dynamicFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    gradient: linearGradient,
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        if (_isLoadingImage)
          Center(child: CircularProgressIndicator())
        else if (_glassPhoneImageUrl != null)
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: _glassPhoneImageUrl!,
                      width: 1100,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      left: constraints.maxWidth * 0.08,
                      child: SizedBox(
                        width: 300,
                        child: textBox(
                          'Providing world class core banking\nsoftware in the regional economy\nand community with short',
                          TextAlign.justify,
                        ),
                      ),
                    ),
                    Positioned(
                      right: constraints.maxWidth * 0.08,
                      child: SizedBox(
                        width: 300,
                        child: textBox(
                          'Implementation time, tailor-made\nservices, and redefining the\nholistic customer experiences.',
                          TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildMobileHeader() {
    return Column(
      children: [
        // Text and spacing
        SizedBox(height: 60),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;
                  double dynamicFontSize = (screenWidth * 0.04).clamp(10.0, 60.0);
                  return GradientCustomText(
                    text: 'Trusted partner on your',
                    style: TextStyle(
                      fontSize: dynamicFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    gradient: linearGradient,
                  );
                },
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;
                  double dynamicFontSize = (screenWidth * 0.04).clamp(10.0, 60.0);
                  return GradientCustomText(
                    text: 'Digitalization Journey.',
                    style: TextStyle(
                      fontSize: dynamicFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    gradient: linearGradient,
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Providing world class core banking software in the regional economy and community with short implementation time, tailor-made services, and redefining the holistic customer experiences.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 20),
        if (_isLoadingImage)
          Center(child: CircularProgressIndicator())
        else if (_glassPhoneImageUrl != null)
          SizedBox(
            height: 500,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: -200,
                  right: -200,
                  top: 0,
                  child: CachedNetworkImage(
                    imageUrl: _glassPhoneImageUrl!,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget textBox(String text, TextAlign textAlign) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Text(
        text,
        textAlign: textAlign,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}


//   Widget buildTabletHeader() {
//     return Column(
//       children: [
//         const SizedBox(height: 60),
//         Image.asset('assets/images/main-text-landing-page.png', width: 600),
//         const SizedBox(height: 30),
//         Image.asset('assets/images/phone-web.png', width: 600),
//         const Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Text(
//             'Banking software solutions for the regional economy and community.',
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     );
//   }
//
// }

// You can put these in separate files or in the same file.
