import 'package:flutter/material.dart';
import 'package:spotify_project/presentation/auth/pages/signin_page.dart';
import 'package:spotify_project/presentation/auth/pages/signup.dart';
import 'package:spotify_project/presentation/auth/pages/signup_or_sigin.dart';
import 'package:spotify_project/presentation/choose_mode/pages/choose_mode.dart';
import 'package:spotify_project/presentation/intro/pages/get_started.dart';

import '../root/pages/root.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/get-started':
        return MaterialPageRoute(builder: (_) => const GetStartedPage());
      case '/choose-mode':
        return MaterialPageRoute(builder: (_) => const ChooseModePage());
      case '/authentication':
        return MaterialPageRoute(builder: (_) => const SignupOrSigninPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) =>  SignupPage());
      case '/signin':
        return MaterialPageRoute(builder: (_) =>  SigninPage());
      case '/root':
        return MaterialPageRoute(builder: (_) => const RootPage());
      default:
        return null;
    }
  }
}
