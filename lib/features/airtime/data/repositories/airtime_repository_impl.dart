import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/airtime_purchase.dart';
import '../../domain/repositories/airtime_repository.dart';
import '../datasources/airtime_local_data_source.dart';
import '../datasources/airtime_remote_data_source.dart';

class AirtimeRepositoryImpl implements AirtimeRepository {
  final AirtimeRemoteDataSource remoteDataSource;
  final AirtimeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AirtimeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AirtimePurchase>> purchaseAirtime({
    required String userId,
    required AirtimeProvider provider,
    required String mobileNumber,
    required double amount,
    required String pin,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final airtimePurchaseModel = await remoteDataSource.purchaseAirtime(
          userId: userId,
          provider: provider,
          mobileNumber: mobileNumber,
          amount: amount,
          pin: pin,
        );
        // Update cache
        final cached = await localDataSource.getCachedAirtimePurchases();
        if (cached != null) {
          cached.insert(0, airtimePurchaseModel);
          await localDataSource.cacheAirtimePurchases(cached);
        }
        return Right(airtimePurchaseModel);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AirtimePurchase>>> getAirtimePurchaseHistory(String userId) async {
    try {
      if (await networkInfo.isConnected) {
        final airtimePurchaseModels = await remoteDataSource.getAirtimePurchaseHistory(userId);
        await localDataSource.cacheAirtimePurchases(airtimePurchaseModels);
        return Right(airtimePurchaseModels);
      } else {
        final cached = await localDataSource.getCachedAirtimePurchases();
        if (cached != null) {
          return Right(cached.where((a) => a.userId == userId).toList());
        }
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
