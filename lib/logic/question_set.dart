import 'dart:developer';
import 'package:flutter/material.dart';

enum WeekDay { mon, tue, wed, thu, fri, sat, sun }

final List<Color> pileColors = [
  Colors.red.shade400, // worst
  Colors.orange.shade400,
  Colors.amber.shade400,
  Colors.lightGreen.shade500,
  Colors.green.shade700, // best
];

extension WeekDayString on WeekDay {
  String get fullName {
    switch (this) {
      case WeekDay.mon:
        return 'Monday';
      case WeekDay.tue:
        return 'Tuesday';
      case WeekDay.wed:
        return 'Wednesday';
      case WeekDay.thu:
        return 'Thursday';
      case WeekDay.fri:
        return 'Friday';
      case WeekDay.sat:
        return 'Saturday';
      case WeekDay.sun:
        return 'Sunday';
    }
  }
}

class QuestionSet {
  static const pileCount = 5;
  String title;

  final List<QuestionPile> _piles = [];
  List<QuestionPile> get piles => List.unmodifiable(_piles);
  //List<Question> _allQuestions = [];
  final Map<Question, int> _questionPile = {};

  List<Question> allQuestions = [];
  QuestionSet(this.title, Map<String, String> questionMap) {
    //fill question list from map
    questionMap.forEach((questionText, answerText) {
      allQuestions.add(Question(questionText, answerText));
      _questionPile[allQuestions.last] = 0;
    });
    //

    //create piles
    _piles.add(QuestionPile(allQuestions, WeekDay.values));
    _piles.add(
      QuestionPile([], [WeekDay.mon, WeekDay.wed, WeekDay.fri, WeekDay.sun]),
    );
    _piles.add(QuestionPile([], [WeekDay.tue, WeekDay.thu, WeekDay.sat]));
    _piles.add(QuestionPile([], [WeekDay.wed, WeekDay.fri]));
    _piles.add(QuestionPile([], [WeekDay.thu]));
    //
  }

  List<Question> getDailyQuestions(WeekDay day) {
    List<Question> questions = [];
    for (var pile in _piles) {
      if (pile.hasQuestionsForDay(day)) {
        questions.addAll(pile.questions);
      }
    }
    return questions;
  }

  void advance(Question question) {
    if (_questionPile.containsKey(question)) {
      int index = _questionPile[question]!;
      _piles[index]._remove(question);
      if (++index > _piles.length - 1) index = _piles.length - 1;
      _questionPile[question] = index;
      _piles[index]._add(question);

      question.color = pileColors[index];
    } else {
      log('Question not found');
    }
  }

  void reset(Question question) {
    if (_questionPile.containsKey(question)) {
      int index = _questionPile[question]!;
      _piles[index]._remove(question);

      index = 0;
      _questionPile[question] = index;
      _piles[0]._add(question);

      question.color = pileColors[0];
    } else {
      log('Question not found');
    }
  }
}

class QuestionPile {
  List<Question> questions;
  List<WeekDay> days;

  QuestionPile(this.questions, this.days);

  bool hasQuestionsForDay(WeekDay day) {
    return days.contains(day);
  }

  void _add(Question question) {
    questions.add(question);
  }

  void _remove(Question question) {
    questions.remove(question);
  }

  int count() {
    return questions.length;
  }
}

class Question {
  final String questionText;
  final String answerText;
  Color color = pileColors[0];

  Question(this.questionText, this.answerText);
}
