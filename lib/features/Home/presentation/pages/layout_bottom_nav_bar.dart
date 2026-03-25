import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:lux_estate/core/router/destinations.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';

class LayoutBottomNavBar extends StatelessWidget {
  const LayoutBottomNavBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarVisibilityCubit, bool>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is UserScrollNotification) {
                if (notification.direction == ScrollDirection.reverse) {
                  // scrolling down
                  context.read<NavbarVisibilityCubit>().show();
                } else if (notification.direction == ScrollDirection.forward) {
                  // scrolling up
                  context.read<NavbarVisibilityCubit>().hide();
                }
              }
              return true;
            },
            child: Stack(
              children: [
                navigationShell,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _SlidingNavBarWidget(navigationShell),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SlidingNavBarWidget extends StatelessWidget {
  const _SlidingNavBarWidget(this.navigationShell);
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarVisibilityCubit, bool>(
      builder: (context, isVisible) {
        return AnimatedSlide(
          // Offset(0, 1.5) pushes it completely off-screen (bottom)
          // Offset(0, -0.2) slides it up into view with a little bottom margin
          offset: isVisible
              ? const Offset(0, 0) // visible (normal position)
              : const Offset(0, 1.5), // hidden (below screen)
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          child: _navBar(),
        );
      },
    );
  }

  Widget _navBar() {
    return Container(
      padding: EdgeInsets.only(
        left: AppSizes.paddingS.w,
        right: AppSizes.paddingS.w,
        top: AppSizes.paddingXS.h,
        bottom: AppSizes.paddingXS.h,
      ),
      margin: EdgeInsets.fromLTRB(
        8.w,
        16.h,
        8.w,
        16.h,
      ), // Creates the floating effect

      height: 75.h,
      decoration: BoxDecoration(
        color: AppColors.primary, // Deep Navy from your image
        borderRadius: BorderRadius.circular(40.r), // Pill shape
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 20.r,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: appDestinations.asMap().entries.map((entry) {
          int index = entry.key;
          var d = entry.value;
          bool isSelected = navigationShell.currentIndex == index;

          return GestureDetector(
            onTap: () => navigationShell.goBranch(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              decoration: BoxDecoration(
                // The oval indicator for the active item
                color: isSelected
                    ? AppColors.backgroundWhite.withOpacity(0.15)
                    : AppColors.transparent,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected ? d.selectedIcon : d.unSelectedIcon,
                    color: AppColors.backgroundWhite,
                    size: 24.sp,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    d.label.toUpperCase(),
                    style: TextStyle(
                      color: AppColors.backgroundWhite,
                      fontSize: 10.sp,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
