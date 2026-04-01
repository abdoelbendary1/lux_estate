import 'package:injectable/injectable.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/data/model/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> fetchProfile(String userId);
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient supabase;

  ProfileRemoteDataSourceImpl(this.supabase);
  @override
  Future<ProfileModel> fetchProfile(String userId) async {
    try {
      final response = await supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single(); // مهمة جداً عشان ترجع Object مش List

      return ProfileModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }
}
