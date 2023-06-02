import 'package:flutter_go_router/pages/about_page.dart';
import 'package:flutter_go_router/pages/login_page.dart';
import 'package:flutter_go_router/pages/main_page.dart';
import 'package:flutter_go_router/pages/profile_page.dart';
import 'package:go_router/go_router.dart';

import '../models/user.dart';
import '../pages/edit_profile_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/',
      name: 'main',
      builder: (context, state) {
        return const MainPage();
      },
      routes: [
        GoRoute(
          path: 'about',
          name: 'about',
          builder: (context, state) {
            return const AboutPage();
          },
        ),
        GoRoute(
            path: 'profile/:name',
            name: 'profile',
            builder: (context, state) {
              String name = state.pathParameters['name'] ?? 'no name';
              return ProfilePage(
                name: name,
              );
            },
            routes: [
              GoRoute(
                path: 'edit_profile',
                name: 'edit_profile',
                builder: (context, state) {
                  Object? object = state.extra;
                  if (object != null && object is User) {
                    return EditProfilePage(
                      user: object,
                    );
                  } else {
                    return EditProfilePage(
                      user: User(
                        name: 'no name',
                        email: 'no email',
                      ),
                    );
                  }
                },
              )
            ]),
      ],
    ),
  ],
  initialLocation: '/login',
  debugLogDiagnostics: true,
  routerNeglect: true,
);
