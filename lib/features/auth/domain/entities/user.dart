import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String mobileNumber;
  final String? name;
  final String? idNumber;
  final bool isVerified;
  final DateTime? createdAt;
  final List<LinkedWallet> linkedWallets;

  const User({
    required this.id,
    required this.mobileNumber,
    this.name,
    this.idNumber,
    this.isVerified = false,
    this.createdAt,
    this.linkedWallets = const [],
  });

  @override
  List<Object?> get props => [
        id,
        mobileNumber,
        name,
        idNumber,
        isVerified,
        createdAt,
        linkedWallets,
      ];
}

class LinkedWallet extends Equatable {
  final String provider; // MTN, Vodafone, AirtelTigo
  final String mobileNumber;
  final bool isActive;

  const LinkedWallet({
    required this.provider,
    required this.mobileNumber,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [provider, mobileNumber, isActive];
}
