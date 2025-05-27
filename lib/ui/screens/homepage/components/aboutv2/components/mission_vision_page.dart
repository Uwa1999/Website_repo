import 'package:flutter/material.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/animation.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/customCard.dart';

import '../../../../shared/utils/responsive.dart';
import '../../../../shared/widgets/buttons/footer.dart';


class MissionVision extends StatefulWidget {
  static const String route = '/Mission&Vission';

  const MissionVision({Key? key}) : super(key: key);

  @override
  State<MissionVision> createState() => _MissionVisionState();
}

class _MissionVisionState extends State<MissionVision> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      drawer: screenWidth < 1024 ? const SideMenu() : null,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Listening is where the care begins.',

                    style: TextStyle(fontSize: 40),)
                  ),
                  const SizedBox(height: 20),
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


