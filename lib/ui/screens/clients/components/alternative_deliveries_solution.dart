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

    fetchAlternativeDeliveriesServices();
  }

  Future<void> fetchAlternativeDeliveriesServices() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/catalogs/index'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> catalogData = jsonResponse['data']['data'];

        final alternativeDeliveriesCategory = catalogData.firstWhere(
              (category) => category['name'] == 'Alternative Deliveries Solution',
          orElse: () => null,
        );

        if (alternativeDeliveriesCategory != null) {
          setState(() {
            services = alternativeDeliveriesCategory['services'] ?? [];
            servicesCount = services.length;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            errorMessage = 'Alternative Deliveries Solution category not found';
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
    return Column(
      children: [
        const SizedBox(height: 30),
        Center(
          child: GradientText(
            text: categoryName,
            gradient: LinearGradient(colors: [Colors.black, Colors.redAccent, Colors.red]),
            style: const TextStyle(fontSize: 50),
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
              style: const TextStyle(fontSize: 14, color: Colors.black87),
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
                  isNetworkImage: true,
                  maxWidth: widget.cardWidth,
                );
              }).toList(),
            ),
      ],
    );
  }
}
