import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/bill_payment.dart';

abstract class BillPaymentRepository {
  Future<Either<Failure, BillPayment>> payBill({
    required String userId,
    required BillType billType,
    required BillProvider provider,
    required String accountNumber,
    required double amount,
    required String pin,
  });
  Future<Either<Failure, List<BillPayment>>> getBillPaymentHistory(String userId);
}
