import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.mobileNumber,
    super.name,
    super.idNumber,
    super.isVerified,
    super.createdAt,
    super.linkedWallets,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      mobileNumber: json['mobile_number'] as String,
      name: json['name'] as String?,
      idNumber: json['id_number'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      linkedWallets: (json['linked_wallets'] as List<dynamic>?)
              ?.map((e) => LinkedWalletModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mobile_number': mobileNumber,
      'name': name,
      'id_number': idNumber,
      'is_verified': isVerified,
      'created_at': createdAt?.toIso8601String(),
      'linked_wallets': linkedWallets
          .map((w) => (w as LinkedWalletModel).toJson())
          .toList(),
    };
  }
}

class LinkedWalletModel extends LinkedWallet {
  const LinkedWalletModel({
    required super.provider,
    required super.mobileNumber,
    super.isActive,
  });

  factory LinkedWalletModel.fromJson(Map<String, dynamic> json) {
    return LinkedWalletModel(
      provider: json['provider'] as String,
      mobileNumber: json['mobile_number'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'mobile_number': mobileNumber,
      'is_active': isActive,
    };
  }
}
