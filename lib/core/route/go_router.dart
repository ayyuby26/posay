import 'package:go_router/go_router.dart';
import 'package:posay/features/auth/presentation/pages/auth_page.dart';
import '../../features/intro/presentation/pages/intro_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const IntroScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
  ],
);
