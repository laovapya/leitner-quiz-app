import 'package:flutter/material.dart';
import 'package:leiter_quiz_application/page_container.dart';
import 'package:leiter_quiz_application/logic/question_set.dart';
import 'package:leiter_quiz_application/homepage/histogram/histogram.dart';
import 'package:leiter_quiz_application/homepage/progress_bar.dart';
import 'package:leiter_quiz_application/quiz_button.dart';
import 'package:leiter_quiz_application/text_container.dart';
import 'package:leiter_quiz_application/homepage/histogram/histogram.dart';
import 'package:leiter_quiz_application/question_card.dart';
import 'dart:developer';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  //to "DailySessionState"
  QuestionSet? _questionSet;
  WeekDay _day = WeekDay.mon;
  List<Question> _remainingDailyQuestions = [];
  int _maxDailyQuestions = 0;
  int _questionAmount = 1;
  //--------------------------------------
  bool _isQuestionsetCompleted = false;
  QuestionCardWidget? _questionCardWidget;

  void _updateQuestionSet() {
    log("update querstion set!");
    setState(() {
      _questionSet = QuestionSet('General Knowledge', {
        'What is the capital of France?': 'Paris',
        'What is 2 + 2?': '4',
        'What is the largest planet in our solar system?': 'Jupiter',
        'What is the smallest prime number?': '2',
      });
      _update();
      _questionAmount =
          _questionSet!.allQuestions.length; //= _maxDailyQuestions;
      _isQuestionsetCompleted = false;
    });
  }

  void _moveToNextDay() {
    setState(() {
      _day = WeekDay.values[(_day.index + 1) % WeekDay.values.length];
      log(_day.fullName);
      _update();
    });
  }

  void _update() {
    _remainingDailyQuestions = _questionSet?.getDailyQuestions(_day) ?? [];
    _maxDailyQuestions = _remainingDailyQuestions.length;

    _questionCardWidget = QuestionCardWidget(
      _remainingDailyQuestions,
      _questionSet!,
    );
  }

  void _checkVictory() {
    if (_questionSet != null) {
      log(_questionSet!.allQuestions.length.toString());
      _isQuestionsetCompleted =
          _questionSet!.piles.last.count() == _questionAmount;
      if (_isQuestionsetCompleted) {
        log("Question set completed!");
      }
    }
  }

  //--------------------------------------------------
  @override
  Widget build(BuildContext context) {
    List<int> pileCounts =
        _questionSet?.piles.map((pile) => pile.count()).toList() ??
        List.filled(QuestionSet.pileCount, 0);

    return MaterialApp(
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
      home: PageContainer(
        hasBackArrow: false,
        child: Column(
          children: [
            ProgressWidget(
              _remainingDailyQuestions.length,
              _maxDailyQuestions,
              _day,
            ),
            SizedBox(height: 10),
            if (_isQuestionsetCompleted)
              TextContainer(text: 'Victory 🎉', fontSize: 20),
            if (!_isQuestionsetCompleted &&
                _remainingDailyQuestions.isEmpty &&
                _questionSet != null)
              TextContainer(text: 'Daily questions completed!', fontSize: 20),
            if (_remainingDailyQuestions.isEmpty && _questionSet != null)
              QuizButtonWidget(text: 'pass time', onPressed: _moveToNextDay),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextContainer(
                    text: _questionSet?.title ?? 'No question set chosen!',
                    fontSize: 25,
                  ),
                  SizedBox(height: 10),
                  HistogramWidget(
                    List.from(pileCounts), //force new object
                    _questionAmount,
                  ),
                  SizedBox(height: 10),
                  QuizButtonWidget(
                    text: 'Choose "General knowledge" question set',
                    onPressed: _updateQuestionSet,
                  ),
                  SizedBox(height: 10),

                  Builder(
                    builder: (context) => QuizButtonWidget(
                      text: 'Continue question set',
                      onPressed:
                          _remainingDailyQuestions.isNotEmpty &&
                              !_isQuestionsetCompleted
                          ? () {
                              //print(_remainingDailyQuestions.first);
                              if (_questionCardWidget != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => _questionCardWidget!,
                                  ),
                                ).then((_) {
                                  setState(() {});
                                  _checkVictory();
                                });
                              } else {
                                log("No question card widget");
                              }
                            }
                          : null,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void navigateTo(BuildContext context, Widget page) {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => page));
// }
