import 'package:flutter/material.dart';
import 'package:lux_estate/features/Home/presentation/pages/home_screen.dart';
import 'package:lux_estate/features/auth/presentation/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final session = snapshot.data?.session;
          if (session == null) {
            return LoginScreen();
          } else {
            return HomeScreen();
          }
        },
      ),
    );
  }
}
