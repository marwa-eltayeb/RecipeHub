import 'package:dio/dio.dart';
import 'package:recipe_hub/core/constants/api_constant.dart';
import 'package:recipe_hub/features/home/data/model/recipe_model.dart';

abstract class RecipeRepository {
  Future<List<RecipeModel>> getRecipes();
}

class RecipeRepositoryImpl implements RecipeRepository {
  final Dio dio;
  RecipeRepositoryImpl(this.dio);

  @override
  Future<List<RecipeModel>> getRecipes() async {
    final response = await dio.get(ApiConstant.recipes);
    final recipes = (response.data['recipes'] as List)
        .map((json) => RecipeModel.fromJson(json))
        .toList();
    return recipes;
  }
}