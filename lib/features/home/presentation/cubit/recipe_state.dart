import 'package:recipe_hub/features/home/data/model/recipe_model.dart';

abstract class RecipeState {}

class InitialState extends RecipeState {}

class LoadingState extends RecipeState {}

class SuccessState extends RecipeState {
  final List<RecipeModel> recipes;
  SuccessState({required this.recipes});
}

class ErrorState extends RecipeState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
}