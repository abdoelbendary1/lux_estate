import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/constants.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppAssetsPath.logo, // <-- your logo
          height: AppSizes.iconXXL,
          width: AppSizes.iconXXL,
        ),
        // AppSizes.paddingS.horizontalSpace,
        // Text('LuxEstate', style: theme.textTheme.headlineLarge),
      ],
    );
  }
}
