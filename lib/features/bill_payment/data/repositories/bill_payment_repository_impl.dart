import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/bill_payment.dart';
import '../../domain/repositories/bill_payment_repository.dart';
import '../datasources/bill_payment_local_data_source.dart';
import '../datasources/bill_payment_remote_data_source.dart';

class BillPaymentRepositoryImpl implements BillPaymentRepository {
  final BillPaymentRemoteDataSource remoteDataSource;
  final BillPaymentLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BillPaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, BillPayment>> payBill({
    required String userId,
    required BillType billType,
    required BillProvider provider,
    required String accountNumber,
    required double amount,
    required String pin,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final billPaymentModel = await remoteDataSource.payBill(
          userId: userId,
          billType: billType,
          provider: provider,
          accountNumber: accountNumber,
          amount: amount,
          pin: pin,
        );
        // Update cache
        final cached = await localDataSource.getCachedBillPayments();
        if (cached != null) {
          cached.insert(0, billPaymentModel);
          await localDataSource.cacheBillPayments(cached);
        }
        return Right(billPaymentModel);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BillPayment>>> getBillPaymentHistory(String userId) async {
    try {
      if (await networkInfo.isConnected) {
        final billPaymentModels = await remoteDataSource.getBillPaymentHistory(userId);
        await localDataSource.cacheBillPayments(billPaymentModels);
        return Right(billPaymentModels);
      } else {
        final cached = await localDataSource.getCachedBillPayments();
        if (cached != null) {
          return Right(cached.where((b) => b.userId == userId).toList());
        }
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
