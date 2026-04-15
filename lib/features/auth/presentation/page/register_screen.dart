import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/user_type_enum.dart';
import '../../../../core/functions/validations.dart';
import '../../../../core/routes/navigations.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/password_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  Image.asset('assets/images/logo.png', height: 200),
                  const SizedBox(height: 20),
                  Text(
                    'سجل دخول الان كـ "${handleUserType()}"',
                    style: TextStyles.title,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.text,

                    decoration: const InputDecoration(
                      hintText: 'اسم المستخدم',
                      prefixIcon: Icon(Icons.person),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل الاسم';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25.0),
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

                  const Gap(20),
                  MainButton(onPressed: () async {}, text: "تسجيل حساب جديد"),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'لدي حساب ؟',
                          style: TextStyles.body.copyWith(
                            color: AppColors.darkColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            pushReplacement(
                              context,
                              Routes.login,
                              extra: widget.userType,
                            );
                          },
                          child: Text(
                            'سجل دخول',
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
