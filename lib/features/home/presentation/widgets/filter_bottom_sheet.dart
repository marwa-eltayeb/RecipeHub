import 'package:flutter/material.dart';
import 'package:recipe_hub/core/constants/app_colors.dart';
import 'package:recipe_hub/core/constants/app_strings.dart';
import 'filter_chip_item.dart';

class FilterBottomSheet extends StatelessWidget {
  final List<String> cuisines;
  final String? selectedCuisine;
  final ValueChanged<String?> onCuisineSelected;
  final VoidCallback onClearFilter;

  const FilterBottomSheet({
    super.key,
    required this.cuisines,
    required this.selectedCuisine,
    required this.onCuisineSelected,
    required this.onClearFilter,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Single header (no redundant subtitle)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppStrings.filterByCuisine,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onClearFilter();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      AppStrings.clearFilter,
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: cuisines
                    .map(
                      (cuisine) => FilterChipItem(
                    label: cuisine,
                    isSelected: cuisine == selectedCuisine,
                    onTap: () {
                      onCuisineSelected(cuisine);
                      Navigator.pop(context);
                    },
                  ),
                )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}