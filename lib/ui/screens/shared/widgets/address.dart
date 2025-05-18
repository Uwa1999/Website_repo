import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyAddressWidget extends StatefulWidget {
  const CopyAddressWidget({Key? key}) : super(key: key);

  @override
  State<CopyAddressWidget> createState() => _CopyAddressWidgetState();
}

class _CopyAddressWidgetState extends State<CopyAddressWidget> {
  final String address = 'G/F 1519 D. Oliman St., Valenzuela, Makati City';
  bool copied = false;

  Future<void> copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: address));
    setState(() {
      copied = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        copied = false;
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Address copied to clipboard!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            address,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        IconButton(
          icon: Icon(
            copied ? Icons.check : Icons.copy,
            color: copied ? Colors.green : null,
          ),
          onPressed: copyToClipboard,
          tooltip: copied ? 'Copied!' : 'Copy',
        ),
      ],
    );
  }
}
