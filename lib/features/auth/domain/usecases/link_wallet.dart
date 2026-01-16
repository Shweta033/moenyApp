import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LinkWallet implements UseCase<User, LinkWalletParams> {
  final AuthRepository repository;

  LinkWallet(this.repository);

  @override
  Future<Either<Failure, User>> call(LinkWalletParams params) async {
    return await repository.linkWallet(
      userId: params.userId,
      provider: params.provider,
      mobileNumber: params.mobileNumber,
    );
  }
}

class LinkWalletParams {
  final String userId;
  final String provider;
  final String mobileNumber;

  LinkWalletParams({
    required this.userId,
    required this.provider,
    required this.mobileNumber,
  });
}
