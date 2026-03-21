import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/cubits/user_session/session_cubit.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/features/Home/presentation/pages/home_screen.dart';
import 'package:lux_estate/features/auth/presentation/pages/login_page.dart';
import 'package:lux_estate/features/auth/presentation/pages/register_page.dart'; // Add your register page path

@singleton
class AppRouter {
  final SessionCubit sessionCubit;

  AppRouter(this.sessionCubit);

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.loginPath, // Start at login by default
    // Re-run redirect logic whenever SessionCubit state changes
    refreshListenable: _GoRouterRefreshStream(sessionCubit.stream),

    routes: [
      GoRoute(
        path: AppRoutes.loginPath, // Remove leading '/' for GoRoute
        name: AppRoutes.loginName,
        builder: (context, state) => LoginScreen(),
        routes: [
          // Nested route for Register so it sits "on top" of Login
          GoRoute(
            path: AppRoutes.registerPath, // Remove leading '/' for nested route
            name: AppRoutes.registerName,
            builder: (context, state) => RegisterScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.homePath, // Remove leading '/' for GoRoute
        name: AppRoutes.homeName,
        builder: (context, state) => HomeScreen(),
      ),
    ],

    redirect: (context, state) {
      final sessionState = sessionCubit.state;

      // Determine if user is currently trying to access auth pages
      final bool isLoggingIn = state.matchedLocation == AppRoutes.loginPath;
      final bool isRegistering =
          state.matchedLocation == '/login/register'; // Full path
      final bool isAuthPage = isLoggingIn || isRegistering;
      // 1. If still checking (Initial), stay on current screen or show splash
      if (sessionState is SessionInitial) return null;

      // 2. If Not Logged In
      if (sessionState is SessionUnauthenticated) {
        // If they are already on an auth page, let them stay. Otherwise, force Login.
        return isAuthPage ? null : AppRoutes.loginPath;
      }

      // 3. If Logged In
      if (sessionState is SessionAuthenticated) {
        // If they are on Login/Register, kick them to Home
        return isAuthPage ? AppRoutes.homePath : null;
      }

      return null;
    },
  );
}

// Utility to convert Bloc stream to a Listenable for GoRouter
class _GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;
  _GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
