import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/app_button.dart';
import 'package:table_calendar/table_calendar.dart';

class StepOneBooking extends StatefulWidget {
  StepOneBooking({super.key, this.onNext});
  VoidCallback? onNext;

  @override
  State<StepOneBooking> createState() => _StepOneBookingState();
}

class _StepOneBookingState extends State<StepOneBooking> {
  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Move-in Date",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay =
                    selectedDay; // Hold this value in your BLoC or Parent
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.rectangle,
                // borderRadius: BorderRadius.circular(8),
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.secondary,
              ), // Clean look
              defaultTextStyle: TextStyle(color: AppColors.primary),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false, // Hide the "2 weeks/month" toggle
              titleCentered: true,
            ),
          ),
          Text(
            "Selected Lease Duration",
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ).pOnly(b: AppSizes.paddingM, t: AppSizes.paddingM),
          DropdownButtonFormField<String>(
            value: '12 Months',
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: BorderSide.none,
              // ),
            ),
            items: ['6 Months', '12 Months', '24 Months']
                .map(
                  (label) => DropdownMenuItem(child: Text(label), value: label),
                )
                .toList(),
            onChanged: (value) {
              // Update your BLoC state here
            },
          ),
          Spacer(),
          BuildAppButton(onTap: widget.onNext, actionText: "Next"),
          AppSizes.spaceL.verticalSpace,
        ],
      ).p(AppSizes.paddingM),
    );
  }
}
