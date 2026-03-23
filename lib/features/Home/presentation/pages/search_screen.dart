import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/cubits/user_session/session_cubit.dart';
import 'package:lux_estate/features/Home/presentation/widgets/category_section.dart';
import 'package:lux_estate/features/Home/presentation/widgets/featured_properties.dart';
import 'package:lux_estate/features/Home/presentation/widgets/home_appbar.dart';
import 'package:lux_estate/features/Home/presentation/widgets/nearby_section.dart';
import 'package:lux_estate/features/Home/presentation/widgets/recently_added.dart';
import 'package:lux_estate/features/Home/presentation/widgets/recommended_swipe_card.dart';
import 'package:lux_estate/features/Home/presentation/widgets/search_section.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use BlocBuilder to get the user from the global SessionCubit
      body: BlocBuilder<SessionCubit, SessionState>(
        builder: (context, sessionState) {
          if (sessionState is SessionAuthenticated) {
            final user = sessionState.user;

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsGeometry.only(
                    // left: AppSizes.paddingXS.w,
                    // right: AppSizes.paddingXS.w,
                    // top: AppSizes.paddingXS.h,
                    // bottom: AppSizes.paddingXS.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FeaturedPropertiesSection(),
                      NearbySection(),
                      // CallSupportCard(),
                      100.h.verticalSpace,
                    ],
                  ),
                ),
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
