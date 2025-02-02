import 'package:flutter/material.dart';

class TwoColumnView extends StatelessWidget {
  final int selectedNavigation;
  final Widget left;
  final Widget right;

  const TwoColumnView({
    required this.selectedNavigation,
    required this.left,
    required this.right,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedNavigation == 0) {
      return Row(
        children: [
          Expanded(
            child: left,
          ),
          Expanded(
            child: right,
          ),
        ],
      );
    } else {
      // cover full area
      return left;
    }
  }
}