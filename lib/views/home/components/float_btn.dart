import 'package:flutter/material.dart';
import 'package:task_management/utils/app_colors.dart';

class FloatBtn extends StatelessWidget {
  const FloatBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 2,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(child: Icon(Icons.add, color: Colors.white)),
        ),
      ),
    );
  }
}