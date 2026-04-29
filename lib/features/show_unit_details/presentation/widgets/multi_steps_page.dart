import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/show_unit_details/presentation/widgets/step_Two_booking.dart';
import 'package:lux_estate/features/show_unit_details/presentation/widgets/step_one_booking.dart';
import 'package:lux_estate/features/show_unit_details/presentation/widgets/step_three_booking.dart';

class MultiStepForm extends StatefulWidget {
  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _movePage(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Your Space')),
      body: Column(
        children: [
          // This stays active and holds its value during transitions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Step ${_currentIndex + 1} of 3",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "${((_currentIndex + 1) / 3 * 100).round()}% Complete",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ).pOnly(
            s: AppSizes.paddingM,
            e: AppSizes.paddingM,
            t: AppSizes.paddingM,
            b: AppSizes.paddingS,
          ),
          LinearProgressIndicator(
            value: (_currentIndex + 1) / 3,
            borderRadius: BorderRadius.circular(20.r),
            backgroundColor: Colors.grey[200],
            color: AppColors.primary,
          ).ph(AppSizes.paddingM),

          Expanded(
            child: PageView(
              controller: _pageController,
              physics:
                  NeverScrollableScrollPhysics(), // Prevent accidental swipes
              children: [
                StepOneBooking(onNext: () => _movePage(1)),
                StepTwoBooking(onNext: () => _movePage(2)),
                StepThreeBooking(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
