import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';

class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    super.key,
    required this.isSelected,
    required this.displayName,
    this.onSelected,
    this.hasIcon = false,
    this.icon,
  });

  final bool isSelected;
  final String displayName;
  final void Function(bool)? onSelected;
  final bool? hasIcon;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FilterChip(
      autofocus: true,
      side: BorderSide.none,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          hasIcon ?? false
              ? Visibility(
                  visible: hasIcon ?? false && icon != null,
                  child: Icon(
                    icon ?? Icons.tune,
                    size: 16.sp,
                    color: isSelected
                        ? AppColors.backgroundWhite
                        : AppColors.primary,
                  ),
                )
              : const SizedBox.shrink(),
          Visibility(
            visible: hasIcon ?? false,
            child: SizedBox(width: 4.w),
          ),
          Text(
            displayName,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.backgroundWhite : AppColors.primary,
            ),
          ),
        ],
      ),
      selected: isSelected,
      labelStyle: theme.textTheme.bodyLarge!.copyWith(
        color: isSelected ? AppColors.backgroundWhite : AppColors.primary,
      ),
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.grey.withOpacity(0.05),
      showCheckmark: false,
      pressElevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
        side: BorderSide(color: AppColors.transparent),
      ),
      onSelected: onSelected,
    );
  }
}
