import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class VerifyOTP implements UseCase<User, VerifyOTPParams> {
  final AuthRepository repository;

  VerifyOTP(this.repository);

  @override
  Future<Either<Failure, User>> call(VerifyOTPParams params) async {
    return await repository.verifyOTP(params.mobileNumber, params.otp);
  }
}

class VerifyOTPParams {
  final String mobileNumber;
  final String otp;

  VerifyOTPParams({
    required this.mobileNumber,
    required this.otp,
  });
}
