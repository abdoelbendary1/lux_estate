import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/presentation/widgets/filter_chip.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  // 1. Manage State for Selection
  PropertyCategories selectedCategory = PropertyCategories.villa;
  final List<PropertyCategories> _categories = PropertyCategories.values
      .toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSizes.paddingM.w,
        right: AppSizes.paddingM.w,
        top: AppSizes.paddingM.h,
        bottom: AppSizes.paddingXS.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h, // Define the constraint for the horizontal list
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              // Perfect spacing match
              separatorBuilder: (context, index) =>
                  AppSizes.spaceS.horizontalSpace,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == selectedCategory;

                return AppFilterChip(
                  isSelected: isSelected,
                  displayName: category.displayName,
                  onSelected: (bool selected) {
                    setState(() {
                      // Change which is selected
                      selectedCategory = category;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
