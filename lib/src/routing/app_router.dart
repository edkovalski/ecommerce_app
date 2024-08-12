import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/name_password_sign_in_form_type.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/name_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/favorites/presentation/favorites/favorites_screen.dart';

import 'package:ecommerce_app/src/features/products/presentation/products_list/products_list_screen.dart';
import 'package:ecommerce_app/src/features/products/presentation/wrapper/wrapper.dart';

import 'package:ecommerce_app/src/routing/go_router_refresh_stream.dart';
import 'package:ecommerce_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  home,
  favorites,
  account,
  signIn,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  final shellNavigatorSettings =
      GlobalKey<NavigatorState>(debugLabel: 'shellFavorites');
  final shellNavigatorAccount =
      GlobalKey<NavigatorState>(debugLabel: 'shellAccount');

  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/') {
          return '/home';
        }
      } else {
        if (path == '/account') {
          return '/';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: NamePasswordSignInScreen(
            formType: NamePasswordSignInFormType.signIn,
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: "/home",
                name: AppRoute.home.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const ProductsListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorSettings,
            routes: <RouteBase>[
              GoRoute(
                path: "/favorites",
                name: "Favorites",
                builder: (BuildContext context, GoRouterState state) =>
                    const ShoppingFavoritesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorAccount,
            routes: <RouteBase>[
              GoRoute(
                path: "/account",
                name: "Account",
                builder: (BuildContext context, GoRouterState state) =>
                    const AccountScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
