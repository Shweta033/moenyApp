import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> sendOTP(String mobileNumber);
  Future<UserModel> verifyOTP(String mobileNumber, String otp);
  Future<UserModel> submitProfile({
    required String userId,
    required String name,
    required String idNumber,
  });
  Future<UserModel> linkWallet({
    required String userId,
    required String provider,
    required String mobileNumber,
  });
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // TODO: Inject Dio or HTTP client here
  
  @override
  Future<void> sendOTP(String mobileNumber) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<UserModel> verifyOTP(String mobileNumber, String otp) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock response for now
    if (otp == "1234") {
      return const UserModel(
        id: 'user_123',
        mobileNumber: '0244123456',
        isVerified: false,
      );
    }
    throw Exception('Invalid OTP');
  }

  @override
  Future<UserModel> submitProfile({
    required String userId,
    required String name,
    required String idNumber,
  }) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 2));
    
    return UserModel(
      id: userId,
      mobileNumber: '0244123456',
      name: name,
      idNumber: idNumber,
      isVerified: true,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<UserModel> linkWallet({
    required String userId,
    required String provider,
    required String mobileNumber,
  }) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 2));
    
    final user = UserModel(
      id: userId,
      mobileNumber: '0244123456',
      linkedWallets: [
        LinkedWalletModel(
          provider: provider,
          mobileNumber: mobileNumber,
        ),
      ],
    );
    
    return user;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    // TODO: Implement API call or local storage check
    return null;
  }
}
