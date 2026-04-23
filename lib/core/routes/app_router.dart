import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/page/doctor_registeration_screen.dart';
import 'package:se7ety/features/doctor/presentation/page/doctor_main_screen.dart';
import 'package:se7ety/features/patient/main/patient_main_app_screen.dart';
import '../constants/user_type_enum.dart';
import 'routes.dart';
import '../../features/auth/presentation/page/login_screen.dart';
import '../../features/auth/presentation/page/register_screen.dart';
import '../../features/intro/onboarding/onboarding_screen.dart';
import '../../features/intro/splash/splash_screen.dart';
import '../../features/intro/welcome/welcome_screen.dart';

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
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const PatientMainAppScreen(),
        ),
      ),
      GoRoute(
        path: Routes.doctorMainApp,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const DoctorMainAppScreen(),
        ),
      ),
      GoRoute(
        path: Routes.doctorUpdateProfile,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const UpdateDoctorProfileScreen(),
        ),
      ),

    ],
  );
}
