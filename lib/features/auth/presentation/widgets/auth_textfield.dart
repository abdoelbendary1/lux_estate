import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  const AuthTextField({
    super.key,
    required this.label,
    required this.focusNode,
    required this.controller,
    required this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 12.sp,
            color: AppColors.grey, //Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(height: 4.h),
        TextFormField(
          onFieldSubmitted: onFieldSubmitted,
          focusNode: focusNode,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
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
