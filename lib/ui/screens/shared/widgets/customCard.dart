import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final String? title;
  final String description;
  final String imagePath;
  final bool isNetworkImage; // Add this flag
  final List<String>? buttonLabels;
  final VoidCallback? onMainActionPressed;
  final List<VoidCallback>? onButtonPressed;
  final double? maxWidth;

  const CustomCardWidget({
    Key? key,
    this.title,
    this.maxWidth,
    required this.description,
    required this.imagePath,
    this.isNetworkImage = false, // Default to false for backward compatibility
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

        // Create image provider based on the source type
        ImageProvider imageProvider;
        if (isNetworkImage) {
          imageProvider = NetworkImage(imagePath);
        } else {
          imageProvider = AssetImage(imagePath);
        }

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
                      image: imageProvider,
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
                      image: imageProvider,
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
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text(''),
              ),
              Text(
                title!,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  buttonLabels![index],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }),
          )
      ],
    );
  }
}

class CustomCardWidgetv2 extends StatelessWidget {
  final String? title;
  final String description;
  final String imagePath;
  final bool isNetworkImage; // Add this flag
  final List<String>? buttonLabels;
  final VoidCallback? onMainActionPressed;
  final List<VoidCallback>? onButtonPressed;
  final double? maxWidth;

  const CustomCardWidgetv2({
    Key? key,
    this.title,
    this.maxWidth,
    required this.description,
    required this.imagePath,
    this.isNetworkImage = false, // Default to false for backward compatibility
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
        double imageWidth = isWide ? 450 : constraints.maxWidth * 0.9;
        double imageHeight = isWide ? 300 : 200;

        // Create image provider based on the source type
        ImageProvider imageProvider;
        if (isNetworkImage) {
          imageProvider = NetworkImage(imagePath);
        } else {
          imageProvider = AssetImage(imagePath);
        }

        Widget cardContent = Card(
          surfaceTintColor: Colors.white,
          shadowColor: Colors.grey,
          margin: const EdgeInsets.all(10),
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Wrap(
              alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 40,
              runSpacing: 20,
              children: [
                Container(
                  width: imageWidth,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    color: const Color(0xfff3f4f7),
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 200,
                    maxWidth: isWide ? MediaQuery
                        .of(context)
                        .size
                        .width * 0.6 : double.infinity,
                  ),
                  child: _buildTextSection(titleFontSize, descFontSize),
                ),
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
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  buttonLabels![index],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }),
          )
      ],
    );
  }
}