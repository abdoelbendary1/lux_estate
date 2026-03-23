import 'package:flutter/material.dart';

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
  Destinations(
    selectedIcon: Icons.home,
    unSelectedIcon: Icons.home_outlined,
    label: 'Home',
  ),
  Destinations(
    selectedIcon: Icons.explore,
    unSelectedIcon: Icons.explore_outlined,
    label: 'Explore',
  ),
  Destinations(
    selectedIcon: Icons.favorite,
    unSelectedIcon: Icons.favorite_border,
    label: 'Saved',
  ),
  Destinations(
    selectedIcon: Icons.message_rounded,
    unSelectedIcon: Icons.message_outlined,
    label: 'Messages',
  ),
  // Destinations(icon: Icons.profile, label: 'Profile'),
];
