import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionById implements UseCase<Transaction, GetTransactionByIdParams> {
  final TransactionRepository repository;

  GetTransactionById(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(GetTransactionByIdParams params) async {
    return await repository.getTransactionById(params.transactionId);
  }
}

class GetTransactionByIdParams {
  final String transactionId;

  GetTransactionByIdParams({required this.transactionId});
}
