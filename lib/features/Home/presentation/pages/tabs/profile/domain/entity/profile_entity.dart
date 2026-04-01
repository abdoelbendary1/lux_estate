import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String? fullName;
  final String? avatarUrl;
  final String userType;
  final String tierStatus; // Gold, Silver, Bronze
  final bool isVerified;
  final bool isInvestor;
  final int savedCount;
  final int toursCount;
  final DateTime? membershipDate;

  const ProfileEntity({
    required this.id,
    this.fullName,
    this.avatarUrl,
    this.userType = "buyer",
    this.tierStatus = 'Bronze',
    this.isVerified = false,
    this.isInvestor = false,
    this.savedCount = 0,
    this.toursCount = 0,
    this.membershipDate,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    avatarUrl,
    tierStatus,
    isVerified,
    isInvestor,
    savedCount,
    toursCount,
    membershipDate,
  ];
}
