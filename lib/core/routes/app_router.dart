import 'package:go_router/go_router.dart';
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
        builder: (context, state) =>
            LoginScreen(userType: state.extra as UserTypeEnum),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) =>
            RegisterScreen(userType: state.extra as UserTypeEnum),
      ),
    ],
  );
}
