import 'package:flutter/material.dart';
import 'package:recipe_hub/core/di/service_locator.dart';
import 'package:recipe_hub/core/routing/app_router.dart';
import 'package:recipe_hub/core/routing/routes.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: Routes.homeScreen,
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}

