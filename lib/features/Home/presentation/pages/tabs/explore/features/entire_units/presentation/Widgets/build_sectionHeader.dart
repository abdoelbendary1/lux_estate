import 'package:flutter/material.dart';
import 'package:lux_estate/core/theme/app_colors.dart';

class BuildSectionHeader extends StatelessWidget {
  const BuildSectionHeader({
    super.key,
    required this.title,
    this.hasTrailing = false,
    this.onTrailing,
    this.trailingText,
  });
  final String? title;
  final bool? hasTrailing;
  final VoidCallback? onTrailing;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title ?? "", style: Theme.of(context).textTheme.headlineSmall),
        hasTrailing ?? false
            ? TextButton(
                onPressed: onTrailing,
                child: Text(
                  trailingText ?? "",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: AppColors.secondary),
                ),
              )
            : Spacer(),
      ],
    );
  }
}
