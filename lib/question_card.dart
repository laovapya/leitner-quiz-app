import 'package:flutter/material.dart';
import 'package:leiter_quiz_application/page_container.dart';
import 'package:leiter_quiz_application/quiz_button.dart';
import 'package:leiter_quiz_application/logic/question_set.dart';

class QuestionCardWidget extends StatefulWidget {
  Question currentQuestion;
  final List<Question> remainingDailyQuestions;
  final QuestionSet questionSet;

  QuestionCardWidget(this.remainingDailyQuestions, this.questionSet)
    : currentQuestion = remainingDailyQuestions.isNotEmpty
          ? remainingDailyQuestions[0]
          : Question('', '');

  @override
  _QuestionCardWidgetState createState() => _QuestionCardWidgetState();
}

class _QuestionCardWidgetState extends State<QuestionCardWidget> {
  bool isCompleted = false;
  bool isCorrect = false;
  String currentAnswer = '';
  //String finalAnswer = '';

  final TextEditingController _textController = TextEditingController();

  void _answer() {
    setState(() {
      isCompleted = true;
      isCorrect =
          currentAnswer.trim().toLowerCase() ==
          widget.currentQuestion.answerText.trim().toLowerCase();

      if (isCorrect) {
        widget.questionSet.advance(widget.currentQuestion);
      } else {
        widget.questionSet.reset(widget.currentQuestion);
      }
      widget.remainingDailyQuestions.removeAt(0);

      _textController.clear();
      FocusScope.of(context).unfocus();
    });
  }

  void _moveToNext() {
    setState(() {
      isCompleted = false;
      isCorrect = false;
      currentAnswer = '';
      if (widget.remainingDailyQuestions.isNotEmpty) {
        widget.currentQuestion = widget.remainingDailyQuestions[0];
      } else {
        Navigator.pop(context);
        print("no daily questions remaining!");
      }
      _textController.clear();
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      hasBackArrow: true,
      onBackPressed: _moveToNext,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 140,
            color: widget.currentQuestion.color.withAlpha(128),
            alignment: Alignment.center,
            child: Text(
              "Question: \n ${widget.currentQuestion.questionText}",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              alignment: Alignment.center,

              child: isCompleted
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Your answer: ${currentAnswer}'),
                        isCorrect
                            ? Text('Correct!', style: TextStyle(fontSize: 40))
                            : Column(
                                children: [
                                  Text(
                                    'Incorrect!',
                                    style: TextStyle(fontSize: 40),
                                  ),
                                  Text(
                                    'Correct answer: ${widget.currentQuestion.answerText}',
                                  ),
                                ],
                              ),
                      ],
                    )
                  : null,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            enabled: !isCompleted,
            controller: _textController,
            textAlign: TextAlign.left,
            decoration: InputDecoration(hintText: "Answer..."),
            onChanged: (value) {
              setState(() {
                currentAnswer = value;
              });
            },
          ),
          SizedBox(height: 10),
          isCompleted
              ? QuizButtonWidget(text: 'Next', onPressed: _moveToNext)
              : QuizButtonWidget(text: "Confirm", onPressed: _answer),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
