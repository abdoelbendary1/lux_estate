import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/app_button.dart';

class StepThreeBooking extends StatelessWidget {
  StepThreeBooking({super.key, this.onNext});
  VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),

          Text("Step 3: Confirm your booking"),
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
