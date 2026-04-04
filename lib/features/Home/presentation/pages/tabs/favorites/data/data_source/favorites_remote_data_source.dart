import 'package:injectable/injectable.dart';
import 'package:lux_estate/features/Home/data/model/property_DM.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class FavoritesRemoteDataSource {
  Future< List<PropertyDM>> getMyFavorites();
  Future<void> toggleFavorite({required String propertyId, required String userId});
}
@LazySingleton(as: FavoritesRemoteDataSource  )
class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final SupabaseClient supabase;

  FavoritesRemoteDataSourceImpl({required this.supabase});

  @override
  // 2. جلب كل المحفوظات مع تفاصيل العقار
  Future<List<PropertyDM>> getMyFavorites() async {
    final response = await supabase
        .from('user_favorites')
        .select('properties(*, location_text)') // الـ Join السحري
        .eq('user_id', supabase.auth.currentUser!.id);

    return (response as List)
        .map((e) => PropertyDM.fromJson(e['properties']))
        .toList();
  }
  @override
Future<bool> toggleFavorite({required String propertyId, required String userId}) async {
    // final userId = supabase.auth.currentUser!.id;

    // بنجرب نجيب الصف لو موجود
    final existing = await supabase
        .from('user_favorites')
        .select()
        .eq('user_id', userId)
        .eq('property_id', propertyId)
        .maybeSingle();

    if (existing == null) {
      await supabase.from('user_favorites').insert({
        'user_id': userId,
        'property_id': propertyId,
      });
      return true; // تم الحفظ
    } else {
      await supabase
          .from('user_favorites')
          .delete()
          .eq('user_id', userId)
          .eq('property_id', propertyId);
      return false; // تم الحذف
    }
  }
  
}