import 'package:flutter/material.dart';

// class TitleWidget extends StatelessWidget {
//   final String title;

//   TitleWidget({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 40,
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       alignment: Alignment.centerLeft,
//       //margin: EdgeInsets.symmetric(horizontal: 20),
//       color: Colors.grey[200], // background
//       child: Text(title, style: TextStyle(fontSize: 25)),
//     );
//   }
// }

import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? backgroundColor;
  final Alignment alignment;
  final EdgeInsetsGeometry padding;

  const TextContainer({
    required this.text,
    this.fontSize = 16,
    this.backgroundColor,
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
      color: backgroundColor ?? Colors.grey[200],
      child: Text(text, style: TextStyle(fontSize: fontSize)),
    );
  }
}
