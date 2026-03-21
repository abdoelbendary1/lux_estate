import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lux_estate/core/cubits/user_session/session_cubit.dart';
import 'package:lux_estate/features/Home/presentation/bloc/home_bloc.dart';
import 'package:lux_estate/features/auth/presentation/controller/bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              // Trigger logout through AuthBloc
              context.read<AuthBloc>().add(UserLogoutEvent());
              // GoRouter will automatically kick the user to Login
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      // Use BlocBuilder to get the user from the global SessionCubit
      body: BlocBuilder<SessionCubit, SessionState>(
        builder: (context, sessionState) {
          if (sessionState is SessionAuthenticated) {
            final user = sessionState.user;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${user.fullName}!'),
                  const SizedBox(height: 20),

                  // Now add your Home-specific Bloc here
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, homeState) {
                      if (homeState is HomeLoading) {
                        return const CircularProgressIndicator();
                      }
                      // Display home specific data...
                      return const Text("Your estate listings go here");
                    },
                  ),
                ],
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
