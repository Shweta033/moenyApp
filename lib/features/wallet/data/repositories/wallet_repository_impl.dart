import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_local_data_source.dart';
import '../datasources/wallet_remote_data_source.dart';
import '../models/wallet_model.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;
  final WalletLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WalletRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Wallet>> getWallet(String userId, String provider) async {
    try {
      if (await networkInfo.isConnected) {
        final walletModel = await remoteDataSource.getWallet(userId, provider);
        return Right(walletModel);
      } else {
        // Try local cache
        final cachedWallets = await localDataSource.getCachedWallets();
        if (cachedWallets != null) {
          final wallet = cachedWallets.firstWhere(
            (w) => w.userId == userId && w.provider == provider,
            orElse: () => throw Exception('Wallet not found'),
          );
          return Right(wallet);
        }
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Wallet>>> getUserWallets(String userId) async {
    try {
      if (await networkInfo.isConnected) {
        final walletModels = await remoteDataSource.getUserWallets(userId);
        await localDataSource.cacheWallets(walletModels);
        return Right(walletModels);
      } else {
        final cachedWallets = await localDataSource.getCachedWallets();
        if (cachedWallets != null) {
          return Right(cachedWallets.where((w) => w.userId == userId).toList());
        }
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Wallet>> refreshWalletBalance(String walletId) async {
    try {
      if (await networkInfo.isConnected) {
        final walletModel = await remoteDataSource.refreshWalletBalance(walletId);
        // Update cache
        final cachedWallets = await localDataSource.getCachedWallets();
        if (cachedWallets != null) {
          final index = cachedWallets.indexWhere((w) => w.id == walletId);
          if (index != -1) {
            cachedWallets[index] = walletModel;
            await localDataSource.cacheWallets(cachedWallets);
          }
        }
        return Right(walletModel);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
