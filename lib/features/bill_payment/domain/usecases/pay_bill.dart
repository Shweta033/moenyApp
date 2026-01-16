import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/bill_payment.dart';
import '../repositories/bill_payment_repository.dart';

class PayBill implements UseCase<BillPayment, PayBillParams> {
  final BillPaymentRepository repository;

  PayBill(this.repository);

  @override
  Future<Either<Failure, BillPayment>> call(PayBillParams params) async {
    return await repository.payBill(
      userId: params.userId,
      billType: params.billType,
      provider: params.provider,
      accountNumber: params.accountNumber,
      amount: params.amount,
      pin: params.pin,
    );
  }
}

class PayBillParams {
  final String userId;
  final BillType billType;
  final BillProvider provider;
  final String accountNumber;
  final double amount;
  final String pin;

  PayBillParams({
    required this.userId,
    required this.billType,
    required this.provider,
    required this.accountNumber,
    required this.amount,
    required this.pin,
  });
}
