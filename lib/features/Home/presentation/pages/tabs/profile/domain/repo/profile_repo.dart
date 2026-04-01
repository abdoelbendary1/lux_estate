import 'package:fpdart/fpdart.dart';
import 'package:lux_estate/core/error/failuers.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepo {
  Future<Either<Failures, ProfileEntity>> getProfile(String userId);
}
