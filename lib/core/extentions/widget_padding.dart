import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';

extension WidgetSpacingExtension on Widget {
  /// --- Padding (الداخلي) ---

  // بادنج شامل من كل الجهات (القيمة الافتراضية 16)
  Widget p([double? value]) => Padding(
    padding: EdgeInsetsDirectional.all((value ?? AppSizes.paddingL).r),
    child: this,
  );

  // بادنج أفقي (Horizontal)
  Widget ph([double? value]) => Padding(
    padding: EdgeInsetsDirectional.symmetric(
      horizontal: (value ?? AppSizes.paddingM).w,
    ),
    child: this,
  );

  // بادنج رأسي (Vertical)
  Widget pv([double? value]) => Padding(
    padding: EdgeInsetsDirectional.symmetric(
      vertical: (value ?? AppSizes.paddingM).h,
    ),
    child: this,
  );

  // بادنج مخصص (Directional) لضمان الـ RTL
  Widget pOnly({double s = 0, double e = 0, double t = 0, double b = 0}) =>
      Padding(
        padding: EdgeInsetsDirectional.only(
          start: s.w,
          end: e.w,
          top: t.h,
          bottom: b.h,
        ),
        child: this,
      );

  /// --- Margin (الخارجي) ---

  // مارجن شامل (القيمة الافتراضية 16)
  Widget m([double? value]) => Container(
    margin: EdgeInsetsDirectional.all((value ?? AppSizes.paddingM).r),
    child: this,
  );

  // مارجن أفقي
  Widget mh([double? value]) => Container(
    margin: EdgeInsetsDirectional.symmetric(
      horizontal: (value ?? AppSizes.paddingM).w,
    ),
    child: this,
  );

  // مارجن رأسي
  Widget mv([double? value]) => Container(
    margin: EdgeInsetsDirectional.symmetric(
      vertical: (value ?? AppSizes.paddingM).h,
    ),
    child: this,
  );

  // مارجن مخصص (Directional)
  Widget mOnly({double s = 0, double e = 0, double t = 0, double b = 0}) =>
      Container(
        margin: EdgeInsetsDirectional.only(
          start: s.w,
          end: e.w,
          top: t.h,
          bottom: b.h,
        ),
        child: this,
      );
}
