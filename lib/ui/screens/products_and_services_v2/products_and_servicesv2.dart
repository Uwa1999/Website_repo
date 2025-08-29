import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../shared/utils/responsive.dart';
import '../shared/widgets/customCard.dart';

class ProductsAndServicesV2 extends StatefulWidget {
  static const String route = '/PAS';
  const ProductsAndServicesV2({Key? key}) : super(key: key);

  @override
  State<ProductsAndServicesV2> createState() => _ProductsAndServicesV2State();
}

class _ProductsAndServicesV2State extends State<ProductsAndServicesV2> {
  List<dynamic>? catalogData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCatalogData();
  }

  Future<void> fetchCatalogData() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/catalogs/index'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          catalogData = jsonResponse['data']['data'];
          isLoading = false;
        });
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    // Adjust image width
    final imageWidth = isMobile ? 800.0 : screenWidth * 0.8;

    // Image aspect ratio (adjust based on your image)
    final imageAspectRatio = 3 / 1; // Example: 3 width : 1 height
    final imageHeight = imageWidth / imageAspectRatio;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text('Error: $errorMessage'));
    }

    if (catalogData == null || catalogData!.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ResponsiveLayout(
          mobile: _buildMobileLayout(),
          tablet: _buildTabletLayout(),
          desktop: _buildDesktopLayout(),
        ),
        Positioned(
          top: -imageHeight * 1.25,
          left: (MediaQuery.of(context).size.width - imageWidth) / 2,
          child: Center(
            child: Image.asset(
              'assets/images/phone-web.png',
              width: imageWidth,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(textSize: 70, paddingLeft: 100),
        _buildCardsLayout(width: 1500),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(textSize: 50, paddingLeft: 40),
          _buildCardsLayout(width: 800),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(textSize: 30, paddingLeft: 20),
          _buildCardsLayout(width: double.infinity, isMobile: true),
        ],
      ),
    );
  }

  Widget _buildHeader({required double textSize, required double paddingLeft}) {
    return Container(
      color: const Color(0xffFAFAFA),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(left: paddingLeft, bottom: 50, top: 100),
        child: Text(
          'Our Products and Services',
          style: TextStyle(fontSize: 46, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildCardsLayout({required double width, bool isMobile = false}) {
    return Container(
      color: const Color(0xffFAFAFA),
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: catalogData!.map((catalogItem) {
          // Extract button labels from services
          List<String> buttonLabels = [];
          if (catalogItem['services'] != null) {
            buttonLabels = List<String>.from(
                catalogItem['services'].map((service) => service['name'] as String)
            );
          }

          // Determine the appropriate route based on the catalog name
          String routeName = '/bankingtechnology'; // default
          if (catalogItem['name'] == 'Alternative Deliveries Solution') {
            routeName = '/ADS';
          } else if (catalogItem['name'] == 'Regulatory and Services') {
            routeName = '/MfisPage';
          }

          return Column(
            children: [
              SizedBox(
                width: width,
                child: CustomCardWidget(
                  title: catalogItem['name'] ?? 'No Title',
                  description: catalogItem['description'] ?? 'No description available',
                  buttonLabels: buttonLabels,
                  imagePath: catalogItem['image_path'] ?? '',
                  isNetworkImage: true, // Add this flag
                  onMainActionPressed: () => Navigator.pushNamed(context, routeName),
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        }).toList(),
      ),
    );
  }
}