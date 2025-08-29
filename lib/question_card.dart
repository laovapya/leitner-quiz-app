import 'package:flutter/material.dart';
import 'package:leiter_quiz_application/logic/quiz_model.dart';
import 'package:leiter_quiz_application/logic/quiz_provider.dart';
import 'package:leiter_quiz_application/page_container.dart';
import 'package:leiter_quiz_application/quiz_button.dart';

class QuestionCardWidget extends StatefulWidget {
  const QuestionCardWidget({Key? key}) : super(key: key);
  @override
  _QuestionCardWidgetState createState() => _QuestionCardWidgetState();
}

class _QuestionCardWidgetState extends State<QuestionCardWidget> {
  //Question currentQuestion = Question('', '');
  //const QuestionCardWidget({Key? key}) : super(key: key);

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final QuizModel quiz = QuizProvider.of(context)!.model;

    return PageContainer(
      hasBackArrow: true,
      onBackPressed: () {
        quiz.moveToNextQuestion(context, textController);
        quiz.currentAnswer = '';
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 140,
            color: quiz.currentQuestion.color.withAlpha(128),
            alignment: Alignment.center,
            child: Text(
              "Question: \n ${quiz.currentQuestion.questionText}",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              alignment: Alignment.center,

              child: quiz.isCompleted
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Your answer: ${quiz.currentAnswer}'),
                        quiz.isCorrect
                            ? Text('Correct!', style: TextStyle(fontSize: 40))
                            : Column(
                                children: [
                                  Text(
                                    'Incorrect!',
                                    style: TextStyle(fontSize: 40),
                                  ),
                                  Text(
                                    'Correct answer: ${quiz.currentQuestion.answerText}',
                                  ),
                                ],
                              ),
                      ],
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            enabled: !quiz.isCompleted,
            controller: textController,
            textAlign: TextAlign.left,
            decoration: InputDecoration(hintText: "Answer..."),
            onChanged: (value) {
              quiz.currentAnswer = value;
            },
          ),
          const SizedBox(height: 10),
          quiz.isCompleted
              ? QuizButtonWidget(
                  text: 'Next',
                  onPressed: () =>
                      quiz.moveToNextQuestion(context, textController),
                )
              : QuizButtonWidget(
                  text: "Confirm",
                  onPressed: () => quiz.submitAnswer(context, textController),
                ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
