import 'package:dio/dio.dart';
import 'package:recipe_hub/core/constants/api_constant.dart';
import 'package:recipe_hub/core/error/app_exception.dart';
import 'package:recipe_hub/features/home/data/model/recipe_model.dart';

abstract class RecipeRepository {
  Future<List<RecipeModel>> getRecipes();
}

class RecipeRepositoryImpl implements RecipeRepository {
  final Dio dio;
  RecipeRepositoryImpl(this.dio);

  @override
  Future<List<RecipeModel>> getRecipes() async {
    try {
      final response = await dio.get(ApiConstant.recipes);
      final recipes = (response.data['recipes'] as List)
          .map((json) => RecipeModel.fromJson(json))
          .toList();
      return recipes;
    } on DioException catch (e) {
     throw AppException(_mapDioErrorToMessage(e));
    }
  }

  String _mapDioErrorToMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The connection timed out. Please try again.';
      case DioExceptionType.badResponse:
        return 'Server error (${e.response?.statusCode}). Please try again later.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}