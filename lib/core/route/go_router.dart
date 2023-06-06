import 'package:go_router/go_router.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/features/auth/domain/repositories/user_repository.dart';
import 'package:posay/features/auth/presentation/pages/auth_page.dart';
import 'package:posay/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:posay/features/intro/data/models/intro_model.dart';
import 'package:posay/injection.dart';
import '../../features/intro/presentation/pages/intro_page.dart';

// GoRouter configuration
final router = GoRouter(
  redirect: (context, state) {
    dynamic user;
    Injection().locator<UserRepository>().getLocalUser().fold((l) => null, (r) {
      user = r;
    });

    final isIntroViewed = !Injection().locator<Box<IntroModel>>().isEmpty();
    if (isIntroViewed) {
      if (user != null) return null;
      return AuthPage.path;
    } else {
      return IntroPage.path;
    } 
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
