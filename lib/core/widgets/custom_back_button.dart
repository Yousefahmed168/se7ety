import 'package:flutter/material.dart';

import '../constants/app_images.dart';
import '../routes/navigations.dart';
import 'custom_svg_picture.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => pop(context),
          child: CustomSvgPicture(path: AppImages.backSvg),
        ),
      ],
    );
  }
}
