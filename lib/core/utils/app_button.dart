import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';

class BuildAppButton extends StatelessWidget {
  const BuildAppButton({
    super.key,
    required this.onTap,
    required this.actionText,
    this.curvedBottom = true,
    this.curvedTop = true,
    this.leadingIcon,
    this.trailingIcon,
    this.backgroundColor,
  });

  final VoidCallback? onTap;
  final String actionText;
  final bool curvedBottom;
  final bool curvedTop;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.vertical(
            bottom: curvedBottom ? Radius.circular(24.r) : Radius.circular(0),
            top: curvedTop ? Radius.circular(24.r) : Radius.circular(0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leadingIcon != null
                ? Icon(
                    leadingIcon,
                    color: AppColors.backgroundWhite,
                    size: 25.r,
                  )
                : SizedBox.shrink(),
            SizedBox(width: 8.w),

            Text(
              actionText.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.backgroundWhite,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(width: 8.w),
            trailingIcon != null
                ? Icon(
                    trailingIcon,
                    color: AppColors.backgroundWhite,
                    size: 25.r,
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
