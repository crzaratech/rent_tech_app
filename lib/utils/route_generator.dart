import 'package:flutter/material.dart';
import 'package:rent_tech/InitialScreens/signup_screen.dart';
import 'package:rent_tech/InitialScreens/splash_screen.dart';
import 'package:rent_tech/main.dart';
import 'package:rent_tech/InitialScreens/login_screen.dart';
import 'package:rent_tech/InitialScreens/forgotpassword_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings data) {
    final args = data.arguments;

    switch (data.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case '/forgot':
        return MaterialPageRoute(builder: (_) => Forgotscreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
