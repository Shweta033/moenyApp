import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

class GetUserWallets implements UseCase<List<Wallet>, GetUserWalletsParams> {
  final WalletRepository repository;

  GetUserWallets(this.repository);

  @override
  Future<Either<Failure, List<Wallet>>> call(GetUserWalletsParams params) async {
    return await repository.getUserWallets(params.userId);
  }
}

class GetUserWalletsParams {
  final String userId;

  GetUserWalletsParams({required this.userId});
}
