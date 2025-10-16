import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouterdeeplink/core/navigation/main_screen.dart';
import 'package:gorouterdeeplink/presentation/authentication/view/login_screen.dart';
import 'package:gorouterdeeplink/presentation/authentication/view/sign_up_screen.dart';
import 'package:gorouterdeeplink/presentation/chat/view/chat_screen.dart';
import 'package:gorouterdeeplink/presentation/home/view/home_screen.dart';
import 'package:gorouterdeeplink/presentation/message/view/message_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/sign_up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavScreen(
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
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chat',
                builder: (context, state) => const ChatScreen(),
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
                builder: (context, state) => const MessageScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
