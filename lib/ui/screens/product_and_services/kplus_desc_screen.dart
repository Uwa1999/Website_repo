import 'package:flutter/material.dart';

class kPlusDescScreen extends StatefulWidget {
  const kPlusDescScreen({Key? key}) : super(key: key);

  @override
  State<kPlusDescScreen> createState() => _kPlusDescScreenState();
}

class _kPlusDescScreenState extends State<kPlusDescScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          Text("kPlus Description"),
        ],
      ),
    );
  }
}
