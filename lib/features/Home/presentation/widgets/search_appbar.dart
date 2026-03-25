// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';

class SearchSection extends StatelessWidget {
  final bool? _enabled;

  final Function(String)? _onSubmitted;

  final VoidCallback? _onSearchTapped;

  final VoidCallback? _onFilterTapped;

  final bool autoFocus;
  const SearchSection({
    super.key,
    bool? enabled = true,
    Function(String)? onSubmitted,
    VoidCallback? onSearchTapped,
    VoidCallback? onFilterTapped,
    this.autoFocus = false,
  }) : _onSubmitted = onSubmitted,
       _onSearchTapped = onSearchTapped,
       _onFilterTapped = onFilterTapped,
       _enabled = enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSizes.paddingM.w,
        right: AppSizes.paddingM.w,
        top: AppSizes.paddingM.h,
        bottom: AppSizes.paddingXS.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _onSearchTapped,
              child: TextField(
                autofocus: autoFocus,
                enabled: _enabled,
                onSubmitted: _onSubmitted,
                cursorColor: AppColors.primary,
                style: TextStyle(color: AppColors.primary),

                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                  hintText: "Search your dream residence...",
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.primary.withOpacity(0.7),
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: Icon(Icons.tune, color: Colors.white),
              onPressed: _onFilterTapped,
            ),
          ),
        ],
      ),
    );
  }
}
