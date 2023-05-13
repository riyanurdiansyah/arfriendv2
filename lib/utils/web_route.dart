import 'package:arfriendv2/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/web/web_dashboard_page.dart';
import '../pages/web/web_login_page.dart';
import '../pages/web/web_not_found_page.dart';
import 'route_name.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

GoRouter router = GoRouter(
  errorPageBuilder: (context, state) => buildPageWithDefaultTransition(
      context: context, state: state, child: const WebNotFoundPage()),
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/halo',
      name: 'halo',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: const WelcomePage()),
    ),
    GoRoute(
      path: '/masuk',
      name: 'masuk',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: const WebLoginPage()),
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      pageBuilder: ((context, state, child) {
        return buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: WebDashboardPage(widget: child, route: state.location),
        );
      }),
      routes: [
        GoRoute(
          path: '/',
          name: "/",
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: Container(
                color: Colors.blue,
              ),
            );
          },
          routes: [
            GoRoute(
              path: RouteName.home,
              name: RouteName.home,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: SizedBox(),
                );
              },
            ),
            // GoRoute(
            //   path: RouteName.chat,
            //   name: RouteName.chat,
            //   pageBuilder: (context, state) {
            //     return const NoTransitionPage(child: ChatPage());
            //   },
            // ),
            // GoRoute(
            //   path: RouteName.history,
            //   name: RouteName.history,
            //   pageBuilder: (context, state) {
            //     return const NoTransitionPage(child: HistoryPage());
            //   },
            // ),
            // GoRoute(
            //   path: RouteName.train,
            //   name: RouteName.train,
            //   pageBuilder: (context, state) {
            //     return const NoTransitionPage(child: TrainPage());
            //   },
            // ),
          ],
        ),
      ],
    ),
  ],
  initialLocation: "/halo",
  debugLogDiagnostics: true,
  routerNeglect: true,
);
