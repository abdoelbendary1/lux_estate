import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/auth/presentation/pages/register_page.dart';
import 'package:lux_estate/features/auth/presentation/widgets/auth_action_button.dart';
import 'package:lux_estate/features/auth/presentation/widgets/auth_pass_textfield.dart';
import 'package:lux_estate/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:lux_estate/features/auth/presentation/widgets/auth_footer.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    super.key,
    required this.theme,
    required this.emailController,
    required this.passwordController,
    this.onPressed,
  });
  VoidCallback? onPressed;
  final ThemeData theme;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome back', style: theme.textTheme.headlineLarge),
        AppSizes.spaceXS.verticalSpace,
        Text(
          'Continue your journey in architectural excellence.',
          style: theme.textTheme.bodyMedium,
        ),

        AppSizes.spaceL.verticalSpace,

        /// Email
        AuthTextField(
          label: 'EMAIL ADDRESS',
          hint: 'name@domain.com',
          controller: emailController,
        ),

        AppSizes.spaceS.verticalSpace,

        /// Password
        AppPasswordField(controller: passwordController),

        AppSizes.spaceM.verticalSpace,

        /// Button
        AuthActionButton(title: 'Login', onPressed: onPressed),

        AppSizes.spaceL.verticalSpace,

        /// Divider
        AuthFooter(
          title: "New to LuxEstate? ",
          actionTitle: "Create account",
          onTap: () {
            Navigator.of(context).push(RegisterScreen.route);
          },
        ),
      ],
    );
  }
}
