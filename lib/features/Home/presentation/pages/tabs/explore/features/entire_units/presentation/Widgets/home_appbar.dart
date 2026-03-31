import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/cubits/locale/locale_cubit.dart';
import 'package:lux_estate/core/cubits/user_session/session_cubit.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the theme once for cleaner code
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.welcome_back.tr(),
                  style: textTheme.labelMedium!.copyWith(fontSize: 14.sp),
                ),
                AppSizes.spaceXS.verticalSpace,
                BlocBuilder<SessionCubit, SessionState>(
                  builder: (context, state) {
                    if (state is SessionAuthenticated) {
                      final user = state.user;
                      return Text(
                        "${LocaleKeys.good_morning.tr()} ${user.fullName}",
                        style: textTheme.titleMedium,
                      );
                    } else {
                      return Text(
                        "${LocaleKeys.good_morning.tr()} Guest",
                        textAlign: TextAlign.start,
                        style: textTheme.titleMedium,
                      );
                    }
                  },
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () => context.pushNamed(AppRoutes.searchScreenName),
              icon: Icon(
                Icons.search,
                size: AppSizes.iconL.r,
                // Uses primary color from the active theme scheme
                color: colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<LocaleCubit>().toggleLanguage(context);
              },
              icon: Icon(
                Icons.language,
                size: AppSizes.iconL.r,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    ).p();
  }
}
