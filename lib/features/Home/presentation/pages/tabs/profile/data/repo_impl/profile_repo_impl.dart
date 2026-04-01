import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/data/data_source/profile_remote_data_source.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/domain/entity/profile_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/domain/repo/profile_repo.dart';

@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  ProfileRemoteDataSource remoteDataSource;
  ProfileRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failures, ProfileEntity>> getProfile(String userId) async {
    try {
      final profileModel = await remoteDataSource.fetchProfile(userId);
      return Right(profileModel);
    } catch (e) {
      // هنا ممكن تضيف لوجيك لتحويل الأخطاء إلى Failures معينة
      return Left(ServerFailure(e.toString()));
    }
  }
}
