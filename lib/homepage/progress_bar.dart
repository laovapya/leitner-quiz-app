import 'package:flutter/material.dart';
import 'package:leiter_quiz_application/logic/quiz_provider.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quiz = QuizProvider.of(context)!.model;

    final questionsLeft = quiz.remainingDailyQuestions.length;
    final questionAmount = quiz.maxDailyQuestions;
    final dayName = quiz.dayName; //questionsLeft <= 0 ? completed :

    return Container(
      color: Colors.grey[200],
      child: Row(
        children: [
          SizedBox(
            width: 130,
            height: 130,
            child: Center(
              child: Text(
                '${questionAmount - questionsLeft}/$questionAmount',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                dayName,
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
