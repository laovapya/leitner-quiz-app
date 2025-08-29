import 'package:flutter/material.dart';
import 'package:leiter_quiz_application/homepage/homepage.dart';

import 'package:leiter_quiz_application/logic/quiz_provider.dart';
import 'package:leiter_quiz_application/logic/quiz_model.dart';

class QuizApp extends StatelessWidget {
  final QuizModel model = QuizModel();
  @override
  Widget build(BuildContext context) {
    return QuizProvider(
      model: model,
      child: MaterialApp(
        theme: ThemeData(
          //primarySwatch: Colors.indigo, // main app color
          //scaffoldBackgroundColor: Colors.white, // clean background
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        home: const Homepage(),
      ),
    );
  }
}
