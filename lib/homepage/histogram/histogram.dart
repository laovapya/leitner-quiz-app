import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:leiter_quiz_application/logic/question_set.dart';
import 'dart:math' as math;

class HistogramWidget extends StatelessWidget {
  static const double histogramBarXOffset = 30;
  static const double histogramYaxisOffset = 5;
  static const double barWidth = 15;
  static const double tickWidth = 5;
  //QuestionSet? questionSet;
  List<int> barHeights = List.filled(QuestionSet.pileCount, 0);

  int _maxVerticalDivisions = 1;
  static const int maxHorizontalDivisions = QuestionSet.pileCount;

  HistogramWidget(this.barHeights, int maxVerticalDivisions) {
    _maxVerticalDivisions = maxVerticalDivisions > 0 ? maxVerticalDivisions : 1;
  }

  int _height = 150;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: _height.toDouble(),
        color: Colors.grey[200],
        child: LayoutBuilder(
          builder: (context, constraints) {
            final canvasWidth = constraints.maxWidth;
            final canvasHeight = constraints.maxHeight;

            return Stack(
              clipBehavior: Clip.none, // ✅ let ticks/bars overflow outside
              children: [
                for (int i = 0; i < QuestionSet.pileCount; i++)
                  Positioned(
                    left:
                        histogramBarXOffset -
                        barWidth / 2 +
                        i * (canvasWidth / maxHorizontalDivisions),
                    bottom: 0,
                    child: Container(
                      width: barWidth,
                      height: math.max(
                        tickWidth / 2,
                        (barHeights[i] / _maxVerticalDivisions) * canvasHeight -
                            histogramYaxisOffset,
                      ),

                      color: pileColors[i],
                    ),
                  ),
                CustomPaint(
                  size: Size(canvasWidth, canvasHeight),
                  painter: _AxisPainter(
                    _maxVerticalDivisions,
                    maxHorizontalDivisions,
                    histogramBarXOffset,
                    histogramYaxisOffset,
                    tickWidth,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AxisPainter extends CustomPainter {
  final int maxVerticalDivisions;
  final int maxHorizontalDivisions;
  final double histogramBarXOffset;
  final double histogramYaxisOffset;
  final double tickWidth;

  _AxisPainter(
    this.maxVerticalDivisions,
    this.maxHorizontalDivisions,
    this.histogramBarXOffset,
    this.histogramYaxisOffset,
    this.tickWidth,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // y-axis
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), paint);

    // x-axis
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      paint,
    );

    // y axis tick marks
    for (int i = 0; i < maxVerticalDivisions; i++) {
      double y =
          histogramYaxisOffset +
          i * ((size.height - histogramYaxisOffset) / maxVerticalDivisions);
      canvas.drawLine(
        Offset(-tickWidth / 2, y),
        Offset(tickWidth / 2, y),
        paint,
      );
    }

    //x axis tick marks
    for (int i = 0; i < maxHorizontalDivisions; i++) {
      double x =
          histogramBarXOffset + i * ((size.width) / maxHorizontalDivisions);
      canvas.drawLine(
        Offset(x, size.height - tickWidth / 2),
        Offset(x, size.height + tickWidth / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
