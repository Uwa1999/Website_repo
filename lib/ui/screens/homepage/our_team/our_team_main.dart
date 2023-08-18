import 'package:flutter/material.dart';

class OurTeamMain extends StatefulWidget {
  const OurTeamMain({Key? key}) : super(key: key);

  @override
  State<OurTeamMain> createState() => _OurTeamMainState();
}

class _OurTeamMainState extends State<OurTeamMain> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            width: size.width,
            constraints: BoxConstraints(minHeight: size.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[],
            ),
          ),
        ),
      ),
    );
  }
}
