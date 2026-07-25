import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_hub/core/constants/app_colors.dart';
import 'package:recipe_hub/core/constants/app_strings.dart';
import 'package:recipe_hub/core/di/service_locator.dart';
import 'package:recipe_hub/features/home/presentation/cubit/recipe_cubit.dart';
import 'package:recipe_hub/features/home/presentation/cubit/recipe_state.dart';
import 'package:recipe_hub/features/home/presentation/widgets/recipe_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RecipeCubit>()..getRecipes(),
      child: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
            );
          } else if (state is ErrorState) {
            return Scaffold(
              body: Center(child: Text(state.errorMessage)),
            );
          } else if (state is SuccessState) {
            if (state.recipes.isEmpty) {
              return const Scaffold(
                body: Center(child: Text(AppStrings.noRecipesFound)),
              );
            }

            return Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                title: const Text(AppStrings.appTitle),
                backgroundColor: AppColors.background,
                elevation: 0,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                      return GridView.builder(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        itemCount: state.recipes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          mainAxisExtent: 230,
                        ),
                        itemBuilder: (context, index) {
                          final recipe = state.recipes[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              // Navigate to details screen
                            },
                            child: RecipeItem(
                              imageUrl: recipe.image,
                              name: recipe.name,
                              cuisine: recipe.cuisine,
                              rating: recipe.rating,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return const Scaffold();
          }
        },
      ),
    );
  }
}