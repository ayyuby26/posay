import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:posay/features/auth/presentation/pages/auth_page.dart';
import 'package:posay/features/dashboard/features/stock/presentation/pages/search_stock_page.dart';
import 'package:posay/features/dashboard/features/stock/presentation/pages/stock_manager_page.dart';
import 'package:posay/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:posay/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:posay/shared/extension.dart';
import '../../features/intro/presentation/pages/intro_page.dart';

final router = GoRouter(
  initialLocation: DashboardPage.path,
  redirect: (context, state) {
    final authBloc = context.read<AuthBloc>();
    final introBloc = context.read<IntroBloc>();

    authBloc.add(AuthGetLocalUser());
    final userExisting = authBloc.state.status.isSuccess;

    introBloc.add(IntroIsSeen());

    final isIntroSeen = introBloc.state.isIntroSeen;
    if (isIntroSeen == false) {
      introBloc.add(IntroGetContents(context.tr));
      return IntroPage.path;
    }
    if (userExisting == false) return AuthPage.path;
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
        return StockManagerPage(state.pathParameters['documentId'] ?? "");
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
