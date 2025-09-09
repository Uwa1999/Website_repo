import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/animation.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/customCard.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/footer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../shared/utils/responsive.dart';

class BankingTechnology extends StatefulWidget {
  static const String route = '/bankingtechnology';
  final double? cardWidth;

  const BankingTechnology({Key? key, this.cardWidth}) : super(key: key);

  @override
  State<BankingTechnology> createState() => _BankingTechnologyState();
}

class _BankingTechnologyState extends State<BankingTechnology> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _animation;

  List<dynamic> services = [];
  bool isLoading = true;
  String errorMessage = '';
  String categoryName = 'Banking Technology';
  int servicesCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    fetchBankingTechnologyServices();
  }

  Future<void> fetchBankingTechnologyServices() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/catalogs/index'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> catalogData = jsonResponse['data']['data'];

        // Find the Banking Technology category
        final bankingTechCategory = catalogData.firstWhere(
              (category) => category['name'] == 'Banking Technology',
          orElse: () => null,
        );

        if (bankingTechCategory != null) {
          setState(() {
            services = bankingTechCategory['services'] ?? [];
            servicesCount = services.length;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            errorMessage = 'Banking Technology category not found';
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      drawer: MediaQuery.of(context).size.width < 1024 ? const SideMenu() : null,
      body: Column(
        children: [
          ResponsiveLayout(
            mobile: NavSectionMobile(scaffoldKey: _scaffoldKey),
            tablet: Container(),
            desktop: const HeaderSection(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: GradientText(
                      text: categoryName,
                      gradient: LinearGradient(colors: [Colors.black, Colors.redAccent, Colors.red]),
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Text(
                        "$servicesCount services offered",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  if (isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (errorMessage.isNotEmpty)
                    Center(child: Text('Error: $errorMessage'))
                  else if (services.isEmpty)
                      const Center(child: Text('No services available'))
                    else
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        runSpacing: 20,
                        children: services.map((service) {
                          return CustomCardWidgetv1(
                            title: service['name'] ?? 'No Title',
                            // description: service['description'] ?? 'No description available',
                            imagePath: service['image_path'] ?? '',
                            isNetworkImage: true, // Add this flag for network images
                            maxWidth: widget.cardWidth,
                          );
                        }).toList(),
                      ),

                  const SizedBox(height: 100),
                  const FooterSectionv2(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCardWidgetv1 extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isNetworkImage;
  final double? maxWidth;

  const CustomCardWidgetv1({
    required this.title,
    required this.imagePath,
    this.isNetworkImage = false,
    this.maxWidth,
    Key? key,
  }) : super(key: key);

  // Helper function to determine the image widget
  Widget _buildImageWidget({required double width, required double height}) {
    if (imagePath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.network(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.contain,
        placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
      );
    } else {
      ImageProvider<Object> imageProvider = isNetworkImage
          ? NetworkImage(imagePath) as ImageProvider<Object>
          : AssetImage(imagePath) as ImageProvider<Object>;

      return Image(
        image: imageProvider,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, size: 50);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double width = maxWidth ?? (screenWidth > 400 ? 300 : screenWidth * 0.9);
    final bool isMobile = width < 600;

    const TextStyle titleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.black,
      decoration: TextDecoration.none,
    );

    return Container(
      width: 190,
      height: 190,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: _buildImageWidget(width: 80, height: 80),
          ),
          const SizedBox(height: 10),
          Text(title, style: titleTextStyle, textAlign: TextAlign.center),
        ],
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImageWidget(width: 60, height: 60),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: titleTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}


// Card model (kept for reference, but not used anymore)
class BankingService {
  final String title;
  final String description;
  final String imagePath;

  BankingService({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}