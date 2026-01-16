import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionHistory implements UseCase<List<Transaction>, GetTransactionHistoryParams> {
  final TransactionRepository repository;

  GetTransactionHistory(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(GetTransactionHistoryParams params) async {
    return await repository.getTransactionHistory(
      userId: params.userId,
      limit: params.limit,
      offset: params.offset,
    );
  }
}

class GetTransactionHistoryParams {
  final String userId;
  final int? limit;
  final int? offset;

  GetTransactionHistoryParams({
    required this.userId,
    this.limit,
    this.offset,
  });
}
