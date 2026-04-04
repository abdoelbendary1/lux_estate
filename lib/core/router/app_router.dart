import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/cubits/user_session/session_cubit.dart';
import 'package:lux_estate/core/di/injection.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/chats/presentation/pages/chats.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/explore.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/nearby_units/nearby_units_list.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/recently_added/recently_added_list.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/favorites/presentation/saved_units.dart';
import 'package:lux_estate/features/Home/presentation/pages/layout_bottom_nav_bar.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/presentation/pages/settings.dart';
import 'package:lux_estate/features/auth/presentation/pages/login_page.dart';
import 'package:lux_estate/features/auth/presentation/pages/register_page.dart';
import 'package:lux_estate/features/search/presentation/bloc/search_bloc.dart';
import 'package:lux_estate/features/search/presentation/pages/search_screen.dart';
import 'package:lux_estate/features/show_unit_details/presentation/pages/unit_details.dart';

@singleton
class AppRouter {
  final SessionCubit sessionCubit;

  AppRouter(this.sessionCubit);
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'AppRouterNavigatorKey',
  );
  late final GoRouter router = GoRouter(
    navigatorKey: _navigatorKey,
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            LayoutBottomNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes
                    .exploreScreenPath, // Remove leading '/' for GoRoute
                name: AppRoutes.exploreScreenName,
                builder: (context, state) => ExploreTab(),
                routes: [
                  GoRoute(
                    path: AppRoutes.detailsScreenPath,
                    name: AppRoutes.detailsScreenName,
                    parentNavigatorKey: _navigatorKey,

                    ///By setting parentNavigatorKey: _navigatorKey,
                    ///you are telling the router:
                    ///"Even though this route is defined inside the Home branch, don't render it inside the Shell.
                    ///Render it on the absolute root of the app."
                    builder: (context, state) => UnitDetailsScreen(
                      unit: state.extra as PropertyUnitEntity,
                    ), // Pass the unit details via state.extra
                  ),
                  GoRoute(
                    path: AppRoutes.searchScreenPath,
                    name: AppRoutes.searchScreenName,
                    parentNavigatorKey: _navigatorKey,
                    builder: (context, state) => BlocProvider(
                      create: (context) => getIt<SearchBloc>(),
                      child: SearchScreen(),
                    ),
                  ),
                  GoRoute(
                    path: AppRoutes.recentlyAdedScreenPath,
                    name: AppRoutes.recentlyAdedScreenName,
                    parentNavigatorKey: _navigatorKey,
                    builder: (context, state) => RecentlyAddedListPage(
                      units: state.extra as List<PropertyUnitEntity>,
                    ),
                  ),
                  GoRoute(
                    path: AppRoutes.nearbyScreenPath,
                    name: AppRoutes.nearbyScreenName,
                    parentNavigatorKey: _navigatorKey,
                    builder: (context, state) => NearbyUnitsListPage(
                      units: state.extra as List<PropertyUnitEntity>,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path:
                    AppRoutes.savedScreenPath, // Remove leading '/' for GoRoute
                name: AppRoutes.savedScreenName,
                builder: (context, state) => SavedUnitsTab(),
              ),
            ],
          ),
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: AppRoutes
          //           .sharedScreenPath, // Remove leading '/' for GoRoute
          //       name: AppRoutes.sharedScreenName,

          //       builder: (context, state) => SharedHousingTab(),
          //     ),
          //   ],
          // ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes
                    .messagesScreenPath, // Remove leading '/' for GoRoute
                name: AppRoutes.messagesScreenName,

                builder: (context, state) => MessagesTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes
                    .settingsScreenPath, // Remove leading '/' for GoRoute
                name: AppRoutes.settingsScreenName,

                builder: (context, state) => SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],

    redirect: (context, state) {
      final sessionState = sessionCubit.state;

      // Determine if user is currently trying to access auth pages
      final bool isLoggingIn = state.matchedLocation == AppRoutes.loginPath;
      final bool isRegistering =
          state.matchedLocation ==
          "${AppRoutes.loginPath}/${AppRoutes.registerPath}";
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
        return isAuthPage ? AppRoutes.exploreScreenPath : null;
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
