import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'animation.dart';// Make sure this path is correct


// class LeadingBankingPartnerData {
//   final int? value;
//   final String subtitle;
//   final String? values;
//
//   LeadingBankingPartnerData({
//     this.value,
//     required this.subtitle,
//     this.values,
//   });
// }
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LeadingBankingPartnerItem extends StatelessWidget {
//   final int title;
//   final String subtitle;
//   final String? subnum;
//   final Color titleColor;
//   final Color subtitleColor;
//   final TextStyle? titleStyle;
//   final TextStyle? subtitleStyle;
//   final AnimationController controller;
//   final Curve curve;
//
//   LeadingBankingPartnerItem({
//     required this.title,
//     required this.subtitle,
//     required this.controller,
//     this.titleColor = Colors.white,
//     this.subtitleColor = Colors.grey,
//     this.titleStyle,
//     this.subtitleStyle,
//     this.subnum,
//     this.curve = Curves.easeIn,
//   });
//
//   late Animation<int> animation = IntTween(begin: 0, end: title).animate(
//     CurvedAnimation(
//       parent: controller,
//       curve: curve,
//     ),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, child) {
//         return _buildChild(context: context, value: animation.value, values: subnum);
//       },
//     );
//   }
//
//   Widget _buildChild({required BuildContext context, required int value, String? values}) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "$value",
//               style: GoogleFonts.poppins(
//                 color: titleColor,
//                 fontSize: 100,
//               ),
//             ),
//             Text(
//               "${values ?? ''}",
//               style: GoogleFonts.poppins(
//                 color: titleColor,
//                 fontSize: 100,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 12),
//         Text(
//           subtitle,
//           style: GoogleFonts.poppins(
//             color: subtitleColor,
//             fontSize: 25,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
 // Make sure you import it correctly
///v2
// class LeadingBankingPartnerItem extends StatelessWidget {
//   final int title;
//   final String subtitle;
//   final String? subnum;
//   final Color titleColor;
//   final Color subtitleColor;
//   final TextStyle? titleStyle;
//   final TextStyle? subtitleStyle;
//   final AnimationController controller;
//   final Curve curve;
//
//   LeadingBankingPartnerItem({
//     required this.title,
//     required this.subtitle,
//     required this.controller,
//     this.titleColor = Colors.white,
//     this.subtitleColor = Colors.grey,
//     this.titleStyle,
//     this.subtitleStyle,
//     this.subnum,
//     this.curve = Curves.easeIn,
//   });
//
//   late final Animation<int> animation = IntTween(begin: 0, end: title).animate(
//     CurvedAnimation(
//       parent: controller,
//       curve: curve,
//     ),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, child) {
//         return _buildChild(context: context, value: animation.value, values: subnum);
//       },
//     );
//   }
//
//   Widget _buildChild({required BuildContext context, required int value, String? values}) {
//     return Column(
//       children: [
//         // ✅ Animated gradient applied here
//         AnimatedGradientText(
//           animation: controller,
//           text: "$value${values ?? ''}",
//           fontSize: 100,
//         ),
//         const SizedBox(height: 12),
//         Text(
//           subtitle,
//           style: subtitleStyle ??
//               GoogleFonts.poppins(
//                 color: subtitleColor,
//                 fontSize: 25,
//               ),
//         ),
//       ],
//     );
//   }
// }
///v3
// class LeadingBankingPartnerItem extends StatefulWidget {
//   final int title;
//   final String subtitle;
//   final String? subnum;
//   final Color titleColor;
//   final Color subtitleColor;
//   final TextStyle? titleStyle;
//   final TextStyle? subtitleStyle;
//   final AnimationController controller;
//   final Curve curve;
//
//   const LeadingBankingPartnerItem({
//     Key? key,
//     required this.title,
//     required this.subtitle,
//     required this.controller,
//     this.titleColor = Colors.white,
//     this.subtitleColor = Colors.grey,
//     this.titleStyle,
//     this.subtitleStyle,
//     this.subnum,
//     this.curve = Curves.easeIn,
//   }) : super(key: key);
//
//   @override
//   State<LeadingBankingPartnerItem> createState() => _LeadingBankingPartnerItemState();
// }
//
// class _LeadingBankingPartnerItemState extends State<LeadingBankingPartnerItem> {
//   late Animation<int> numberAnimation;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     numberAnimation = IntTween(begin: 0, end: widget.title).animate(
//       CurvedAnimation(
//         parent: widget.controller,
//         curve: widget.curve,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: numberAnimation,
//       builder: (context, child) {
//         return Column(
//           children: [
//             // ✅ Gradient animation on animated number+symbol
//             AnimatedGradientText(
//               animation: widget.controller,
//               text: "${numberAnimation.value}${widget.subnum ?? ''}",
//               fontSize: 100,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               widget.subtitle,
//               style: widget.subtitleStyle ??
//                   GoogleFonts.poppins(
//                     color: widget.subtitleColor,
//                     fontSize: 25,
//                   ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
///v4
class LeadingBankingPartnerItem extends StatefulWidget {
  final int title;
  final String subtitle;
  final String? subnum;
  final Color titleColor;
  final Color subtitleColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final AnimationController controller; // for counting
  final Curve curve;

  const LeadingBankingPartnerItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.controller,
    this.titleColor = Colors.white,
    this.subtitleColor = Colors.grey,
    this.titleStyle,
    this.subtitleStyle,
    this.subnum,
    this.curve = Curves.easeIn,
  }) : super(key: key);

  @override
  State<LeadingBankingPartnerItem> createState() => _LeadingBankingPartnerItemState();
}

