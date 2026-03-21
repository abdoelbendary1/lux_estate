import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/validators/app_validators.dart';
import 'package:lux_estate/features/auth/presentation/pages/login_page.dart';
import 'package:lux_estate/features/auth/presentation/widgets/auth_pass_textfield.dart';
import 'package:lux_estate/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:lux_estate/features/auth/presentation/widgets/auth_footer.dart';

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
  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

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
          focusNode: fullNameFocusNode,
          onFieldSubmitted: (_) => emailFocusNode.requestFocus(),
          controller: fullNameController,
          validator: (value) => AppValidators.nameValidator(value),
        ),

        AppSizes.spaceS.verticalSpace,

        /// Email
        AuthTextField(
          label: 'EMAIL ADDRESS',
          focusNode: emailFocusNode,
          controller: emailController,
          onFieldSubmitted: (_) => passwordFocusNode.requestFocus(),
          validator: (value) => AppValidators.emailValidator(value),
        ),

        AppSizes.spaceS.verticalSpace,

        /// Password
        AppPasswordField(
          controller: passwordController,
          validator: (value) => AppValidators.passwordValidator(value),
          focusNode: passwordFocusNode,
          onFieldSubmitted: (_) => confirmPasswordFocusNode.requestFocus(),
        ),

        AppSizes.spaceS.verticalSpace,

        /// Confirm Password
        AppPasswordField(
          controller: confirmPasswordController,
          label: 'CONFIRM PASSWORD',
          validator: (value) => AppValidators.confirmPasswordValidator(
            value,
            passwordController.text,
          ),
          focusNode: confirmPasswordFocusNode,
          onFieldSubmitted: (p0) => FocusScope.of(context).unfocus(),
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
