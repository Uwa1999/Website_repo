import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/gradientcustomtext.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/animation.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/customCard.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/footer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../shared/utils/responsive.dart';
import 'banking_technology.dart';

class AlternativeDeliveriesSolution extends StatefulWidget {
  static const String route = '/ADS';
  final double? cardWidth;

  const AlternativeDeliveriesSolution({Key? key, this.cardWidth}) : super(key: key);

  @override
  State<AlternativeDeliveriesSolution> createState() => _AlternativeDeliveriesSolutionState();
}

class _AlternativeDeliveriesSolutionState extends State<AlternativeDeliveriesSolution>
    with TickerProviderStateMixin {
  List<dynamic> services = [];
  bool isLoading = true;
  String errorMessage = '';
  String categoryName = 'Alternative Deliveries Solution';
  int servicesCount = 0;
  String? _catalogImagePath;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    fetchCatalogData();
  }

  Future<void> fetchCatalogData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/catalogs/show/12'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final data = jsonResponse['data'];

        setState(() {
          _catalogImagePath = data['image_path'];
          services = data['services'] ?? [];
          servicesCount = services.length;
          categoryName = data['name'] ?? 'Current Products';
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double cardWidth = 250.0;
    const double cardSpacing = 20.0;
    const double maxWrapWidth = (cardWidth * 4) + (cardSpacing * 3);

    return Column(
      children: [
        // ... (Header and text widgets)
        const SizedBox(height: 30),
        Center(
          child: GradientCustomText(
              text: categoryName,
              style: TextStyle(fontSize: 50),
              gradient: linearGradient
          )
        ),
        const SizedBox(height: 10),
        Container(
          width: 500,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5),
          ),
          child: Center(
            child: Text(
              "We'd love to share these products with you.",
              style: const TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
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
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: maxWrapWidth),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: cardSpacing,
                  runSpacing: cardSpacing,
                  children: services.map((service) {
                    return SizedBox(
                      width: cardWidth,
                      child: CustomCardWidgetv1(
                        imagePath: service['image_path'] ?? '',
                        isNetworkImage: true,
                        maxWidth: cardWidth,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
      ],
    );
  }
}