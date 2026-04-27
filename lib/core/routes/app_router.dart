import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/page/doctor_registeration_screen.dart';
import 'package:se7ety/features/auth/presentation/page/login_screen.dart';
import 'package:se7ety/features/auth/presentation/page/register_screen.dart';
import 'package:se7ety/features/intro/onboarding/onboarding_screen.dart';
import 'package:se7ety/features/intro/splash/splash_screen.dart';
import 'package:se7ety/features/intro/welcome/welcome_screen.dart';
import 'package:se7ety/features/patient/home/presentation/page/specializatioin_search_screen.dart';
import 'package:se7ety/features/patient/main/patient_main_app_screen.dart';

class AppRouter {
  static GoRouter routes = GoRouter(
    navigatorKey: globalContext,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: Routes.patientMainApp,
        builder: (context, state) => const PatientMainAppScreen(),
      ),
      GoRoute(
        path: Routes.doctorUpdateProfile,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const UpdateDoctorProfileScreen(),
        ),
      ),
      GoRoute(
        path: Routes.specializationSearch,
        builder: (context, state) =>
            SpecializationSearchScreen(specialization: state.extra as String),
      ),
    ],
  );
}
