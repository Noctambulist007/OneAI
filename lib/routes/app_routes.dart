import 'package:flutter/material.dart';
import 'package:one_ai/features/auth/screen/login_screen.dart';
import 'package:one_ai/features/auth/screen/register_screen.dart';
import 'package:one_ai/features/home/screen/home_screen.dart';
import 'package:one_ai/features/image_ai/screen/image_ai_screen.dart';
import 'package:one_ai/features/splash/screen/splash_screen.dart';
import 'package:one_ai/features/text_ai/screen/text_ai_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String textAI = '/textAI';
  static const String imageAI = '/imageAI';

  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) {
        switch (settings.name) {
          case splash:
            return const SplashScreen();
          case home:
            return const HomeScreen();
          case textAI:
            return TextAiScreen();
          case imageAI:
            return const ImageAiScreen();
          case login:
            return const LoginScreen();
          case register:
            return const RegisterScreen();
          default:
            return const HomeScreen();
        }
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
