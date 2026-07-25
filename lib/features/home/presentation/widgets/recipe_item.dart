import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_hub/core/constants/app_colors.dart';

import 'custom_text.dart';

class RecipeItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String cuisine;
  final double rating;

  const RecipeItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.cuisine,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 100,
                color: AppColors.imagePlaceholder,
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 100,
                color: AppColors.imagePlaceholder,
                child: const Icon(Icons.broken_image, color: AppColors.textSecondary),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Name
          CustomText(
            name: name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          // Cuisine
          CustomText(
            name: cuisine,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),

          const SizedBox(height: 12),

          // Rating
          Row(
            children: [
              const Icon(Icons.star, size: 16, color: AppColors.rating),
              const SizedBox(width: 4),
              CustomText(
                name: rating.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}