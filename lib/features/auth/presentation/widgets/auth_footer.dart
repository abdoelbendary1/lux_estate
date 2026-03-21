import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/auth/presentation/pages/register_page.dart';
import 'package:lux_estate/features/auth/presentation/widgets/social_button.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key, this.title, this.onTap, this.actionTitle});
  final String? title;
  final VoidCallback? onTap;
  final String? actionTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        // Row(
        //   children: [
        //     const Expanded(child: Divider()),
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
        //       child: Text('OR CONTINUE WITH', style: theme.textTheme.bodySmall),
        //     ),
        //     const Expanded(child: Divider()),
        //   ],
        // ),

        // AppSizes.spaceM.verticalSpace,

        // /// Social Buttons
        // Row(
        //   children: const [
        //     Expanded(child: SocialButton(title: 'Google')),
        //     SizedBox(width: 12),
        //     Expanded(child: SocialButton(title: 'Apple')),
        //   ],
        // ),
        AppSizes.spaceL.verticalSpace,

        /// Create Account
        GestureDetector(
          onTap: onTap,
          child: Center(
            child: RichText(
              text: TextSpan(
                text: title ?? 'Don\'t have an account? ',
                style: theme.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: actionTitle ?? 'Create account',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
