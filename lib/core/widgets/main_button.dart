import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor = AppColors.primaryColor,
    this.borderColor,
    this.minWidth = double.infinity,
    this.minHeight = 56,
    this.textColor = AppColors.whiteColor,
  });
  final String text;
  final Function() onPressed;
  final Color bgColor;
  final Color? borderColor;
  final double minWidth;
  final double minHeight;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding: EdgeInsets.zero,
        minimumSize: Size(minWidth, minHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyles.body.copyWith(color: textColor)),
    );
  }
}
