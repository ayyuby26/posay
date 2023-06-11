import 'package:go_router/go_router.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/features/auth/domain/repositories/user_repository.dart';
import 'package:posay/features/auth/presentation/pages/auth_page.dart';
import 'package:posay/features/dashboard/features/stock/presentation/pages/search_stock_page.dart';
import 'package:posay/features/dashboard/features/stock/presentation/pages/stock_manager_page.dart';
import 'package:posay/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:posay/features/intro/data/models/intro_model.dart';
import 'package:posay/injector.dart';
import '../../features/intro/presentation/pages/intro_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: DashboardPage.path,
  redirect: (context, state) {
    dynamic user;

    final getUser = Injector.gett<UserRepository>().getLocalUser();
    getUser.fold((e) {}, (r) => user = r);

    final introNotSeen = Injector.gett<Box<IntroModel>>().isEmpty();

    if (introNotSeen) return IntroPage.path;
    if (user == null) return AuthPage.path;
    return null;
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
    GoRoute(
      path: StockManagerPage.pathForGoRouter,
      builder: (context, state) {
        return StockManagerPage(state.pathParameters['databaseId'] ?? "");
      },
    ),
    GoRoute(
      path: SearchStockPage.path,
      builder: (context, state) {
        return const SearchStockPage();
      },
    ),
  ],
);
