import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String name;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle style;

  const CustomText({
    super.key,
    required this.name,
    this.maxLines,
    this.overflow,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      maxLines: maxLines,
      overflow: overflow,
      style: style,
    );
  }
}