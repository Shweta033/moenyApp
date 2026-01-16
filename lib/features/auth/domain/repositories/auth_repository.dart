import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> sendOTP(String mobileNumber);
  Future<Either<Failure, User>> verifyOTP(String mobileNumber, String otp);
  Future<Either<Failure, User>> submitProfile({
    required String userId,
    required String name,
    required String idNumber,
  });
  Future<Either<Failure, User>> linkWallet({
    required String userId,
    required String provider,
    required String mobileNumber,
  });
  Future<Either<Failure, User?>> getCurrentUser();
  Future<Either<Failure, void>> logout();
}
