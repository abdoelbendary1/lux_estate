import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/shared_spaces/presentation/widgets/shared_space_image_stack.dart';

class SharedPropertyCard extends StatelessWidget {
  const SharedPropertyCard({
    super.key,
    required this.propertyUnit,
    this.viewUnitDetails,
    this.onSaveToggle,
  });

  final PropertyUnitEntity propertyUnit;
  final VoidCallback? viewUnitDetails;
  final VoidCallback? onSaveToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: viewUnitDetails,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            32.r,
          ), // زاوية انحناء أكبر زي الصورة
        ),
        child: SharedCardImageStack(
          propertyUnit: propertyUnit,
          onSaveToggle: onSaveToggle,
        ),
      ),
    );
  }
}
