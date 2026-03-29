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
import 'package:lux_estate/core/cubits/bottom_navbar/bottom_navbar_cubit.dart'
    as _i290;
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
import 'package:lux_estate/features/auth/domain/usecase/logout_user.dart'
    as _i534;
import 'package:lux_estate/features/auth/domain/usecase/user_login.dart'
    as _i545;
import 'package:lux_estate/features/auth/domain/usecase/user_sign_up.dart'
    as _i436;
import 'package:lux_estate/features/auth/presentation/controller/bloc/auth_bloc.dart'
    as _i321;
import 'package:lux_estate/features/Home/data/datasource/home_page_mockup_data_source.dart'
    as _i272;
import 'package:lux_estate/features/Home/data/repo_impl/home_page_repo_impl.dart'
    as _i551;
import 'package:lux_estate/features/Home/domain/repo/Home_page_repo.dart'
    as _i499;
import 'package:lux_estate/features/Home/domain/usecase/GetNearbyUntits.dart'
    as _i250;
import 'package:lux_estate/features/Home/domain/usecase/getPropertiesByCategory.dart'
    as _i713;
import 'package:lux_estate/features/Home/domain/usecase/GetRecentUnits.dart'
    as _i508;
import 'package:lux_estate/features/Home/presentation/bloc/nearbyUnits/nearby_units_bloc.dart'
    as _i921;
import 'package:lux_estate/features/Home/presentation/bloc/recentlyAdded/recently_added_units_bloc.dart'
    as _i992;
import 'package:lux_estate/features/Home/presentation/bloc/recomended_units/recommended_units_bloc.dart'
    as _i590;
import 'package:lux_estate/features/search/presentation/bloc/filter/filter_cubit.dart'
    as _i320;
import 'package:lux_estate/features/search/presentation/bloc/search_bloc.dart'
    as _i647;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i290.NavbarVisibilityCubit>(
      () => _i290.NavbarVisibilityCubit(),
    );
    gh.factory<_i674.ObsecurePasswordCubit>(
      () => _i674.ObsecurePasswordCubit(),
    );
    gh.factory<_i320.FilterBloc>(() => _i320.FilterBloc());
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i272.HomePageMockupDataSource>(
      () => _i272.HomePageMockupDataSourceImpl(),
    );
    gh.lazySingleton<_i499.HomePageRepository>(
      () => _i551.HomePageRepoImpl(
        mockupDataSource: gh<_i272.HomePageMockupDataSource>(),
      ),
    );
    gh.lazySingleton<_i1010.AuthRemoteDataSource>(
      () => _i1010.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i250.GetNearbyUntits>(
      () => _i250.GetNearbyUntits(gh<_i499.HomePageRepository>()),
    );
    gh.factory<_i508.GetRecentUnits>(
      () => _i508.GetRecentUnits(gh<_i499.HomePageRepository>()),
    );
    gh.factory<_i713.GetUnitsByCategory>(
      () => _i713.GetUnitsByCategory(gh<_i499.HomePageRepository>()),
    );
    gh.lazySingleton<_i942.AuthRepository>(
      () => _i939.AuthRepoImpl(gh<_i1010.AuthRemoteDataSource>()),
    );
    gh.factory<_i590.RecommendedUnitsBloc>(
      () => _i590.RecommendedUnitsBloc(gh<_i713.GetUnitsByCategory>()),
    );
    gh.factory<_i559.CurrentUser>(
      () => _i559.CurrentUser(gh<_i942.AuthRepository>()),
    );
    gh.factory<_i534.LogoutUser>(
      () => _i534.LogoutUser(gh<_i942.AuthRepository>()),
    );
    gh.factory<_i436.UserSignUp>(
      () => _i436.UserSignUp(gh<_i942.AuthRepository>()),
    );
    gh.factory<_i647.SearchBloc>(
      () =>
          _i647.SearchBloc(getUnitsByCategory: gh<_i713.GetUnitsByCategory>()),
    );
    gh.factory<_i545.UserLogin>(
      () => _i545.UserLogin(authRepository: gh<_i942.AuthRepository>()),
    );
    gh.factory<_i992.RecentlyAddedUnitsBloc>(
      () => _i992.RecentlyAddedUnitsBloc(
        getRecentUnits: gh<_i508.GetRecentUnits>(),
      ),
    );
    gh.singleton<_i775.SessionCubit>(
      () => _i775.SessionCubit(gh<_i559.CurrentUser>()),
    );
    gh.factory<_i921.NearbyUnitsBloc>(
      () => _i921.NearbyUnitsBloc(getNearbyUntits: gh<_i250.GetNearbyUntits>()),
    );
    gh.factory<_i321.AuthBloc>(
      () => _i321.AuthBloc(
        userLogin: gh<_i545.UserLogin>(),
        userSignUp: gh<_i436.UserSignUp>(),
        currentUser: gh<_i559.CurrentUser>(),
        logoutUser: gh<_i534.LogoutUser>(),
      ),
    );
    gh.singleton<_i1020.AppRouter>(
      () => _i1020.AppRouter(gh<_i775.SessionCubit>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i14.RegisterModule {}
