import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/validators/app_validators.dart';
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
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back',
          style: theme.textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontXXL.sp,
          ),
        ),
        AppSizes.spaceXS.verticalSpace,
        Text(
          'Continue your journey in architectural excellence.',
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: AppSizes.fontM.sp,
          ),
        ),

        AppSizes.spaceL.verticalSpace,

        /// Email
        AuthTextField(
          label: 'EMAIL ADDRESS',
          controller: emailController,
          validator: (value) => AppValidators.emailValidator(value),
          focusNode: emailFocusNode,
          onFieldSubmitted: (_) => passwordFocusNode.requestFocus(),
        ),

        AppSizes.spaceL.verticalSpace,

        /// Password
        AppPasswordField(
          controller: passwordController,
          validator: (value) => AppValidators.passwordValidator(value),
          focusNode: passwordFocusNode,
          onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
        ),

        AppSizes.spaceM.verticalSpace,

        /// Button
        AuthActionButton(title: 'Login', onPressed: onPressed),

        AppSizes.spaceL.verticalSpace,

        /// Divider
        AuthFooter(
          title: "New to LuxEstate? ",
          actionTitle: "Create account",
          onTap: () {
            // ✅ This works regardless of nesting
            context.pushNamed(AppRoutes.registerName);
          },
        ),
      ],
    );
  }
}
