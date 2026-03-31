import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';

class AppTheme {
  static const String englishFont = 'Cairo';
  static const String arabicFont = 'Cairo';

  /// --- Shared Typography Logic ---
  /// ضفنا الـ isArabic هنا عشان نطبق الـ Font المناسب لكل ستايل
  static TextTheme _buildTextTheme(Brightness brightness, bool isArabic) {
    Color textColor = brightness == Brightness.light
        ? AppColors.primary
        : AppColors.textWhite;
    Color subTextColor = brightness == Brightness.light
        ? Colors.grey[600]!
        : Colors.grey[400]!;
    String fontFamily = isArabic ? arabicFont : englishFont;

    return TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: textColor,
        fontFamily: fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: textColor,
        fontFamily: fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
        fontFamily: fontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: textColor,
        fontFamily: fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: textColor,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: subTextColor,
        fontFamily: fontFamily,
      ),
      labelMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: subTextColor,
        fontFamily: fontFamily,
      ),
    );
  }

  /// --- Light Theme Configuration ---
  static ThemeData getLightTheme(Locale locale) {
    final isArabic = locale.languageCode == 'ar';
    final currentFont = isArabic ? arabicFont : englishFont;

    return ThemeData(
      tabBarTheme: TabBarThemeData(
        dividerColor: AppColors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: AppColors.primary, // Matches your "Apartments" chip color
          borderRadius: BorderRadius.circular(15.r),
        ),
        labelColor: AppColors.backgroundWhite,
        unselectedLabelColor: AppColors.primary,
      ),
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundWhite,
      fontFamily: currentFont,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.backgroundWhite,
        secondary: AppColors.secondary,
        onSecondary: AppColors.textWhite,
        error: AppColors.error,
        surface: AppColors.backgroundWhite,
        onSurface: AppColors.black,
      ),

      textTheme: _buildTextTheme(Brightness.light, isArabic),

      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.backgroundWhite,
        foregroundColor: AppColors.black,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          fontFamily: currentFont,
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.grey.withOpacity(0.1),
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          fontFamily: currentFont,
        ),
        secondaryLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textWhite,
          fontFamily: currentFont,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        side: BorderSide.none,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: currentFont,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xffF6F6F6),
        // استخدمنا Directional عشان الـ Padding يقلب لوحده في العربي
        contentPadding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14.sp,
          fontFamily: currentFont,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
      ),
    );
  }

  /// --- Dark Theme Configuration ---
  static ThemeData getDarkTheme(Locale locale) {
    final isArabic = locale.languageCode == 'ar';
    final currentFont = isArabic ? arabicFont : englishFont;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: const Color(0xFF0F0F0F),
      fontFamily: currentFont,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.textWhite,
        secondary: AppColors.secondary,
        onSecondary: AppColors.textWhite,
        error: Colors.red,
        surface: Color(0xFF1A1A1A),
        onSurface: AppColors.textWhite,
      ),

      textTheme: _buildTextTheme(Brightness.dark, isArabic),

      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.textWhite,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          fontFamily: currentFont,
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF2A2A2A),
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textWhite,
          fontFamily: currentFont,
        ),
        secondaryLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textWhite,
          fontFamily: currentFont,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        side: BorderSide.none,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: currentFont,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.black,
        contentPadding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 14.sp,
          fontFamily: currentFont,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
      ),
    );
  }
}
