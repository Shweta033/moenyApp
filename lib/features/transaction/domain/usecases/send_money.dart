import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class SendMoney implements UseCase<Transaction, SendMoneyParams> {
  final TransactionRepository repository;

  SendMoney(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(SendMoneyParams params) async {
    return await repository.sendMoney(
      userId: params.userId,
      recipientMobileNumber: params.recipientMobileNumber,
      amount: params.amount,
      pin: params.pin,
    );
  }
}

class SendMoneyParams {
  final String userId;
  final String recipientMobileNumber;
  final double amount;
  final String pin;

  SendMoneyParams({
    required this.userId,
    required this.recipientMobileNumber,
    required this.amount,
    required this.pin,
  });
}
