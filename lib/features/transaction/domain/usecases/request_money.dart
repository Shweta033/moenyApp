import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class RequestMoney implements UseCase<Transaction, RequestMoneyParams> {
  final TransactionRepository repository;

  RequestMoney(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(RequestMoneyParams params) async {
    return await repository.requestMoney(
      userId: params.userId,
      requesterMobileNumber: params.requesterMobileNumber,
      amount: params.amount,
    );
  }
}

class RequestMoneyParams {
  final String userId;
  final String requesterMobileNumber;
  final double amount;

  RequestMoneyParams({
    required this.userId,
    required this.requesterMobileNumber,
    required this.amount,
  });
}
