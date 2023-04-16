import 'package:eat_smart/app/error_page.dart';
import 'package:eat_smart/app/home/home_screen.dart';
import 'package:eat_smart/app/layout.dart';
import 'package:eat_smart/app/result/result_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter goRouter; // This instance will be store route state

  AppRouter() : goRouter = router;

  static GoRouter get router => GoRouter(
        debugLogDiagnostics: true,
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              return GlobalLayout.show(child: child);
            },
            routes: [
              GoRoute(
                path: '/',
                builder: (BuildContext context, GoRouterState state) {
                  return const HomeScreen();
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'error',
                    builder: (BuildContext context, GoRouterState state) {
                      return ErrorPage(text: state.extra as String);
                    },
                  ),
                  GoRoute(
                    path: 'result',
                    builder: (BuildContext context, GoRouterState state) {
                      return const ResultPage();
                    },
                    routes: <RouteBase>[],
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
