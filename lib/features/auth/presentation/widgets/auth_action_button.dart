import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/features/auth/presentation/controller/bloc/auth_bloc.dart';

class AuthActionButton extends StatelessWidget {
  const AuthActionButton({super.key, this.onPressed, required this.title});
  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.read<AuthBloc>().state is AuthLoading;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading ? AppColors.grey : AppColors.primary,
        ),
        onPressed: onPressed,
        child: isLoading
            ? SizedBox(
                height: 18.h,
                width: 18.w,
                child: CircularProgressIndicator(
                  color: AppColors.backgroundWhite,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.backgroundWhite,
                    ),
                  ),
                  8.horizontalSpace,

                  const Icon(Icons.arrow_forward),
                ],
              ),
      ),
    );
  }
}
