import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

class GetWallet implements UseCase<Wallet, GetWalletParams> {
  final WalletRepository repository;

  GetWallet(this.repository);

  @override
  Future<Either<Failure, Wallet>> call(GetWalletParams params) async {
    return await repository.getWallet(params.userId, params.provider);
  }
}

class GetWalletParams {
  final String userId;
  final String provider;

  GetWalletParams({
    required this.userId,
    required this.provider,
  });
}
