import 'package:go_router/go_router.dart';
import 'package:posay/features/auth/presentation/pages/auth_page.dart';
import 'package:posay/features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/intro/presentation/pages/intro_page.dart';

// GoRouter configuration
final router = GoRouter(
  redirect: (context, state) {
    return DashboardPage.path;
  },
  routes: [
    GoRoute(
      path: IntroPage.path,
      builder: (context, state) => const IntroPage(),
    ),
    GoRoute(
      path: AuthPage.path,
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: DashboardPage.path,
      builder: (context, state) => const DashboardPage(),
    ),
  ],
);
