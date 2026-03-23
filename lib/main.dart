import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:lux_estate/core/cubits/user_session/session_cubit.dart';
import 'package:lux_estate/core/di/injection.dart';
import 'package:lux_estate/core/router/app_router.dart';
import 'package:lux_estate/core/secrets/supabase_keys.dart';
import 'package:lux_estate/core/theme/theme.dart';
import 'package:lux_estate/features/Home/presentation/bloc/home_bloc.dart';
import 'package:lux_estate/features/auth/presentation/controller/bloc/auth_bloc.dart';
import 'package:lux_estate/core/cubits/obsecure_password/obsecure_password_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  await configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<SessionCubit>()..initializeSession(),
        ),
        BlocProvider(create: (context) => getIt<ObsecurePasswordCubit>()),
        BlocProvider(
          create: (context) => getIt<HomeBloc>(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => getIt<NavbarVisibilityCubit>(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(
      WidgetsBinding.instance.window,
    );

    return ScreenUtilInit(
      designSize: Size(
        mediaQuery.size.width,
        mediaQuery.size.height,
      ), // same as your design (Figma)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp.router(
        routerConfig: getIt<AppRouter>().router,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
