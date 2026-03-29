import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/utils/filter_chip.dart';
import 'package:lux_estate/features/search/presentation/bloc/filter/filter_cubit.dart';

class PropertyFilterDialog extends StatelessWidget {
  const PropertyFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // The Glass effect
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28.r),
          ),
          child: BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),

                  // SizedBox(height: 24.h),
                  _buildSectionTitle("Accommodation Type"),
                  _buildChipRow(
                    ["All", "Shared Room", "Private Room"],
                    state.accommodationType,
                    (val) =>
                        context.read<FilterBloc>().updateAccommodation(val),
                  ),

                  _buildSectionTitle("Property Style"),
                  _buildChipRow(
                    ["Apartment", "Villa", "Penthouse", "Townhouse"],
                    state.propertyStyle,
                    (val) => context.read<FilterBloc>().updateProperty(val),
                  ),

                  _buildSectionTitle("Gender Policy"),
                  _buildChipRow(
                    ["Any", "Male", "Female"],
                    state.genderPolicy,
                    (val) => context.read<FilterBloc>().updateGender(val),
                  ),

                  SizedBox(height: 32.h),
                  _buildFooter(context),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, top: 16.h),
      child: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildChipRow(
    List<String> options,
    String selectedValue,
    Function(String) onSelected,
  ) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: options.map((option) {
        return AppFilterChip(
          displayName: option,
          isSelected: selectedValue == option,
          onSelected: (_) => onSelected(option),
        );
      }).toList(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
        Text(
          "Filters",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () => context.read<FilterBloc>().reset(),
          child: const Text("Reset", style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () => context.read<FilterBloc>().reset(),
          child: const Text("Clear All", style: TextStyle(color: Colors.grey)),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Apply Filters",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
