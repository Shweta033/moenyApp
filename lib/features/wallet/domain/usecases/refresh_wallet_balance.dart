import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

class RefreshWalletBalance implements UseCase<Wallet, RefreshWalletBalanceParams> {
  final WalletRepository repository;

  RefreshWalletBalance(this.repository);

  @override
  Future<Either<Failure, Wallet>> call(RefreshWalletBalanceParams params) async {
    return await repository.refreshWalletBalance(params.walletId);
  }
}

class RefreshWalletBalanceParams {
  final String walletId;

  RefreshWalletBalanceParams({required this.walletId});
}
