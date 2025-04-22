import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class InProgressCircle extends StatelessWidget {
  final double percent;
  final int isFinished;

  const InProgressCircle({
    super.key,
    required this.percent,
    required this.isFinished,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 20,
      lineWidth: 5,
      percent: percent,
      center:
          percent != 0.0
              ? Text(
                "${(percent * 100).toInt()}%",
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              )
              : null,
      progressColor:
          isFinished == 0
              ? Colors.orange
              : isFinished == 1
              ? Colors.green
              : Colors.red,
      backgroundColor:
          isFinished == 0
              ? Colors.orange.shade100
              : isFinished == 1
              ? Colors.green.shade100
              : Colors.red.shade100,
      circularStrokeCap: CircularStrokeCap.round,
      animation: false,
    );
  }
}
