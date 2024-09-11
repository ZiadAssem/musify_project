import 'package:flutter/material.dart';
import 'package:spotify_project/presentation/auth/pages/signup_or_sigin.dart';
import 'package:spotify_project/presentation/choose_mode/pages/choose_mode.dart';
import 'package:spotify_project/presentation/intro/pages/get_started.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/get-started':
        return MaterialPageRoute(builder: (_) => const GetStartedPage());
      case '/choose-mode':
        return MaterialPageRoute(builder: (_) => const ChooseModePage());
      case '/authentication':
        return MaterialPageRoute(builder: (_) => const SignupOrSigninPage());
      default:
        return null;
    }
  }
}
