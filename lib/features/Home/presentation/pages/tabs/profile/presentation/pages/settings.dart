import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/async/async_view_builder.dart';
import 'package:lux_estate/core/constants.dart';
import 'package:lux_estate/core/cubits/user_session/session_cubit.dart';
import 'package:lux_estate/core/di/injection.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/domain/entity/profile_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/presentation/bloc/profile_bloc.dart';
import 'package:lux_estate/features/auth/presentation/controller/bloc/auth_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()
        ..add(
          FetchProfileEvent(
            (context.read<SessionCubit>().state as SessionAuthenticated)
                .user
                .id!,
          ),
        ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white, // Pure white background

          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    AsyncViewBuilder(
                      onSuccess: (profile) => _buildProfileHeader(profile),
                      loadingWidget: CircularProgressIndicator(),
                      onEmpty: Text('No profile data available'),
                      state: state.asyncState,
                      onRetry: () {
                        if (context.read<SessionCubit>().state
                            is SessionAuthenticated) {
                          final userId =
                              (context.read<SessionCubit>().state
                                      as SessionAuthenticated)
                                  .user
                                  .id;
                          context.read<ProfileBloc>().add(
                            FetchProfileEvent(userId!),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 30.h),
                    _buildStatsAndTierRow(),
                    SizedBox(height: 30.h),
                    _buildAccountSettingsList(context),
                    SizedBox(height: 100.h), // Space at bottom
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ProfileEntity? profile) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 65.r,
              backgroundColor: const Color(0xFF1A237E), // Dark Navy Blue border
              child: CircleAvatar(
                radius: 61.r,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(
                  AppAssetsPath.user,
                ), // Replace with actual avatar URL
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(5.w),
                decoration: const BoxDecoration(
                  color: Color(0xFF1976D2), // Medium Blue edit background
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.edit, color: Colors.white, size: 18.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Text(
          profile?.fullName ?? 'Guest',
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Premium Member since 2022',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBadge(
              'VERIFIED',
              const Color(0xFF9FF4CD),
              const Color(0xFF147D4E),
            ),
            SizedBox(width: 8.w),
            _buildBadge(
              'INVESTOR',
              const Color(0xFFBFE5F9),
              const Color(0xFF0D47A1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildStatsAndTierRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              _buildStatCard(title: 'PROPERTIES\nSAVED', value: '12'),
              SizedBox(width: 12.w),
              _buildStatCard(title: 'TOURS\nBOOKED', value: '4'),
            ],
          ),
          SizedBox(height: 12.h),
          // Black Tier Status Card
          Container(
            padding: EdgeInsets.all(20.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gold',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'TIER STATUS',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400],
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F3FA), // Light Lavender/Grey background
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
                letterSpacing: 0.5,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSettingsList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ACCOUNT SETTINGS',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 15.h),
          _buildSettingsTile(
            icon: Icons.person_outline,
            title: 'Profile Info',
            subtitle: 'Manage your personal details',
          ),
          _buildSettingsTile(
            icon: Icons.notifications_none,
            title: 'Notification Preferences',
            subtitle: 'Control updates and alerts',
          ),
          _buildSettingsTile(
            icon: Icons.lock_open_outlined,
            title: 'Privacy & Security',
            subtitle: 'Passwords and data usage',
          ),
          _buildSettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'FAQs and contact our concierge',
          ),
          SizedBox(height: 10.h),
          // Special Outlined Logout Button
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!, width: 1.w),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: ListTile(
              leading: Icon(Icons.logout_outlined, color: Colors.red[700]),
              title: Text(
                'Logout Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
              ),
              onTap: () {
                context.read<AuthBloc>().add(UserLogoutEvent());

                if (context.read<SessionCubit>().state
                    is SessionUnauthenticated) {
                  context.pushNamed(AppRoutes.loginName);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 1.w),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F0F7),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: const Color(0xFF1A237E)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.sp,
          color: Colors.grey[400],
        ),
        onTap: () {
          // Add navigation logic
        },
      ),
    );
  }
}
