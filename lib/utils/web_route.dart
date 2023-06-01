import 'package:arfriendv2/pages/web/web_main_page.dart';
import 'package:arfriendv2/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/web/web_login_page.dart';
import '../pages/web/web_not_found_page.dart';

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
    GoRoute(
      path: '/',
      name: '/',
      pageBuilder: (context, state) {
        // if (FirebaseAuth.instance.currentUser == null) {
        //   context.goNamed(RouteName.masuk);
        // }
        return buildPageWithDefaultTransition(
            context: context, state: state, child: const WebMainPage());
      },
      // ShellRoute(
      //   navigatorKey: shellNavigatorKey,
      //   pageBuilder: ((context, state, child) {
      //     return buildPageWithDefaultTransition(
      //       context: context,
      //       state: state,
      //       child: WebDashboardPage(widget: child, route: state.location),
      //     );
      //   }),
      //   routes: [
      //     GoRoute(
      //       path: '/',
      //       name: "/",
      //       pageBuilder: (context, state) {
      //         return NoTransitionPage(
      //           child: Container(
      //             color: Colors.blue,
      //           ),
      //         );
      //       },
      //       routes: [
      //         GoRoute(
      //           path: RouteName.home,
      //           name: RouteName.home,
      //           pageBuilder: (context, state) {
      //             return NoTransitionPage(
      //               child: WebHomePage(
      //                 route: state.location,
      //               ),
      //             );
      //           },
      //         ),
      //         GoRoute(
      //           path: RouteName.chat,
      //           name: RouteName.chat,
      //           pageBuilder: (context, state) {
      //             return NoTransitionPage(
      //                 child: WebChatPage(
      //               route: state.location,
      //             ));
      //           },
      //         ),
      //         GoRoute(
      //           path: RouteName.stream,
      //           name: RouteName.stream,
      //           pageBuilder: (context, state) {
      //             return const NoTransitionPage(child: WebChatV2Page());
      //           },
      //         ),
      //         GoRoute(
      //           path: RouteName.train,
      //           name: RouteName.train,
      //           pageBuilder: (context, state) {
      //             return NoTransitionPage(
      //               child: WebTrainPage(
      //                 route: state.location,
      //               ),
      //             );
      //           },
      //         ),
      //         GoRoute(
      //           path: RouteName.user,
      //           name: RouteName.user,
      //           pageBuilder: (context, state) {
      //             return NoTransitionPage(
      //               child: WebUserPage(
      //                 route: state.location,
      //               ),
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //   ],
    ),
  ],
  initialLocation: "/",
  debugLogDiagnostics: true,
  routerNeglect: true,
);
