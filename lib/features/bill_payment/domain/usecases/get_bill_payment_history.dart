import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/bill_payment.dart';
import '../repositories/bill_payment_repository.dart';

class GetBillPaymentHistory implements UseCase<List<BillPayment>, GetBillPaymentHistoryParams> {
  final BillPaymentRepository repository;

  GetBillPaymentHistory(this.repository);

  @override
  Future<Either<Failure, List<BillPayment>>> call(GetBillPaymentHistoryParams params) async {
    return await repository.getBillPaymentHistory(params.userId);
  }
}

class GetBillPaymentHistoryParams {
  final String userId;

  GetBillPaymentHistoryParams({required this.userId});
}
