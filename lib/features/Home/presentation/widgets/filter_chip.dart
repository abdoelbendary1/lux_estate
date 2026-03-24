import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';

class AppFilterChip extends StatelessWidget {
  AppFilterChip({
    super.key,
    required this.isSelected,
    required this.displayName,
    this.onSelected,
  });

  bool isSelected;
  String displayName;
  void Function(bool)? onSelected;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      autofocus: true,

      side: BorderSide.none,
      label: Text(displayName),
      selected: isSelected,

      // Text Styles (Matches Image)
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        // White on black, black on grey
        color: isSelected ? AppColors.backgroundWhite : AppColors.primary,
      ),

      // Background Colors (Matches Image)
      selectedColor: AppColors.primary, // Selected background
      backgroundColor: AppColors.grey.withOpacity(0.05), // Unselected
      // Visual Settings (Key parts of the "Chip" Look)
      showCheckmark: false, // Turn off selection icon
      pressElevation: 1, // subtle interaction feel
      // Shape (Full Pill)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
        // Ensures no default chip border is visible
        side: BorderSide(color: AppColors.transparent),
      ),

      // Internal Padding
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h, // vertical pads the text
      ),

      // Minimize extra padding around the chip
      labelPadding: EdgeInsets.zero,

      onSelected: onSelected,
    );
  }
}
