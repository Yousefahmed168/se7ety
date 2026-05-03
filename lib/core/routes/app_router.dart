import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../constants/user_type_enum.dart';
import 'routes.dart';
import '../../features/auth/data/model/doctor_model.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/page/doctor_registeration_screen.dart';
import '../../features/auth/presentation/page/login_screen.dart';
import '../../features/auth/presentation/page/register_screen.dart';
import '../../features/intro/onboarding/onboarding_screen.dart';
import '../../features/intro/splash/splash_screen.dart';
import '../../features/intro/welcome/welcome_screen.dart';
import '../../features/patient/booking/presentation/booking_view.dart';
import '../../features/patient/main/patient_main_app_screen.dart';
import '../../features/patient/search/doctor_profile/page/doctor_profile_screen.dart';
import '../../features/patient/search/specilization_search/page/specializatioin_search_screen.dart';
import '../../features/doctor/settings/settings_view.dart';
import '../../features/doctor/settings/doctor_details.dart';
import '../../features/doctor/main/doctor_main_app_screen.dart';
import '../../features/patient/settings/user_details.dart';

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
      GoRoute(
        path: Routes.doctorProfile,
        builder: (context, state) =>
            DoctorProfileScreen(doctorModel: state.extra as DoctorModel),
      ),
      GoRoute(
        path: Routes.bookingDoctor,
        builder: (context, state) =>
            BookingScreen(doctor: state.extra as DoctorModel),
      ),
      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: Routes.doctorAccountInfo,
        builder: (context, state) => const AccountInfoDoctorScreen(),
      ),
      GoRoute(
        path: Routes.patientAccountInfo,
        builder: (context, state) => const AccountInfopatientScreen(),
      ),
      GoRoute(
        path: Routes.doctorMainApp,
        builder: (context, state) => const DoctorMainAppScreen(),
      ),
    ],
  );
}
