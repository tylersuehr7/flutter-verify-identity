part of 'application.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: "/",
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      name: HomeScreen.screenName,
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: ProtectedScreen.screenName,
      path: "/protected/:someId",
      builder: (context, state) => ProtectedScreen.fromState(state),
    ),
    GoRoute(
      name: UnProtectedScreen.screenName,
      path: "/unprotected/:someId",
      builder: (context, state) => UnProtectedScreen.fromState(state),
    ),
    GoRoute(
      name: VerificationScreen.screenName,
      path: "/verification",
      builder: (context, state) {
        final VerificationScreenArgs args = state.extra as VerificationScreenArgs;
        return VerificationScreen(args);
      },
    ),
    GoRoute(
      name: ChangePinScreen.screenName,
      path: "/change-pin",
      builder: (context, state) => const ChangePinScreen(),
    ),
  ],
);
