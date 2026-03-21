import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/di/injection.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/notify_user.dart';
import 'package:lux_estate/features/Home/presentation/pages/home_screen.dart';
import 'package:lux_estate/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:lux_estate/features/auth/presentation/controller/bloc/auth_bloc.dart';
import 'package:lux_estate/features/auth/presentation/widgets/register_form.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class RegisterScreen extends StatelessWidget {
  static get route => MaterialPageRoute(builder: (_) => RegisterScreen());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceImpl(
    getIt<SupabaseClient>(),
  );

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
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                notifyUser(
                  context,
                  message: 'Registration successful! Please log in.',
                  title: 'Success',
                );
              } else if (state is AuthFailure) {
                // Show error message on registration failure
                notifyUser(context, message: state.message, title: 'Error');
              }
            },
            builder: (context, state) {
              return Form(
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
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            UserSignUpEvent(
                              email: emailController.text,
                              password: passwordController.text,
                              fullName: fullNameController.text,
                            ),
                          );
                        }
                      },
                    ),

                    AppSizes.spaceL.verticalSpace,

                    /// Footer
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
