import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:starter_project/src/features/auth/presentation/pages/login_screen.dart';
import 'package:starter_project/src/features/auth/presentation/pages/otp_screen.dart';
import 'package:starter_project/src/features/auth/presentation/pages/register_screen.dart';
import 'package:starter_project/src/features/blog/domain/entities/blog_b.dart';
import 'package:starter_project/src/features/blog/presentation/pages/add_blog_screen.dart';
import 'package:starter_project/src/features/blog/presentation/pages/all_blogs_screen.dart';
import 'package:starter_project/src/features/blog/presentation/pages/blogs_dashboard/blogs_dashboard.dart';
import 'package:starter_project/src/features/blog/presentation/pages/edit_blog_screen.dart';
import 'package:starter_project/src/features/blog/presentation/pages/my_blogs_screen.dart';
import 'package:starter_project/src/features/profiles/presentation/pages/profile_screen.dart';

import '../../features/blog/presentation/pages/blog_details.dart';
import '../widgets/test_page.dart';

final routes = <GoRoute>[
  //* Test page(for testing purposes)
  GoRoute(
    name: AppRoutes.test,
    path: "/test",
    builder: (context, state) => const TestScreen(),
  ),
  GoRoute(
    name: AppRoutes.otpScreen,
    path: '/${OtpScreen.routeName}',
    builder: (context, state) => const OtpScreen(),
  ),
  GoRoute(
    name: AppRoutes.registerScreen,
    path: '/${RegisterScreen.routeName}',
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    name: AppRoutes.loginScreen,
    path: '/${LoginScreen.routeName}',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    name: AppRoutes.profileScreen,
    path: '/${ProfileScreen.routeName}',
    builder: (context, state) => const ProfileScreen(),
  ),
  GoRoute(
    name: AppRoutes.addblogScreen,
    path: '/${AddBlogScreen.routeName}',
    builder: (context, state) => const AddBlogScreen(),
  ),
  GoRoute(
    name: AppRoutes.editblogScreen,
    path: '/${EditBlogScreen.routeName}',
    builder: (context, state) {
      Blog blog = state.extra as Blog;
      return EditBlogScreen(
        blog: blog,
      );
    },
  ),

  GoRoute(
    name: AppRoutes.allblogsScreen,
    path: '/${AllBlogsScreen.routeName}',
    builder: (context, state) => const AllBlogsScreen(),
  ),
  GoRoute(
    name: AppRoutes.myblogsScreen,
    path: '/${MyBlogsScreen.routeName}',
    builder: (context, state) => const MyBlogsScreen(),
  ),

  GoRoute(
    name: AppRoutes.blogDetails,
    path: '/${BlogDetails.routeName}/:id',
    builder: (context, state) {
      final id = state.pathParameters['id']!;
      return BlogDetails(id: int.parse(id));
    },
  ),

  GoRoute(
    name: AppRoutes.blogsDashboard,
    path: '/${BlogsDashboard.routeName}',
    builder: (context, state) => const BlogsDashboard(),
  ),
];

//* Custom transition page
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

//* Default page builder
Page<dynamic> Function(BuildContext, GoRouterState) defaultPageBuilder<T>(
        Widget child) =>
    (BuildContext context, GoRouterState state) {
      return buildPageWithDefaultTransition<T>(
        context: context,
        state: state,
        child: child,
      );
    };

class AppRoutes {
  //* Test route
  static const String test = "test";
  static const String otpScreen = 'otp-screen';
  static const String registerScreen = 'register-screen';

  static const String loginScreen = 'login-screen';
  static const String profileScreen = 'profile-screen';

  static const String addblogScreen = 'add-blog-screen';
  static const String editblogScreen = 'edit-blog-screen';

  static const String allblogsScreen = 'all-blogs-screen';
  static const String profileEditScreen = "profile-edit-screen";
  static const String blogDetails = "blog-details-screen";

  static const String blogsDashboard = "blogs-dashboard";
  static const String myblogsScreen = "my-blogs-screen";
  
}
