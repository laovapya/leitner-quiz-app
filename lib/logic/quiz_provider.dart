import 'package:flutter/material.dart';
import 'package:leiter_quiz_application/logic/quiz_model.dart';

class QuizProvider extends InheritedNotifier {
  final QuizModel model;
  const QuizProvider({Key? key, required Widget child, required this.model})
    : super(key: key, child: child, notifier: model);

  // @override
  // bool updateShouldNotify(QuizProvider oldWidget) {
  //   return true; //quiz_model calls setState() on Quiz (root) which rebuilds QuizProvider and calls updateShouldNotify
  // }

  static QuizProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<QuizProvider>();
  }
}
