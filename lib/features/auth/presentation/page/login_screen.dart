import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/user_type_enum.dart';
import '../../../../core/functions/validations.dart';
import '../../../../core/routes/navigations.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/password_text_form_field.dart';
import '../widgets/social_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;

  String handleUserType() {
    return widget.userType == UserTypeEnum.doctor ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: const BackButton(color: AppColors.primaryColor),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logo, height: 200),
                  const SizedBox(height: 20),
                  Text(
                    'سجل دخول الان كـ "${handleUserType()}"',
                    style: TextStyles.title.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.end,
                    hintText: 'Yousef@example.com',
                    prefixIcon: Icon(Icons.email_rounded),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل الايميل';
                      } else if (!isEmailValid(value)) {
                        return 'من فضلك ادخل الايميل صحيحا';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25.0),
                  PasswordTextFormField(
                    hintText: '********',
                    validator: (value) {
                      if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                      return null;
                    },
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsetsDirectional.only(
                      top: 10,
                      start: 10,
                    ),
                    child: Text('نسيت كلمة السر ؟', style: TextStyles.small),
                  ),
                  const Gap(20),
                  MainButton(
                    onPressed: () async {
                    },
                    text: "تسجيل الدخول",
                  ),
                  const Gap(30),
                  SocialLogin(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ليس لدي حساب ؟',
                          style: TextStyles.body.copyWith(
                            color: AppColors.darkColor,
                          ),
                        ),
                        const Gap(3),
                        TextButton(
                          onPressed: () {
                            pushReplacement(
                              context,
                              Routes.register,
                              extra: widget.userType,
                            );
                          },
                          child: Text(
                            'سجل الان',
                            style: TextStyles.body.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
