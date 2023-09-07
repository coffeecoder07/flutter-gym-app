import 'package:flutter/material.dart';
import 'package:gymapp/UI/Screens/ErrorScreen.dart';
import 'package:gymapp/UI/Screens/Home.dart';

class CustomRouter {
  static Route<dynamic> generateRoutes(
      RouteSettings settings,
      ) {
    final args = settings.arguments;
    final name = settings.name;
    switch (name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Home());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
    }
  }
}