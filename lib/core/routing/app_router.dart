import 'package:flutter/material.dart';
import 'package:recipe_hub/core/routing/routes.dart';
import 'package:recipe_hub/features/home/presentation/screens/home_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}