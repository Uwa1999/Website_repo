import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void singleButtonDialog(
    BuildContext context, {
      IconData? icon,
      required String message,
      required String title,
      Function()? onPressed,
    }) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => MessageDialog(
      tittle: title,
      content: message,
      icon: icon ?? Icons.warning_amber_outlined,
      buttonText: 'Okay',
      function: onPressed,
    ),
  );
}

class MessageDialog extends StatelessWidget {
  final String tittle;
  final String content;
  final IconData icon;
  final String buttonText;
  final Function()? function;
  final bool dualButton;

  const MessageDialog({
    Key? key,
    required this.tittle,
    required this.content,
    required this.icon,
    this.function,
    this.dualButton = false,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Container(
        decoration: const BoxDecoration(
            color: Color(0xFF4B0C0C),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        padding: const EdgeInsets.all(10),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              tittle,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontFamily: 'RobotoThin',
              ),
            ),
          ],
        ),
      ),
      content: SizedBox(
        height: 20,
        child: Center(
          child: SelectableText(
            content,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontFamily: 'RobotoThin',
            ),
          ),
        ),
      ),
      actions: [
        (dualButton)
            ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Close the confirmation dialog
            },
            child: const Text(
              'No',
              style: TextStyle(
                  color: Color(0xFF4B0C0C),
                  fontSize: 13,
                  fontFamily: 'RobothoThin'),
            ),
          ),
          TextButton(
            onPressed: () {
              function!();
              Navigator.of(context)
                  .pop();
            },
            child: Text(
              buttonText,
              style: const TextStyle(
                  color: Color(0xFF4B0C0C),
                  fontSize: 13,
                  fontFamily: 'RobothoThin'),
            ),
          ),
        ])
            : Center(
          child: TextButton(
            onPressed:  () {
              if(function!=null) {
                function!();
              }
              Navigator.of(context)
                  .pop();
            },
            child: Text(
              buttonText,
              style: const TextStyle(
                  color: Color(0xFF4B0C0C),
                  fontSize: 13,
                  fontFamily: 'RobothoThin'),
            ),
          ),
        ),
      ],
    );
  }
}