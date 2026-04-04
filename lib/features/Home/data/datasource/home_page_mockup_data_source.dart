import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/error/app_exceptions.dart';
import 'package:lux_estate/features/Home/data/model/location_DM.dart' show LocationDM;
import 'package:lux_estate/features/Home/data/model/property_DM.dart';
import 'package:lux_estate/features/Home/data/model/unit_category_DM.dart';

abstract class HomePageMockupDataSource {
  Future<List<PropertyDM>> getPropertiesByCategory({
    required PropertyCategories category,
  });
  Future<List<PropertyDM>> getRecentlyAddedUnits();
  Future<List<PropertyDM>> getPropertiesByLocation({
    required String lat,
    required String lang,
  });
}

@LazySingleton(as: HomePageMockupDataSource)
class HomePageMockupDataSourceImpl implements HomePageMockupDataSource {
  @override
  Future<List<PropertyDM>> getPropertiesByCategory({
    required PropertyCategories category,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final allProperties = getMockedProperties();

      // In a real API, this would be:
      // return supabase.from('properties').select().eq('category_id', category.id);

      if (category == PropertyCategories.all) {
        return allProperties;
      }

      // Filtering by the unique ID defined in your enum
      final filteredProperties = allProperties
          .where((unit) => unit.categoryId == category.id)
          .toList();
      return filteredProperties;
    } catch (e) {
      throw ServerException("Error filtering properties.");
    }
  }

  // ======================
  // Haversine distance
  // ======================
  double _calculateDistance(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    const earthRadius = 6371; // km

    final dLat = _degToRad(lat2 - lat1);
    final dLng = _degToRad(lng2 - lng1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _degToRad(double deg) => deg * (pi / 180);

  // ======================
  // Filter properties by location
  // ======================
  @override
  Future<List<PropertyDM>> getPropertiesByLocation({
    required String lat,
    required String lang,
    double maxDistanceKm = 185, // default radius
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final userLat = double.tryParse(lat);
      final userLng = double.tryParse(lang);

      if (userLat == null || userLng == null) {
        throw ServerException("Invalid user location");
      }

      final allProperties = getMockedProperties();

      final filteredProperties = allProperties.where((property) {
        final propLatStr = property.location?.latitude;
        final propLngStr = property.location?.longitude;

        if (propLatStr == null || propLngStr == null) return false;

        final unitLat = double.tryParse(propLatStr);
        final unitLng = double.tryParse(propLngStr);

        if (unitLat == null || unitLng == null) return false;

        final distance = _calculateDistance(userLat, userLng, unitLat, unitLng);

        // ✅ Consider same-location or within radius
        final isSameLocation =
            (userLat - unitLat).abs() < 0.0001 &&
            (userLng - unitLng).abs() < 0.0001;

        return isSameLocation || distance <= maxDistanceKm;
      }).toList();

      return filteredProperties;
    } catch (e) {
      throw ServerException("Error filtering properties: $e");
    }
  }

  @override
  Future<List<PropertyDM>> getRecentlyAddedUnits() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final allProperties = getMockedProperties();
      // List<PropertyDM> filteredProperties = [];
      // if (count > allProperties.length) {
      //   count = allProperties.length;
      // }
      // for (var i = 0; i < count; i++) {
      //   filteredProperties.add(
      //     allProperties[Random().nextInt(allProperties.length)],
      //   );
      // }
      final filteredProperties = allProperties
          .where((unit) => unit.isNew == true)
          .toList();
      return filteredProperties;
    } catch (e) {
      throw ServerException("Error filtering properties.");
    }
  }

