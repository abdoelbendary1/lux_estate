import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lux_estate/core/async/async_view_builder.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/extentions/widget_padding.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/utils/property_card/empty_property_card.dart';
import 'package:lux_estate/core/utils/property_card/property_card_shimmer.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/recommended/recomended_units/recommended_units_bloc.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/shared_spaces/presentation/widgets/build_success_shared_recommendations.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';

class BuildSharedRecommendations extends StatelessWidget {
  const BuildSharedRecommendations({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 0.9,
          child: BlocBuilder<RecommendedUnitsBloc, RecommendedUnitsState>(
            builder: (context, state) =>
                AsyncViewBuilder<List<PropertyUnitEntity>>(
                  state: state.featuredUnitsStatus,
                  loadingWidget: const PropertyCardShimmer().ph(
                    AppSizes.paddingL,
                  ),
                  onSuccess: (units) => BuildSuccessSharedRecommendations(units: units),
                  onEmpty: _buildEmptyState(context),
                  onRetry: () => _refresh(context),
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return EmptyPropertiesWidget(
      onRefresh: () => _refresh(context),
      message: LocaleKeys.no_units_found_category.tr(),
      actionText: LocaleKeys.show_all_units.tr(),
    ).ph(AppSizes.paddingM);
  }

  void _refresh(BuildContext context) {
    context.read<RecommendedUnitsBloc>().add(
      LoadPropertiesByCategoryEvent(category: PropertyCategories.all),
    );
  }
}
