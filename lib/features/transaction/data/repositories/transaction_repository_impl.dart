import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_data_source.dart';
import '../datasources/transaction_remote_data_source.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;
  final TransactionLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TransactionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Transaction>> sendMoney({
    required String userId,
    required String recipientMobileNumber,
    required double amount,
    required String pin,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final transactionModel = await remoteDataSource.sendMoney(
          userId: userId,
          recipientMobileNumber: recipientMobileNumber,
          amount: amount,
          pin: pin,
        );
        // Update cache
        final cached = await localDataSource.getCachedTransactions();
        if (cached != null) {
          cached.insert(0, transactionModel);
          await localDataSource.cacheTransactions(cached);
        }
        return Right(transactionModel);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Transaction>> requestMoney({
    required String userId,
    required String requesterMobileNumber,
    required double amount,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final transactionModel = await remoteDataSource.requestMoney(
          userId: userId,
          requesterMobileNumber: requesterMobileNumber,
          amount: amount,
        );
        return Right(transactionModel);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactionHistory({
    required String userId,
    int? limit,
    int? offset,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final transactionModels = await remoteDataSource.getTransactionHistory(
          userId: userId,
          limit: limit,
          offset: offset,
        );
        await localDataSource.cacheTransactions(transactionModels);
        return Right(transactionModels);
      } else {
        final cached = await localDataSource.getCachedTransactions();
        if (cached != null) {
          return Right(cached.where((t) => t.userId == userId).toList());
        }
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Transaction>> getTransactionById(String transactionId) async {
    try {
      if (await networkInfo.isConnected) {
        final transactionModel = await remoteDataSource.getTransactionById(transactionId);
        return Right(transactionModel);
      } else {
        final cached = await localDataSource.getCachedTransactions();
        if (cached != null) {
          final transaction = cached.firstWhere(
            (t) => t.id == transactionId,
            orElse: () => throw Exception('Transaction not found'),
          );
          return Right(transaction);
        }
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
