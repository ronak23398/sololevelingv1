import 'package:flutter/material.dart';

class XPProgressBar extends StatelessWidget {
  final double progress;
  final int currentXP;
  final int requiredXP;

  const XPProgressBar({
    Key? key,
    required this.progress,
    required this.currentXP,
    required this.requiredXP,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 12,
            backgroundColor: Colors.grey[800],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "XP: $currentXP/$requiredXP",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            Text(
              "${(progress * 100).toStringAsFixed(1)}%",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
