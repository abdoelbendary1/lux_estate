// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:lux_estate/core/cubits/obsecure_password/obsecure_password_cubit.dart'
    as _i674;
import 'package:lux_estate/core/cubits/user_session/session_cubit.dart'
    as _i775;
import 'package:lux_estate/core/di/register_module.dart' as _i14;
import 'package:lux_estate/core/router/app_router.dart' as _i1020;
import 'package:lux_estate/features/auth/data/data_source/auth_remote_data_source.dart'
    as _i1010;
import 'package:lux_estate/features/auth/data/repo/auth_repo_impl.dart'
    as _i939;
import 'package:lux_estate/features/auth/domain/repo/auth_repository.dart'
    as _i942;
import 'package:lux_estate/features/auth/domain/usecase/current_user.dart'
    as _i559;
import 'package:lux_estate/features/auth/domain/usecase/user_login.dart'
    as _i545;
import 'package:lux_estate/features/auth/domain/usecase/user_sign_up.dart'
    as _i436;
import 'package:lux_estate/features/auth/presentation/controller/bloc/auth_bloc.dart'
    as _i321;
import 'package:lux_estate/features/Home/presentation/bloc/home_bloc.dart'
    as _i140;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i674.ObsecurePasswordCubit>(
      () => _i674.ObsecurePasswordCubit(),
    );
    gh.factory<_i140.HomeBloc>(() => _i140.HomeBloc());
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i1010.AuthRemoteDataSource>(
      () => _i1010.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i942.AuthRepository>(
      () => _i939.AuthRepoImpl(gh<_i1010.AuthRemoteDataSource>()),
    );
    gh.factory<_i559.CurrentUser>(
      () => _i559.CurrentUser(gh<_i942.AuthRepository>()),
    );
    gh.factory<_i436.UserSignUp>(
      () => _i436.UserSignUp(gh<_i942.AuthRepository>()),
    );
    gh.factory<_i545.UserLogin>(
      () => _i545.UserLogin(authRepository: gh<_i942.AuthRepository>()),
    );
    gh.factory<_i321.AuthBloc>(
      () => _i321.AuthBloc(
        userLogin: gh<_i545.UserLogin>(),
        userSignUp: gh<_i436.UserSignUp>(),
        currentUser: gh<_i559.CurrentUser>(),
      ),
    );
    gh.singleton<_i775.SessionCubit>(
      () => _i775.SessionCubit(gh<_i559.CurrentUser>()),
    );
    gh.singleton<_i1020.AppRouter>(
      () => _i1020.AppRouter(gh<_i775.SessionCubit>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i14.RegisterModule {}
