import 'package:flutter/material.dart';

import 'package:leiter_quiz_application/logic/question_set.dart';

import 'package:leiter_quiz_application/question_card.dart';

import 'dart:developer';

class QuizModel extends ChangeNotifier {
  QuestionSet? _questionSet;
  QuestionSet? get questionSet => _questionSet;
  set questionSet(QuestionSet? value) {
    _questionSet = value;
    notifyListeners();
  }

  WeekDay _day = WeekDay.mon;
  WeekDay get day => _day;
  String get dayName => _day.fullName;

  List<Question> _remainingDailyQuestions = [];
  List<Question> get remainingDailyQuestions => _remainingDailyQuestions;

  int _maxDailyQuestions = 0;
  int get maxDailyQuestions => _maxDailyQuestions;

  int _questionAmount = 1;
  int get questionAmount => _questionAmount;

  //--------------------------------------

  bool _isQuestionsetCompleted = false;
  bool get isQuestionsetCompleted => _isQuestionsetCompleted;

  void updateQuestionSet() {
    questionSet = QuestionSet('General Knowledge', {
      'What is the capital of France?': 'Paris',
      'What is 2 + 2?': '4',
      'What is the largest planet in our solar system?': 'Jupiter',
      'What is the smallest prime number?': '2',
    });

    _questionAmount = questionSet!.allQuestions.length; //= _maxDailyQuestions;
    _isQuestionsetCompleted = false;

    _update();
  }

  void moveToNextDay() {
    _day = WeekDay.values[(_day.index + 1) % WeekDay.values.length];
    log(_day.fullName);
    _update();
  }

  void _update() {
    _remainingDailyQuestions = questionSet?.getDailyQuestions(_day) ?? [];
    _maxDailyQuestions = _remainingDailyQuestions.length;

    _resetCurrentQuestion();

    // questionCardWidget = QuestionCardWidget(
    //   _remainingDailyQuestions,
    //   questionSet!,
    // );
    notifyListeners();
  }

  void checkVictory() {
    if (questionSet != null) {
      log(questionSet!.allQuestions.length.toString());
      _isQuestionsetCompleted =
          questionSet!.piles.last.count() == _questionAmount;
      if (_isQuestionsetCompleted) {
        log("Question set completed!");
        questionSet = null;
      }
      notifyListeners();
    }
  }

  //--------------------------------------------------------------------QUIZ CARD--------------------------------------------------------------------------------
  Question _currentQuestion = Question('', '');
  Question get currentQuestion => _currentQuestion;
  void _resetCurrentQuestion() {
    _currentQuestion = remainingDailyQuestions.isNotEmpty
        ? remainingDailyQuestions[0]
        : Question('', '');
    //notifyListeners();
  }

  String _currentAnswer = '';
  String get currentAnswer => _currentAnswer;
  set currentAnswer(String value) {
    _currentAnswer = value;
    notifyListeners();
  }

  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;
  bool _isCorrect = false;
  bool get isCorrect => _isCorrect;

  void submitAnswer(
    BuildContext context,
    TextEditingController textController,
  ) {
    _isCompleted = true;
    _isCorrect =
        currentAnswer.trim().toLowerCase() ==
        _currentQuestion.answerText.trim().toLowerCase();

    //process answer
    if (_isCorrect) {
      questionSet!.advance(_currentQuestion);
    } else {
      questionSet!.reset(_currentQuestion);
    }
    remainingDailyQuestions.removeAt(0);

    textController.clear();
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  void moveToNextQuestion(
    BuildContext context,
    TextEditingController textController,
  ) {
    //move to next question

    _isCompleted = false;
    _isCorrect = false;
    //currentAnswer = ''; to questioncard
    if (remainingDailyQuestions.isNotEmpty) {
      _currentQuestion = remainingDailyQuestions[0];
    } else {
      Navigator.pop(context);
      //print("no daily questions remaining!");
    }
    textController.clear();
    FocusScope.of(context).unfocus();

    notifyListeners();
  }
}
