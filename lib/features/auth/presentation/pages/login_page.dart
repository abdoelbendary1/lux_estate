import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/cubits/user_session/session_cubit.dart';
import 'package:lux_estate/core/enums/notify_user_enum.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/notify_user.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/explore.dart';
import 'package:lux_estate/features/auth/presentation/controller/bloc/auth_bloc.dart';
import 'package:lux_estate/features/auth/presentation/widgets/login_banner.dart';
import 'package:lux_estate/features/auth/presentation/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static MaterialPageRoute<dynamic> get route => MaterialPageRoute(builder: (_) => LoginScreen());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              // 1. UPDATE THE SESSION (This triggers GoRouter auto-navigation)
              context.read<SessionCubit>().updateSession(state.user);
              notifyUser(
                context,
                message: 'Login successful!',
                title: 'Success',
                type: NotifyUserType.success,
              );
            } else if (state is AuthFailure) {
              // Show error message on login failure
              notifyUser(
                context,
                message: ' ${state.message}',
                title: 'Error',
                type: NotifyUserType.error,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoginBanner(theme: theme),
                    AppSizes.spaceXS.verticalSpace,

                    /// Title
                    LoginForm(
                      theme: theme,
                      emailController: emailController,
                      passwordController: passwordController,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Perform login action
                          context.read<AuthBloc>().add(
                            UserLoginEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                    ),

                    /// Footer
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
