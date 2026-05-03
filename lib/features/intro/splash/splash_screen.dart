import 'package:flutter/material.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/user_type_enum.dart';
import '../../../core/routes/navigations.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/local/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    bool isOnboardingShown = SharedPref.isOnboardingShown();
    bool isLoggedIn = SharedPref.getUserId().isNotEmpty == true;
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (!mounted) return;
      if (isLoggedIn) {
        final user = FirebaseAuth.instance.currentUser;
        final userType = UserTypeEnum.fromString(user?.photoURL ?? '');
        if (userType == UserTypeEnum.doctor) {
          pushReplacement(context, Routes.doctorMainApp);
        } else {
          pushReplacement(context, Routes.patientMainApp);
        }
      } else {
        if (isOnboardingShown) {
          pushReplacement(context, Routes.welcome);
        } else {
          pushReplacement(context, Routes.onboarding);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AppImages.logo, width: 250)),
    );
  }
}
