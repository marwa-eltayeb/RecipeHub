import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_hub/core/constants/api_constant.dart';
import 'package:recipe_hub/features/home/data/repository/recipe_repository.dart';
import 'package:recipe_hub/features/home/presentation/cubit/recipe_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: ApiConstant.baseUrl)));

  getIt.registerFactory<RecipeRepository>(() => RecipeRepositoryImpl(getIt<Dio>()),);
  getIt.registerFactory<RecipeCubit>(() => RecipeCubit(getIt<RecipeRepository>()),);
}
