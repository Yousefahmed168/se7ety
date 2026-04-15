import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_styles.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(color: AppColors.accentColor, thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'او',
                style: TextStyles.body.copyWith(color: AppColors.darkColor),
              ),
            ),
            const Expanded(
              child: Divider(color: AppColors.accentColor, thickness: 1),
            ),
          ],
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {},
              child: const Text('Google'),
            ),
          ],
        ),
      ],
    );
  }
}
