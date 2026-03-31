import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lux_estate/core/cubits/swipe_card_animation/cubit/swipe_cards_animation_cubit.dart';
import 'package:lux_estate/core/router/app_routes.dart';
import 'package:lux_estate/features/Home/domain/entities/property_unit_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/entire_units/presentation/Widgets/property_card.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/explore/features/shared_spaces/presentation/widgets/shared_space_card.dart';

class BuildSuccessSharedRecommendations extends StatelessWidget {
  final List<PropertyUnitEntity> units;
  const BuildSuccessSharedRecommendations({super.key, required this.units});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: units.length,
          options: _carouselOptions(context),
          itemBuilder: (context, index, _) => SharedPropertyCard(
            propertyUnit: units[index],
            viewUnitDetails: () => context.pushNamed(
              AppRoutes.detailsScreenName,
              extra: units[index],
            ),
          ),
        ),
      ],
    );
  }

  CarouselOptions _carouselOptions(BuildContext context) {
    return CarouselOptions(
      aspectRatio: 0.9,
      viewportFraction: 0.9,
      enlargeCenterPage: true,
      enlargeFactor: 0.2,
      enableInfiniteScroll: false,
      autoPlay: true,
      onPageChanged: (index, _) =>
          context.read<SwipeCardsAnimationCubit>().changeIndex(index),
    );
  }
}
