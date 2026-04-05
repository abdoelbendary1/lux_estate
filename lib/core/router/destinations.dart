import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lux_estate/generated/locale_keys.g.dart';

class Destinations {
  const Destinations({
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.label,
  });
  final IconData selectedIcon;
  final IconData unSelectedIcon;

  final String label;
}

final List<Destinations> appDestinations = [
  // Destinations(
  //   selectedIcon: Icons.home,
  //   unSelectedIcon: Icons.home_outlined,
  //   label: 'Home',
  // ),
  Destinations(
    selectedIcon: Icons.explore,
    unSelectedIcon: Icons.explore_outlined,
    label: LocaleKeys.explore.tr(),
  ),
  Destinations(
    selectedIcon: Icons.favorite,
    unSelectedIcon: Icons.favorite_border,
    label: LocaleKeys.saved.tr(),
  ),
  // Destinations(
  //   selectedIcon: Icons.people_alt,
  //   unSelectedIcon: Icons.people_alt_outlined,
  //   label: 'Shared',
  // ),
  Destinations(
    selectedIcon: Icons.message_rounded,
    unSelectedIcon: Icons.message_outlined,
    label: LocaleKeys.chats.tr(),
  ),
  Destinations(
    selectedIcon: Icons.person,
    unSelectedIcon: Icons.person_outline,
    label: LocaleKeys.profile.tr(),
  ),
  // Destinations(icon: Icons.profile, label: 'Profile'),
];
