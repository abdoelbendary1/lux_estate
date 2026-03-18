import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          Icons.language,
          size: AppSizes.iconS,
          color: theme.colorScheme.secondary,
        ),
        AppSizes.paddingXS.horizontalSpace,
        Text(
          'ENGLISH',
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(color: theme.colorScheme.secondary),
        ),
      ],
    );
  }
}
