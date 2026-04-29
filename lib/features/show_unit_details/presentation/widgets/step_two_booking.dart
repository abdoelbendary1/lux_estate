import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/app_button.dart';

class StepTwoBooking extends StatelessWidget {
  StepTwoBooking({super.key, this.onNext});
  VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),

          Text("Step 2: Enter your details"),
          Spacer(),
          BuildAppButton(
            onTap: onNext,
            actionText: "Next",
          ).p(AppSizes.paddingM),
          AppSizes.spaceL.verticalSpace,
        ],
      ),
    );
  }
}
