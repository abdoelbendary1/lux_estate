import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/enums/PropertyCategories.dart';
import 'package:lux_estate/core/error/app_exceptions.dart';
import 'package:lux_estate/features/Home/data/model/property_DM.dart';
import 'package:lux_estate/features/Home/data/model/unit_category_DM.dart';

abstract class HomePageMockupDataSource {
  Future<List<PropertyDM>> getPropertiesByCategory({
    required PropertyCategories category,
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
      final allProperties = _getMockedProperties();

      // In a real API, this would be:
      // return supabase.from('properties').select().eq('category_id', category.id);

      if (category == PropertyCategories.all) {
        return allProperties;
      }

      // Filtering by the unique ID defined in your enum
      final filteredProperties = allProperties
          .where((unit) => unit.unitCategory?.id == category.id)
          .toList();
      return filteredProperties;
    } catch (e) {
      throw ServerException("Error filtering properties.");
    }
  }

  List<PropertyDM> _getMockedProperties() {
    return [
      // ===== VILLAS (8) =====
      _property(
        'v1',
        'Royal Palm Villa',
        6,
        4,
        5200,
        7500000,
        'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=1000',
        PropertyCategories.villa,
        isFeatured: true,
      ),
      _property(
        'v2',
        'Ocean Breeze Mansion',
        5,
        5,
        4800,
        6200000,
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=1000',
        PropertyCategories.villa,
        isMatched: true,
      ),
      _property(
        'v3',
        'Sunset Estate',
        7,
        6,
        8500,
        12000000,
        'https://images.unsplash.com/photo-1613977257363-707ba9348227?q=80&w=1000',
        PropertyCategories.villa,
        isMatched: true,
      ),
      _property(
        'v4',
        'Desert Oasis',
        4,
        3,
        3200,
        3100000,
        'https://images.unsplash.com/photo-1480074568708-e7b720bb3f09?q=80&w=1000',
        PropertyCategories.villa,
        isNew: true,
      ),
      _property(
        'v5',
        'Pine Retreat',
        4,
        4,
        3800,
        2850000,
        'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?q=80&w=1000',
        PropertyCategories.villa,
      ),
      _property(
        'v6',
        'Marble Villa',
        6,
        5,
        6100,
        9400000,
        'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?q=80&w=1000',
        PropertyCategories.villa,
      ),
      _property(
        'v7',
        'Cliffside Villa',
        3,
        3,
        2900,
        4500000,
        'https://images.unsplash.com/photo-1510798831971-661eb04b3739?q=80&w=1000',
        PropertyCategories.villa,
      ),
      _property(
        'v8',
        'Garden Villa',
        5,
        4,
        4200,
        5200000,
        'https://images.unsplash.com/photo-1575517111478-7f6afd0973db?q=80&w=1000',
        PropertyCategories.villa,
      ),

      // ===== APARTMENTS (10) =====
      _property(
        'a1',
        'Glass Pavilion',
        3,
        2,
        1800,
        2100000,
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=1000',
        PropertyCategories.apartment,
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
        isFeatured: true,
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
        isMatched: true,
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
      ),
      _property(
        'a8',
        'Bay Terrace',
        3,
        2,
        1950,
        2800000,
        'https://images.unsplash.com/photo-1515263487990-61b07816b324?q=80&w=1000',
        PropertyCategories.apartment,
      ),
      _property(
        'a9',
        'Brick Apartment',
        2,
        2,
        1400,
        980000,
        'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?q=80&w=1000',
        PropertyCategories.apartment,
      ),
      _property(
        'a10',
        'Prism Tower',
        3,
        3,
        2100,
        3200000,
        'https://images.unsplash.com/photo-1554995207-c18c203602cb?q=80&w=1000',
        PropertyCategories.apartment,
      ),

      // ===== OFFICES (6) =====
      _property(
        'o1',
        'Tech Hub',
        0,
        2,
        4500,
        1500000,
        'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=1000',
        PropertyCategories.office,
        isNew: true,
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
        isMatched: true,
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
      ),

      // ===== SHOPS (6) =====
      _property(
        's1',
        'Retail Space',
        0,
        1,
        1200,
        850000,
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000',
        PropertyCategories.shop,
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
        isNew: true,
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
        isFeatured: true,
      ),

      // يمكنك تكرار نفس النمط لباقي الفئات (Houses, Garages, Studios) باستخدام روابط Unsplash مشابهة.
      _property(
        'oth1',
        'Historic Building',
        2,
        1,
        1500,
        1250000,
        'http://googleusercontent.com/image_collection/image_retrieval/2187787313531072711_9',
        PropertyCategories.all,
      ),
      _property(
        'oth2',
        'Renovated Space',
        4,
        3,
        4000,
        2900000,
        'http://googleusercontent.com/image_collection/image_retrieval/2743700783138880474_5',
        PropertyCategories.all,
      ),
    ];
  }
  // ===== OTHERS (2) =====

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
  }) {
    return PropertyDM(
      id: id,
      name: name,
      bedCount: beds,
      bathCount: baths,
      size: size,
      price: price,
      imageUrl: imageUrl,
      unitType: cat.name,
      unitCategory: UnitCategoryDM(
        id: cat.index.toString(),
        name: cat.name.toUpperCase(),
      ),
      isAvailable: isAvailable,
      isSaved: isSaved,
      isFeatured: isFeatured,
      isNew: isNew,
      isMatched: isMatched,
    );
  }
}
