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
import 'package:lux_estate/core/cubits/locale/locale_cubit.dart' as _i1002;
import 'package:lux_estate/core/cubits/obsecure_password/obsecure_password_cubit.dart'
    as _i674;
import 'package:lux_estate/core/cubits/swipe_card_animation/cubit/swipe_cards_animation_cubit.dart'
    as _i186;
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
import 'package:lux_estate/features/Home/data/datasource/home_page_remote_data_source.dart'
    as _i413;
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
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/bloc/nearbyUnits/nearby_units_bloc.dart'
    as _i310;
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/bloc/recentlyAdded/recently_added_units_bloc.dart'
    as _i1065;
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/recommended/recomended_units/recommended_units_bloc.dart'
    as _i263;
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/data/data_source/profile_remote_data_source.dart'
    as _i1059;
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/data/repo_impl/profile_repo_impl.dart'
    as _i872;
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/domain/repo/profile_repo.dart'
    as _i58;
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/domain/usecase/get_profile.dart'
    as _i688;
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/presentation/bloc/profile_bloc.dart'
    as _i458;
import 'package:lux_estate/features/search/data/repo_impl/search_repo_impl.dart'
    as _i648;
import 'package:lux_estate/features/search/domain/repo/search_repo.dart'
    as _i857;
import 'package:lux_estate/features/search/domain/usecase/search_property.dart'
    as _i330;
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
    gh.factory<_i1002.LocaleCubit>(() => _i1002.LocaleCubit());
    gh.factory<_i674.ObsecurePasswordCubit>(
      () => _i674.ObsecurePasswordCubit(),
    );
    gh.factory<_i186.SwipeCardsAnimationCubit>(
      () => _i186.SwipeCardsAnimationCubit(),
    );
    gh.factory<_i320.FilterBloc>(() => _i320.FilterBloc());
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i1059.ProfileRemoteDataSource>(
      () => _i1059.ProfileRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i272.HomePageMockupDataSource>(
      () => _i272.HomePageMockupDataSourceImpl(),
    );
    gh.lazySingleton<_i58.ProfileRepo>(
      () => _i872.ProfileRepoImpl(gh<_i1059.ProfileRemoteDataSource>()),
    );
    gh.lazySingleton<_i1010.AuthRemoteDataSource>(
      () => _i1010.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i413.HomePageRemoteDataSource>(
      () => _i413.HomePageRemoteDataSourceImpl(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i942.AuthRepository>(
      () => _i939.AuthRepoImpl(gh<_i1010.AuthRemoteDataSource>()),
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
    gh.lazySingleton<_i857.SearchRepo>(
      () => _i648.SearchRepoImpl(
        remoteDataSource: gh<_i413.HomePageRemoteDataSource>(),
      ),
    );
    gh.factory<_i688.GetProfile>(
      () => _i688.GetProfile(gh<_i58.ProfileRepo>()),
    );
    gh.factory<_i458.ProfileBloc>(
      () => _i458.ProfileBloc(getProfileUseCase: gh<_i688.GetProfile>()),
    );
    gh.lazySingleton<_i499.HomePageRepository>(
      () => _i551.HomePageRepoImpl(
        mockupDataSource: gh<_i272.HomePageMockupDataSource>(),
        remoteDataSource: gh<_i413.HomePageRemoteDataSource>(),
      ),
    );
    gh.factory<_i545.UserLogin>(
      () => _i545.UserLogin(authRepository: gh<_i942.AuthRepository>()),
    );
    gh.singleton<_i775.SessionCubit>(
      () => _i775.SessionCubit(gh<_i559.CurrentUser>()),
    );
    gh.factory<_i330.SearchProperty>(
      () => _i330.SearchProperty(searchRepo: gh<_i857.SearchRepo>()),
    );
    gh.factory<_i321.AuthBloc>(
      () => _i321.AuthBloc(
        userLogin: gh<_i545.UserLogin>(),
        userSignUp: gh<_i436.UserSignUp>(),
        currentUser: gh<_i559.CurrentUser>(),
        logoutUser: gh<_i534.LogoutUser>(),
      ),
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
    gh.factory<_i1065.RecentlyAddedUnitsBloc>(
      () => _i1065.RecentlyAddedUnitsBloc(
        getRecentUnits: gh<_i508.GetRecentUnits>(),
      ),
    );
    gh.singleton<_i1020.AppRouter>(
      () => _i1020.AppRouter(gh<_i775.SessionCubit>()),
    );
    gh.factory<_i647.SearchBloc>(
      () => _i647.SearchBloc(searchProperty: gh<_i330.SearchProperty>()),
    );
    gh.factory<_i310.NearbyUnitsBloc>(
      () => _i310.NearbyUnitsBloc(getNearbyUntits: gh<_i250.GetNearbyUntits>()),
    );
    gh.factory<_i263.RecommendedUnitsBloc>(
      () => _i263.RecommendedUnitsBloc(gh<_i713.GetUnitsByCategory>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i14.RegisterModule {}
