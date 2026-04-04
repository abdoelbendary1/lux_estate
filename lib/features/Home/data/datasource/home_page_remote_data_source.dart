// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:lux_estate/features/Home/data/model/property_DM.dart';

abstract class HomePageRemoteDataSource {
  Future< List<PropertyDM>> getPropertiesByCategory({
    required String categoryId,
  });

  Future< List<PropertyDM>> getPropertiesByLocation({
    required String lat,
    required String lang,    required String categoryId,

  });
  Future< List<PropertyDM>> searchProperties({String? query,    required String categoryId,
});
  Future< List<PropertyDM>> getRecentlyAddedUnits({required String categoryId,});
}
@LazySingleton(as: HomePageRemoteDataSource)
class HomePageRemoteDataSourceImpl implements HomePageRemoteDataSource {
  final SupabaseClient supabaseClient;

  HomePageRemoteDataSourceImpl({
    required this.supabaseClient,
  });

  @override
  Future<List<PropertyDM>> getPropertiesByCategory({
    required String categoryId,
  }) async {
    // Select all columns where category_id matches
   final result = await supabaseClient
    .from("properties")
    .select('*, location_text') // بننادي على الفانكشن كأنها عمود عادي
    .eq("category_id", categoryId);

    return result.map((e) => PropertyDM.fromJson(e)).toList();
  }

  @override
  Future<List<PropertyDM>> getPropertiesByLocation({
    required String lat,
    required String lang,
        required String categoryId,

  }) async {
    // We call a custom Postgres function named 'get_nearby_properties'
    // You define this function in your Supabase SQL Editor
    final List<dynamic> result = await supabaseClient.rpc(
      'get_nearby_properties',
      params: {
        'user_lat': double.tryParse(lat),
        'user_lng': double.tryParse(lang),
        'max_dist_km': 5000, // Example: 5km radius
      },
    ).eq("category_id", categoryId);;

    return result.map((e) => PropertyDM.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<PropertyDM>> searchProperties({String? query,    required String categoryId,
}) async {
    var request = supabaseClient.from("properties").select();

    // Use ilike for case-insensitive partial matching (e.g., "villa" matches "Modern Villa")
    if (query != null && query.isNotEmpty) {
request = request.or(
    'en_name.ilike.%$query%,'
    'ar_name.ilike.%$query%,'
    'en_location_name.ilike.%$query%,'
    'ar_location_name.ilike.%$query%'
).eq("category_id", categoryId);    }

    final List<Map<String, dynamic>> result = await request;

    return result.map((e) => PropertyDM.fromJson(e)).toList();
  }
@override
  Future< List<PropertyDM>> getRecentlyAddedUnits({required String categoryId,}) async {
    final List<Map<String, dynamic>> result = await supabaseClient
        .from("properties")
        .select().eq("category_id", categoryId)
        .order('created_at', ascending: false)
        .limit(5);
    return result.map((e) => PropertyDM.fromJson(e)).toList();
  }
}