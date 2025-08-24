import 'package:flutter/material.dart';
import 'package:leiter_quiz_application/logic/question_set.dart';

class ProgressWidget extends StatelessWidget {
  static const String completed = 'Completed!';

  int _questionsLeft = 0;
  int _questionAmount = 0;
  String _day = completed;
  ProgressWidget(this._questionsLeft, this._questionAmount, WeekDay day) {
    //_day = _questionsLeft <= 0 ? completed : day.fullName;
    _day = day.fullName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.grey[200],
      child: Row(
        children: [
          SizedBox(
            width: 130,
            height: 130,
            child: Center(
              child: Text(
                '${_questionAmount - _questionsLeft}/$_questionAmount',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                _day,
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
