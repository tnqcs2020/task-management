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
      radius: 13,
      lineWidth: 5,
      percent: percent,
      // center:
      //     percent != 0.0
      //         ? Text(
      //           "${(percent * 100).toInt()}%",
      //           style: const TextStyle(
      //             fontSize: 9,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         )
      //         : null,
      progressColor:
          isFinished == 0
              ? percent != 0.0
                  ? Colors.orange.shade700
                  : Colors.orange.shade200
              : isFinished == 1
              ? percent != 0.0
                  ? Colors.green.shade700
                  : Colors.green.shade200
              : percent != 0.0
              ? Colors.red.shade700
              : Colors.red.shade200,
      backgroundColor:
          isFinished == 0
              ? Colors.orange.shade200
              : isFinished == 1
              ? Colors.green.shade200
              : Colors.red.shade200,
      circularStrokeCap: CircularStrokeCap.round,
      animation: false,
    );
  }
}
