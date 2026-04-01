import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/domain/entity/profile_entity.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/domain/repo/profile_repo.dart';

@injectable
class GetProfile {
  ProfileRepo repo;
  GetProfile(this.repo);

  Future<Either<Failures, ProfileEntity>> call(String userId) async {
    return await repo.getProfile(userId);
  }
}
