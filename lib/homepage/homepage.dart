import 'package:flutter/material.dart';
import 'package:leiter_quiz_application/logic/quiz_provider.dart';
import 'package:leiter_quiz_application/page_container.dart';
import 'package:leiter_quiz_application/homepage/histogram.dart';
import 'package:leiter_quiz_application/homepage/progress_bar.dart';
import 'package:leiter_quiz_application/question_card.dart';
import 'package:leiter_quiz_application/quiz_button.dart';
import 'package:leiter_quiz_application/text_container.dart';

import 'dart:developer';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quiz = QuizProvider.of(context)!.model;
    const QuestionCardWidget? _questionCardWidget = const QuestionCardWidget();

    return PageContainer(
      hasBackArrow: false,
      child: Column(
        children: [
          const ProgressWidget(),
          const SizedBox(height: 10),
          if (quiz.isQuestionsetCompleted)
            const TextContainer(text: 'Victory 🎉', fontSize: 20),
          if (!quiz.isQuestionsetCompleted &&
              quiz.remainingDailyQuestions.isEmpty &&
              quiz.questionSet != null)
            const TextContainer(
              text: 'Daily questions completed!',
              fontSize: 20,
            ),
          if (quiz.remainingDailyQuestions.isEmpty && quiz.questionSet != null)
            QuizButtonWidget(text: 'pass time', onPressed: quiz.moveToNextDay),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextContainer(
                  text: quiz.questionSet?.title ?? 'No question set chosen!',
                  fontSize: 25,
                ),
                const SizedBox(height: 10),
                const HistogramWidget(),
                const SizedBox(height: 10),
                QuizButtonWidget(
                  text: 'Choose "General knowledge" question set',
                  onPressed: quiz.updateQuestionSet,
                ),
                const SizedBox(height: 10),
                Builder(
                  builder: (context) => QuizButtonWidget(
                    text: 'Continue question set',
                    onPressed:
                        quiz.remainingDailyQuestions.isNotEmpty &&
                            !quiz.isQuestionsetCompleted
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => _questionCardWidget,
                              ),
                            ).then((_) {
                              quiz.checkVictory();
                            });
                          }
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
