import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/wallet.dart';

abstract class WalletRepository {
  Future<Either<Failure, Wallet>> getWallet(String userId, String provider);
  Future<Either<Failure, List<Wallet>>> getUserWallets(String userId);
  Future<Either<Failure, Wallet>> refreshWalletBalance(String walletId);
}
