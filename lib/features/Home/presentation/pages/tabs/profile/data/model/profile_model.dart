import 'package:lux_estate/features/Home/presentation/pages/tabs/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    super.fullName,
    super.avatarUrl,
    super.userType = "buyer",
    super.tierStatus = 'Bronze',
    super.isVerified = false,
    super.isInvestor = false, // ضفناها عشان الـ UI
    super.savedCount = 0,
    super.toursCount = 0,
    super.membershipDate,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      userType: json['user_type'] as String,
      tierStatus: json['tier_status'] ?? 'Bronze',
      isVerified: json['is_verified'] ?? false,
      isInvestor: json['is_investor'] ?? false,
      savedCount: json['saved_count'] ?? 0,
      toursCount: json['tours_booked_count'] ?? 0,
      membershipDate: json['membership_date'] != null
          ? DateTime.parse(json['membership_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    'avatar_url': avatarUrl,
    'user_type': userType,
    'tier_status': tierStatus,
    'is_verified': isVerified,
    'is_investor': isInvestor,
    'saved_count': savedCount,
    'tours_booked_count': toursCount,
    'membership_date': membershipDate?.toIso8601String(),
  };

  // تحويل الـ Entity لـ Model (بيحتاج أحياناً في الـ Repositories)
  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      fullName: entity.fullName,
      avatarUrl: entity.avatarUrl,
      userType: entity.userType,
      tierStatus: entity.tierStatus,
      isVerified: entity.isVerified,
      isInvestor: entity.isInvestor,
      savedCount: entity.savedCount,
      toursCount: entity.toursCount,
      membershipDate: entity.membershipDate,
    );
  }
}
