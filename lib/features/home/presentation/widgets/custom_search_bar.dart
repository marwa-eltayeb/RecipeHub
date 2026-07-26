import 'package:flutter/material.dart';
import 'package:recipe_hub/core/constants/app_colors.dart';
import 'package:recipe_hub/core/constants/app_strings.dart';

class CustomSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final VoidCallback? onClear;

  const CustomSearchBar({
    super.key,
    required this.onChanged,
    this.controller,
    this.onClear,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
    if (widget.controller?.text.isEmpty ?? false) {
      _focusNode.unfocus();
    }
  }

  void _handleClear() {
    widget.controller?.clear();
    widget.onChanged('');
    widget.onClear?.call();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final showClear = widget.controller?.text.isNotEmpty ?? false;

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.search, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                hintText: AppStrings.searchHint,
                hintStyle: TextStyle(color: AppColors.textSecondary),
                border: InputBorder.none,
                isCollapsed: true,
              ),
              onChanged: widget.onChanged,
            ),
          ),
          if (showClear)
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textSecondary),
              splashRadius: 20,
              onPressed: _handleClear,
            ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}