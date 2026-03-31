import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';

class BuildSaveUI extends StatelessWidget {
  const BuildSaveUI({
    super.key,
    required this.isSaved,
    required this.onSaveToggle,
  });
  final bool? isSaved;
  final VoidCallback? onSaveToggle;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25.r,
      backgroundColor: AppColors.backgroundWhite.withOpacity(0.9),
      child: IconButton(
        onPressed: () => onSaveToggle,
        icon: Icon(
          applyTextScaling: true,
          Icons.favorite,
          color: isSaved == true
              ? AppColors.error
              : AppColors.grey.withOpacity(0.6),
          size: 30.sp,
        ),
      ),
    );
  }
}
