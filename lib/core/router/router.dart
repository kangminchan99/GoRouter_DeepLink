import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouterdeeplink/presentation/screen/main_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                context.go('/home');
              },
              child: Text('입장'),
            ),
          ),
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(
          currentPageIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          child: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) {
                return Center(child: Text('home'));
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chat',
              builder: (context, state) {
                return Center(child: Text('chat'));
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) {
                return Center(child: Text('profile'));
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/setting',
              builder: (context, state) {
                return Center(child: Text('setting'));
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/message',
              builder: (context, state) {
                return Center(child: Text('message'));
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
