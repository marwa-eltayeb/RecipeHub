import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_hub/features/home/data/repository/recipe_repository.dart';
import 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final RecipeRepository recipeRepository;
  RecipeCubit(this.recipeRepository) : super(InitialState());

  Future<void> getRecipes() async {
    emit(LoadingState());
    try {
      final recipes = await recipeRepository.getRecipes();
      emit(SuccessState(recipes: recipes));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
