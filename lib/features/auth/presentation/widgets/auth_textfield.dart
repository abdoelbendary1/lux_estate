import 'package:flutter/material.dart';
import 'package:lux_estate/core/theme/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.grey, //Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.grey, //Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
