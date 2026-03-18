import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:lux_estate/features/auth/presentation/pages/login_page.dart';
import 'package:lux_estate/features/auth/presentation/widgets/auth_pass_textfield.dart';
import 'package:lux_estate/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:lux_estate/features/auth/presentation/widgets/auth_footer.dart';
import 'package:lux_estate/features/auth/presentation/widgets/social_button.dart';

class SignupForm extends StatelessWidget {
  SignupForm({
    super.key,
    required this.theme,
    required this.emailController,
    required this.passwordController,
    required this.fullNameController,
    required this.confirmPasswordController,
    this.onTap,
  });
  final TextEditingController fullNameController;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  VoidCallback? onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Text('Create account', style: theme.textTheme.headlineLarge),
        AppSizes.spaceXS.verticalSpace,
        Text(
          'Start your journey in architectural excellence.',
          style: theme.textTheme.bodyMedium,
        ),

        AppSizes.spaceL.verticalSpace,

        /// Full Name
        AuthTextField(
          label: 'FULL NAME',
          hint: 'John Doe',
          controller: fullNameController,
        ),

        AppSizes.spaceS.verticalSpace,

        /// Email
        AuthTextField(
          label: 'EMAIL ADDRESS',
          hint: 'name@domain.com',
          controller: emailController,
        ),

        AppSizes.spaceS.verticalSpace,

        /// Password
        AppPasswordField(controller: passwordController),

        AppSizes.spaceS.verticalSpace,

        /// Confirm Password
        AppPasswordField(
          controller: confirmPasswordController,
          label: 'CONFIRM PASSWORD',
        ),

        AppSizes.spaceM.verticalSpace,

        /// Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Create Account'),
                8.horizontalSpace,
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),

        AppSizes.spaceL.verticalSpace,

        AuthFooter(
          actionTitle: "Login",
          onTap: () {
            Navigator.of(context).push(LoginScreen.route);
          },
          title: "Already have an account? ",
        ),
      ],
    );
  }
}
