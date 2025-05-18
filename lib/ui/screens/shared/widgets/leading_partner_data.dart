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
  late AnimationController gradientController;

  @override
  void initState() {
    super.initState();

    // Controller for counting numbers
    numberAnimation = IntTween(begin: 0, end: widget.title).animate(
      CurvedAnimation(parent: widget.controller, curve: widget.curve),
    );

    // Independent controller for the gradient animation
    gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // 🔁 Loops infinitely
  }

  @override
  void dispose() {
    gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: numberAnimation,
      builder: (context, child) {
        return Column(
          children: [
            // ✅ Gradient now uses its own looping controller
            AnimatedGradientText(
              animation: gradientController,
              text: "${numberAnimation.value}${widget.subnum ?? ''}",
              fontSize: 100,
            ),
            const SizedBox(height: 12),
            Text(
              widget.subtitle,
              style: widget.subtitleStyle ??
                  GoogleFonts.poppins(
                    color: widget.subtitleColor,
                    fontSize: 25,
                  ),
            ),
          ],
        );
      },
    );
  }
}

class MobileLeadingBankingPartnerData {
  final int? value;
  final String subtitle;
  final String? values;

  MobileLeadingBankingPartnerData({
    this.value,
    required this.subtitle,
    this.values,
  });
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$value",
              style: GoogleFonts.poppins(
                color: titleColor,
                fontSize: 25,
              ),
            ),
            Text(
              "$values",
              style: GoogleFonts.poppins(
                color: titleColor,
                fontSize: 25,
              ),
            ),
          ],
        ),
        SizedBoxH8(),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            color: subtitleColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
