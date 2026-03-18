import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/presentation/pages/home_screen.dart';
import 'package:lux_estate/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:lux_estate/features/auth/presentation/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  static get route => MaterialPageRoute(builder: (_) => RegisterScreen());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceImpl();
  Future<void> _signUp(BuildContext context) async {
    try {
      final response = await authRemoteDataSource.signUp(
        email: emailController.text,
        password: passwordController.text,
        fullName: fullNameController.text,
      );
      // if (response.user == null) {
      //   throw Exception('Sign-up failed: No user returned');
      // } else if (response.user != null) {
      //   // Sign-up successful, navigate to home screen
      //   Navigator.push(context, HomeScreen.route);
      // }
      // Handle successful sign-up
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Sign-up successful!')));
    } catch (e) {
      // Handle sign-up error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Sign-up failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.paddingL,
            vertical: AppSizes.paddingL,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LoginBanner(theme: theme),
                AppSizes.spaceS.verticalSpace,

                /// Title
                SignupForm(
                  theme: theme,
                  emailController: emailController,
                  passwordController: passwordController,
                  fullNameController: fullNameController,
                  confirmPasswordController: confirmPasswordController,
                  onTap: () => _signUp(context),
                ),

                AppSizes.spaceL.verticalSpace,

                /// Footer
              ],
            ),
          ),
        ),
      ),
    );
  }
}
