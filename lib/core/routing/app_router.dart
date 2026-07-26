import 'package:flutter/material.dart';
import 'package:recipe_hub/core/routing/routes.dart';
import 'package:recipe_hub/features/home/data/model/recipe_model.dart';
import 'package:recipe_hub/features/home/presentation/screens/details_screen.dart';
import 'package:recipe_hub/features/home/presentation/screens/home_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.detailsScreen:
        final recipe = settings.arguments as RecipeModel;
        return MaterialPageRoute(builder: (_) => DetailsScreen(recipe: recipe));
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