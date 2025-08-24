import 'package:flutter/material.dart';

class QuizButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  QuizButtonWidget({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        //padding: EdgeInsets.all(5),
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        //alignment: Alignment.centerLeft,
      ),
      child: Text(text, textAlign: TextAlign.left),
    );
  }
}
