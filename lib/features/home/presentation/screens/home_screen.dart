import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_hub/core/constants/app_colors.dart';
import 'package:recipe_hub/core/constants/app_strings.dart';
import 'package:recipe_hub/core/di/service_locator.dart';
import 'package:recipe_hub/core/routing/routes.dart';
import 'package:recipe_hub/features/home/presentation/cubit/recipe_cubit.dart';
import 'package:recipe_hub/features/home/presentation/cubit/recipe_state.dart';
import 'package:recipe_hub/features/home/presentation/widgets/error_state_view.dart';
import 'package:recipe_hub/features/home/presentation/widgets/recipe_item.dart';
import 'package:recipe_hub/features/home/presentation/widgets/custom_search_bar.dart';
import 'package:recipe_hub/features/home/presentation/widgets/filter_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RecipeCubit>()..getRecipes(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<RecipeCubit>();

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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomSearchBar(
                            controller: _searchController,
                            onChanged: cubit.searchRecipes,
                            onClear: () => cubit.searchRecipes(''),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.tune, color: AppColors.primary),
                            onPressed: () => _openFilterSheet(context, cubit),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Expanded(
                      child: BlocBuilder<RecipeCubit, RecipeState>(
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(color: AppColors.primary),
                            );
                          } else if (state is ErrorState) {
                            return ErrorStateView(
                              message: state.errorMessage,
                              onRetry: cubit.getRecipes,
                            );
                          } else if (state is SuccessState) {
                            if (state.recipes.isEmpty) {
                              return const Center(child: Text(AppStrings.noRecipesFound));
                            }

                            return LayoutBuilder(
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
                                        Navigator.pushNamed(
                                          context,
                                          Routes.detailsScreen,
                                          arguments: recipe,
                                        );
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
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openFilterSheet(BuildContext context, RecipeCubit cubit) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => FilterBottomSheet(
        cuisines: cubit.availableCuisines,
        selectedCuisine: cubit.selectedCuisine,
        onCuisineSelected: cubit.filterByCuisine,
        onClearFilter: cubit.clearFilters,
      ),
    );
  }
}