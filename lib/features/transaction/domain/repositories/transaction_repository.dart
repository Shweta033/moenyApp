import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failure, Transaction>> sendMoney({
    required String userId,
    required String recipientMobileNumber,
    required double amount,
    required String pin,
  });
  Future<Either<Failure, Transaction>> requestMoney({
    required String userId,
    required String requesterMobileNumber,
    required double amount,
  });
  Future<Either<Failure, List<Transaction>>> getTransactionHistory({
    required String userId,
    int? limit,
    int? offset,
  });
  Future<Either<Failure, Transaction>> getTransactionById(String transactionId);
}
