import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_hub/core/error/app_exception.dart';
import 'package:recipe_hub/features/home/data/repository/recipe_repository.dart';
import 'package:recipe_hub/features/home/data/model/recipe_model.dart';
import 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final RecipeRepository recipeRepository;

  RecipeCubit(this.recipeRepository) : super(InitialState());

  List<RecipeModel> _allRecipes = [];
  String _searchQuery = '';
  String? _selectedCuisine;

  List<String> get availableCuisines => _allRecipes.map((r) => r.cuisine).toSet().toList()..sort();

  String? get selectedCuisine => _selectedCuisine;

  Future<void> getRecipes() async {
    emit(LoadingState());
    try {
      final recipes = await recipeRepository.getRecipes();
      _allRecipes = recipes;
      emit(SuccessState(recipes: recipes));
    } on AppException catch (e) {
      emit(ErrorState(errorMessage: e.message));
    } catch (e) {
      emit(ErrorState(errorMessage: 'Something went wrong. Please try again.'));
    }
  }

  void searchRecipes(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterByCuisine(String? cuisine) {
    _selectedCuisine = cuisine;
    _applyFilters();
  }

  void clearFilters() {
    _selectedCuisine = null;
    _searchQuery = '';
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = _allRecipes;

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((r) => r.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    if (_selectedCuisine != null && _selectedCuisine!.isNotEmpty) {
      filtered = filtered.where((r) => r.cuisine == _selectedCuisine).toList();
    }

    emit(SuccessState(recipes: filtered));
  }
}
