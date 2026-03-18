import 'package:flutter/material.dart';
import 'package:lux_estate/features/auth/data/data_source/auth_remote_data_source.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static get route => MaterialPageRoute(builder: (_) => HomeScreen());
  AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceImpl();
  @override
  Widget build(BuildContext context) {
    final user = authRemoteDataSource.getCurrentUser();
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text(
          textAlign: TextAlign.center,
          'Welcome to the Home Screen , you are logged in!\n ${user.toString()}',
        ),
      ),
    );
  }
}