  List<PropertyDM> getMockedProperties() {
    return [
      // ===== CLUSTER 1: New Cairo =====
      _property(
        'v1',
        'Royal Palm Villa',
        6,
        4,
        5200,
        7500000,
        'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=1000',
        PropertyCategories.villa,
        locationName: 'New Cairo',
        lat: '30.0131',
        lang: '31.4913',
        isNew: true,
      ),
      _property(
        'a1',
        'Glass Pavilion',
        3,
        2,
        1800,
        2100000,
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=1000',
        PropertyCategories.apartment,
        locationName: 'New Cairo',
        lat: '30.0135',
        lang: '31.4920',
        isNew: true,
      ),
      _property(
        'o1',
        'Tech Hub',
        0,
        2,
        4500,
        1500000,
        'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=1000',
        PropertyCategories.office,
        locationName: 'New Cairo',
        lat: '30.0140',
        lang: '31.4925',
        isNew: true,
      ),
      _property(
        's1',
        'Retail Space',
        0,
        1,
        1200,
        850000,
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000',
        PropertyCategories.shop,
        locationName: 'New Cairo',
        lat: '30.0145',
        lang: '31.4930',
        isNew: true,
      ),

      // ===== CLUSTER 2: Heliopolis =====
      _property(
        'v2',
        'Ocean Breeze Mansion',
        5,
        5,
        4800,
        6200000,
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=1000',
        PropertyCategories.villa,
        locationName: 'Heliopolis',
        lat: '30.0910',
        lang: '31.3300',
        isNew: true,
      ),
      _property(
        'a2',
        'Skyline Penthouse',
        3,
        3,
        2200,
        3500000,
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=1000',
        PropertyCategories.apartment,
        locationName: 'Heliopolis',
        lat: '30.0915',
        lang: '31.3305',
      ),
      _property(
        'o2',
        'Financial Plaza',
        0,
        4,
        8200,
        3200000,
        'https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000',
        PropertyCategories.office,
        locationName: 'Heliopolis',
        lat: '30.0920',
        lang: '31.3310',
      ),
      _property(
        's2',
        'Boutique Store',
        0,
        1,
        800,
        620000,
        'https://images.unsplash.com/photo-1472851294608-062f824d29cc?q=80&w=1000',
        PropertyCategories.shop,
        locationName: 'Heliopolis',
        lat: '30.0925',
        lang: '31.3315',
      ),

      // ===== CLUSTER 3: Sheraton =====
      _property(
        'v3',
        'Sunset Estate',
        7,
        6,
        8500,
        12000000,
        'https://images.unsplash.com/photo-1613977257363-707ba9348227?q=80&w=1000',
        PropertyCategories.villa,
        locationName: 'Sheraton',
        lat: '30.1030',
        lang: '31.3570',
        isNew: true,
      ),
      _property(
        'a3',
        'Urban Loft',
        2,
        1,
        1100,
        850000,
        'https://images.unsplash.com/photo-1493809842364-78817add7ffb?q=80&w=1000',
        PropertyCategories.apartment,
        locationName: 'Sheraton',
        lat: '30.1035',
        lang: '31.3575',
        isNew: true,
      ),
      _property(
        'o3',
        'Creative Loft',
        0,
        1,
        2100,
        800000,
        'https://images.unsplash.com/photo-1524758631624-e2822e304c36?q=80&w=1000',
        PropertyCategories.office,
        locationName: 'Sheraton',
        lat: '30.1040',
        lang: '31.3580',
      ),
      _property(
        's3',
        'Showroom',
        0,
        2,
        2500,
        1800000,
        'https://images.unsplash.com/photo-1567401893414-76b7b1e5a7a5?q=80&w=1000',
        PropertyCategories.shop,
        locationName: 'Sheraton',
        lat: '30.1045',
        lang: '31.3585',
        isNew: true,
      ),

      // ===== CLUSTER 4: Sheikh Zayed =====
      _property(
        'v4',
        'Desert Oasis',
        4,
        3,
        3200,
        3100000,
        'https://images.unsplash.com/photo-1480074568708-e7b720bb3f09?q=80&w=1000',
        PropertyCategories.villa,
        locationName: 'Sheikh Zayed',
        lat: '30.0130',
        lang: '30.9722',
      ),
      _property(
        'a4',
        'Azure Heights',
        2,
        2,
        1350,
        1250000,
        'https://images.unsplash.com/photo-1502672023488-70e25813eb80?q=80&w=1000',
        PropertyCategories.apartment,
        locationName: 'Sheikh Zayed',
        lat: '30.0135',
        lang: '30.9727',
      ),
      _property(
        'o4',
        'Coworking Space',
        0,
        3,
        6000,
        2200000,
        'https://images.unsplash.com/photo-1556761175-b413da4baf72?q=80&w=1000',
        PropertyCategories.office,
        locationName: 'Sheikh Zayed',
        lat: '30.0140',
        lang: '30.9732',
        isNew: true,
      ),
      _property(
        's4',
        'Market Shop',
        0,
        1,
        1500,
        950000,
        'https://images.unsplash.com/photo-1534452203293-494d7ddbf7e0?q=80&w=1000',
        PropertyCategories.shop,
        locationName: 'Sheikh Zayed',
        lat: '30.0145',
        lang: '30.9737',
      ),

      // ===== CLUSTER 5: 6 October =====
      _property(
        'v5',
        'Pine Retreat',
        4,
        4,
        3800,
        2850000,
        'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?q=80&w=1000',
        PropertyCategories.villa,
        locationName: '6th October',
        lat: '29.9285',
        lang: '30.9188',
      ),
      _property(
        'a5',
        'Horizon Suite',
        4,
        3,
        2800,
        4100000,
        'https://images.unsplash.com/photo-1460317442991-0ec209397118?q=80&w=1000',
        PropertyCategories.apartment,
        locationName: '6th October',
        lat: '29.9290',
        lang: '30.9193',
        isNew: true,
      ),
      _property(
        'o5',
        'Corporate Office',
        0,
        2,
        3500,
        1400000,
        'https://images.unsplash.com/photo-1431540015161-0bf868a2d407?q=80&w=1000',
        PropertyCategories.office,
        locationName: '6th October',
        lat: '29.9295',
        lang: '30.9198',
      ),
      _property(
        's5',
        'Cafe Space',
        0,
        1,
        1100,
        780000,
        'https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=1000',
        PropertyCategories.shop,
        locationName: '6th October',
        lat: '29.9300',
        lang: '30.9203',
        isNew: true,
      ),

      // ===== CLUSTER 6: Nasr City =====
      _property(
        'v6',
        'Marble Villa',
        6,
        5,
        6100,
        9400000,
        'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?q=80&w=1000',
        PropertyCategories.villa,
        locationName: 'Nasr City',
        lat: '30.0560',
        lang: '31.3300',
      ),
      _property(
        'a6',
        'Metro Flats',
        1,
        1,
        850,
        620000,
        'https://images.unsplash.com/photo-1484154218962-a197022b5858?q=80&w=1000',
        PropertyCategories.apartment,
        locationName: 'Nasr City',
        lat: '30.0565',
        lang: '31.3305',
        isNew: true,
      ),
      _property(
        'o6',
        'Law Office',
        0,
        2,
        2800,
        1200000,
        'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?q=80&w=1000',
        PropertyCategories.office,
        locationName: 'Nasr City',
        lat: '30.0570',
        lang: '31.3310',
      ),
      _property(
        's6',
        'Luxury Store',
        0,
        2,
        4200,
        5500000,
        'https://images.unsplash.com/photo-1604713534411-b1d83e2fbcba?q=80&w=1000',
        PropertyCategories.shop,
        locationName: 'Nasr City',
        lat: '30.0575',
        lang: '31.3315',
        isNew: true,
      ),

      // ===== CLUSTER 7: Maadi =====
      _property(
        'v7',
        'Cliffside Villa',
        3,
        3,
        2900,
        4500000,
        'https://images.unsplash.com/photo-1510798831971-661eb04b3739?q=80&w=1000',
        PropertyCategories.villa,
        locationName: 'Maadi',
        lat: '29.9600',
        lang: '31.2600',
      ),
      _property(
        'a7',
        'Cozy Condo',
        2,
        1,
        950,
        710000,
        'https://images.unsplash.com/photo-1499955085172-a104c9463ece?q=80&w=1000',
        PropertyCategories.apartment,
        locationName: 'Maadi',
        lat: '29.9605',
        lang: '31.2605',
      ),
      _property(
        'o7',
        'Business Office',
        0,
        2,
        3000,
        1300000,
        'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=1000',
        PropertyCategories.office,
        locationName: 'Maadi',
        lat: '29.9610',
        lang: '31.2610',
      ),
      _property(
        's7',
        'Local Market',
        0,
        1,
        1000,
        600000,
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000',
        PropertyCategories.shop,
        locationName: 'Maadi',
        lat: '29.9615',
        lang: '31.2615',
      ),
    ];
  } // ===== OTHERS (2) =====

  // Helper method to keep the code clean and manageable
  PropertyDM _property(
    String id,
    String name,
    num beds,
    num baths,
    num size,
    num price,
    String imageUrl,
    PropertyCategories cat, {
    bool isAvailable = true,
    bool isSaved = false,
    bool isFeatured = false,
    bool isNew = false,
    bool isMatched = false,
    String? lat,
    String? lang,
    String? locationName,
  }) {
    return PropertyDM(
      id: id,
      // name: name,
      bedCount: beds,
      bathCount: baths,
      // location: LocationDM(name: locationName, latitude: lat, longitude: lang),
      size: size,
      price: price,
      imageUrl: imageUrl,
      // unitCategory: UnitCategoryDM(
      //   id: cat.index.toString(),
      //   name: cat.name.toUpperCase(),
      // ),
      isAvailable: isAvailable,
      isSaved: isSaved,
      isFeatured: isFeatured,
      isNew: isNew,
      // isMatched: isMatched,
    );
  }
}
