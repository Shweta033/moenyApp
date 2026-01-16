import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class SendOTP implements UseCase<void, SendOTPParams> {
  final AuthRepository repository;

  SendOTP(this.repository);

  @override
  Future<Either<Failure, void>> call(SendOTPParams params) async {
    return await repository.sendOTP(params.mobileNumber);
  }
}

class SendOTPParams {
  final String mobileNumber;

  SendOTPParams({required this.mobileNumber});
}
