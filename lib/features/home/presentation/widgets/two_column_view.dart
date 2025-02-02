import 'package:flutter/material.dart';
import 'package:fluttor_bloc_tutorial/features/home/presentation/pages/list_images.dart';
import 'package:fluttor_bloc_tutorial/features/home/presentation/pages/upload_image.dart';
import 'package:fluttor_bloc_tutorial/features/home/presentation/pages/view_image.dart';

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