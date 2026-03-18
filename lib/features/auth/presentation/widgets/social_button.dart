import 'package:flutter/material.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';

class SocialButton extends StatelessWidget {
  final String title;

  const SocialButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.paddingM),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        color: Theme.of(context).inputDecorationTheme.fillColor,
      ),
      child: Center(child: Text(title)),
    );
  }
}
