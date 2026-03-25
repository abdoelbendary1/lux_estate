import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lux_estate/core/utils/property_card/property_card_shimmer.dart';

Widget buildPropertyImage(String? url) {
  // 1. لو الـ URL فاضي أو نل، اظهر صورة "Default"
  if (url == null || url.isEmpty) {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.image_not_supported, color: Colors.grey),
      ),
    );
  }

  // 2. لو موجود، استخدم الـ CachedNetworkImage
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => Container(
      color: Colors.grey[300],
      child: AspectRatio(aspectRatio: 16 / 9, child: PropertyCardShimmer()),
    ),
    // مهم جداً تحط الـ errorWidget دي عشان لو اللينك "مكتوب" بس "مبيفتحش"
    errorWidget: (context, url, error) => Container(
      color: Colors.grey[200],
      child: const Icon(Icons.broken_image, color: Colors.grey),
    ),
    height: double.infinity,
    width: double.infinity,
    fit: BoxFit.cover,
  );
}
