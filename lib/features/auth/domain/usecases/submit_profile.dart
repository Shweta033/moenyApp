import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SubmitProfile implements UseCase<User, SubmitProfileParams> {
  final AuthRepository repository;

  SubmitProfile(this.repository);

  @override
  Future<Either<Failure, User>> call(SubmitProfileParams params) async {
    return await repository.submitProfile(
      userId: params.userId,
      name: params.name,
      idNumber: params.idNumber,
    );
  }
}

class SubmitProfileParams {
  final String userId;
  final String name;
  final String idNumber;

  SubmitProfileParams({
    required this.userId,
    required this.name,
    required this.idNumber,
  });
}
