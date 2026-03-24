import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/presentation/bloc/home_bloc.dart';
import 'package:lux_estate/features/Home/presentation/widgets/filter_chip.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  // 1. Initialize the ScrollController
  final ScrollController _scrollController = ScrollController();
  final List<PropertyCategories> _categories = PropertyCategories.values
      .toList();

  // 2. Function to calculate and perform the scroll
  void _scrollToSelected(int index) {
    if (_scrollController.hasClients) {
      // Approximate width: Chip width + Separator width
      // You may need to adjust '100' based on your actual chip width
      double offset = index * 100.w;

      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      // 3. Listen for state changes to trigger scroll
      listenWhen: (prev, curr) =>
          prev.selectedCategory != curr.selectedCategory,
      listener: (context, state) {
        final index = _categories.indexOf(state.selectedCategory);
        if (index != -1) _scrollToSelected(index);
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingM.w,
              vertical: AppSizes.paddingM.h,
            ),
            child: SizedBox(
              height: 40.h,
              child: ListView.separated(
                controller: _scrollController, // 4. Attach the controller
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) =>
                    AppSizes.spaceS.horizontalSpace,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return AppFilterChip(
                    isSelected: category == state.selectedCategory,
                    displayName: category.displayName,
                    onSelected: (_) {
                      context.read<HomeBloc>().add(
                        LoadPropertiesByCategoryEvent(category: category),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