class _LeadingBankingPartnerItemState extends State<LeadingBankingPartnerItem> with SingleTickerProviderStateMixin {
  late Animation<int> numberAnimation;
  // Removed: late AnimationController gradientController; // No longer needed for static gradient

  @override
  void initState() {
    super.initState();

    numberAnimation = IntTween(begin: 0, end: widget.title).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    // Removed: gradientController = AnimationController(...); // No longer needed
  }

  @override
  void dispose() {
    // Removed: gradientController.dispose(); // No longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Scale up font size aggressively
    double bigFontSize;
    double subtitleFontSize;

    if (screenWidth >= 1400) {
      bigFontSize = 160;
      subtitleFontSize = 36;
    } else if (screenWidth >= 1024) {
      bigFontSize = 140;
      subtitleFontSize = 32;
    } else if (screenWidth >= 768) {
      bigFontSize = 120;
      subtitleFontSize = 28;
    } else {
      bigFontSize = 100;
      subtitleFontSize = 24;
    }

    return AnimatedBuilder(
      animation: numberAnimation,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                // Define your static gradient colors here.
                // You can customize these colors as per your design.
                return LinearGradient(
                  colors: [
                    Colors.red, // Start color of your static gradient
                    Colors.black,   // End color of your static gradient
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Text(
                "${numberAnimation.value}${widget.subnum ?? ''}",
                style: widget.titleStyle ??
                    GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      // The color here will be masked by the shader.
                      // Often set to white for best gradient application.
                      color: Colors.white,
                      fontSize: bigFontSize,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.subtitle,
              style: widget.subtitleStyle ??
                  GoogleFonts.poppins(
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.w500,
                    color: widget.subtitleColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}


class MobileLeadingBankingPartnerItem extends StatelessWidget {
  MobileLeadingBankingPartnerItem({
    required this.title,
    required this.subtitle,
    required this.controller,
    this.titleColor = AppColors.white,
    this.subtitleColor = AppColors.grey150,
    this.titleStyle,
    this.subtitleStyle,
    this.subnum,
    this.curve = Curves.easeIn,
  });

  final int title;
  final String subtitle;
  final String? subnum;
  final Color titleColor;
  final Color subtitleColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final AnimationController controller;
  final Curve curve;

  late Animation<int> animation = IntTween(begin: 0, end: title).animate(
    CurvedAnimation(
      parent: controller,
      curve: curve,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return _buildChild(context: context, value: animation.value, values: subnum);
      },
    );
  }

  Widget _buildChild({required BuildContext context, required int value, String? values}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$value",
              style: GoogleFonts.poppins(
                color: Colors.blueAccent, // Changed title color here
                fontSize: 25,
              ),
            ),
            Text(
              "$values",
              style: GoogleFonts.poppins(
                color: Colors.blueAccent, // Changed subnum color here
                fontSize: 25,
              ),
            ),
          ],
        ),
        SizedBoxH8(),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            color: Colors.deepOrange, // Changed subtitle color here
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
