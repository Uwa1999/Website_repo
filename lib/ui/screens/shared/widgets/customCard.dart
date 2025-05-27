import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final String? title;
  final String description;
  final String imagePath;
  final List<String>? buttonLabels;
  final VoidCallback? onMainActionPressed;
  final List<VoidCallback>? onButtonPressed;

  const CustomCardWidget({
    Key? key,
    this.title,
    required this.description,
    required this.imagePath,
    this.buttonLabels,
    this.onMainActionPressed,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 600;

        double titleFontSize = isWide ? 30 : 20;
        double descFontSize = isWide ? 15 : 14;
        double imageWidth = isWide ? 400 : constraints.maxWidth * 0.9;
        double imageHeight = isWide ? 300 : 200;

        Widget cardContent = Card(
          color: Colors.white,
          margin: const EdgeInsets.all(10),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: isWide
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: imageWidth,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(child: _buildTextSection(titleFontSize, descFontSize)),
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: imageWidth,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextSection(titleFontSize, descFontSize),
              ],
            ),
          ),
        );

        return onMainActionPressed != null
            ? GestureDetector(
          onTap: onMainActionPressed,
          child: cardContent,
        )
            : cardContent;
      },
    );
  }

  Widget _buildTextSection(double titleFontSize, double descFontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(fontSize: descFontSize),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
        if (buttonLabels != null && buttonLabels!.isNotEmpty)
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(buttonLabels!.length, (index) {
              return ElevatedButton(
                onPressed: onButtonPressed != null && index < onButtonPressed!.length
                    ? onButtonPressed![index]
                    : () {},
                child: Text(buttonLabels![index]),
              );
            }),
          ),
      ],
    );
  }
}


class CustomCardWidgetv2 extends StatelessWidget {
  final String? title;
  final String description;
  final String imagePath;
  final List<String>? buttonLabels;
  final VoidCallback? onMainActionPressed;
  final List<VoidCallback>? onButtonPressed;

  const CustomCardWidgetv2({
    Key? key,
    this.title,
    required this.description,
    required this.imagePath,
    this.buttonLabels,
    this.onMainActionPressed,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Determine layout sizes
    double cardWidth = screenWidth >= 1024
        ? 700
        : screenWidth >= 600
        ? screenWidth * 0.9
        : screenWidth * 0.95;

    double imageSize = screenWidth >= 1024
        ? 100
        : screenWidth >= 600
        ? 80
        : 60;

    double textWidth = screenWidth >= 1024
        ? 300
        : screenWidth >= 600
        ? 250
        : double.infinity;

    double titleFontSize = screenWidth >= 1024
        ? 30
        : screenWidth >= 600
        ? 24
        : 20;

    double descriptionFontSize = screenWidth >= 600 ? 15 : 14;

    Widget cardContent = Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(20),
        child: screenWidth >= 600
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 30),
            // Content
            Expanded(
              child: _buildTextSection(titleFontSize, descriptionFontSize),
            ),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextSection(titleFontSize, descriptionFontSize),
          ],
        ),
      ),
    );

    return onMainActionPressed != null
        ? GestureDetector(
      onTap: onMainActionPressed,
      child: cardContent,
    )
        : cardContent;
  }

  Widget _buildTextSection(double titleFontSize, double descFontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 700, // You can adjust this as needed
          ),
          child: Text(
            description,
            style: TextStyle(fontSize: descFontSize),
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 20),
        if (buttonLabels != null && buttonLabels!.isNotEmpty)
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(buttonLabels!.length, (index) {
              return ElevatedButton(
                onPressed: onButtonPressed != null && index < onButtonPressed!.length
                    ? onButtonPressed![index]
                    : () {},
                child: Text(buttonLabels![index]),
              );
            }),
          ),
      ],
    );
  }
}

