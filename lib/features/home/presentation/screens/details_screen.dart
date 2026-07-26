import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_hub/core/constants/app_colors.dart';
import 'package:recipe_hub/core/constants/app_strings.dart';
import 'package:recipe_hub/features/home/data/model/recipe_model.dart';
import 'package:recipe_hub/features/home/presentation/widgets/custom_text.dart';
import 'package:recipe_hub/features/home/presentation/widgets/recipe_stat_badge.dart';

class DetailsScreen extends StatelessWidget {
  final RecipeModel recipe;
  const DetailsScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          recipe.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive: wider content padding on larger screens (tablets/web)
            final horizontalPadding = constraints.maxWidth > 600 ? 60.0 : 16.0;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: recipe.image,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 200,
                          color: AppColors.imagePlaceholder,
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 200,
                          color: AppColors.imagePlaceholder,
                          child: const Icon(Icons.broken_image, color: AppColors.textSecondary),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Cuisine
                  CustomText(
                    name: recipe.cuisine,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, size: 18, color: AppColors.rating),
                      const SizedBox(width: 4),
                      Text(
                        recipe.rating.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Stats row: prep time, cook time, difficulty
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RecipeStatBadge(
                          icon: Icons.schedule,
                          label: AppStrings.prepTime,
                          value: "${recipe.prepTimeMinutes} ${AppStrings.minutes}",
                        ),
                        RecipeStatBadge(
                          icon: Icons.local_fire_department,
                          label: AppStrings.cookTime,
                          value: "${recipe.cookTimeMinutes} ${AppStrings.minutes}",
                        ),
                        RecipeStatBadge(
                          icon: Icons.bar_chart,
                          label: AppStrings.difficulty,
                          value: recipe.difficulty,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Ingredients
                  const CustomText(
                    name: AppStrings.ingredients,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...recipe.ingredients.map(
                        (ingredient) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              ingredient,
                              style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Instructions
                  const CustomText(
                    name: AppStrings.instructions,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...recipe.instructions.asMap().entries.map(
                        (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: AppColors.primary,
                            child: Text(
                              "${entry.key + 1}",
                              style: const TextStyle(fontSize: 11, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}