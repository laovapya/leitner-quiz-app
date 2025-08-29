import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color backgroundColor;
  final Alignment alignment;
  final EdgeInsetsGeometry padding;

  const TextContainer({
    required this.text,
    this.fontSize = 16,
    this.backgroundColor = const Color(0xFFEEEEEE), // replace Colors.grey[200]
    this.alignment = Alignment.centerLeft,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: padding,
      alignment: alignment,
      color: backgroundColor,
      child: Text(text, style: TextStyle(fontSize: fontSize)),
    );
  }
}
