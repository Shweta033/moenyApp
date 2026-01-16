import '../models/bill_payment_model.dart';
import '../../domain/entities/bill_payment.dart';
import '../../../transaction/domain/entities/transaction.dart';

abstract class BillPaymentRemoteDataSource {
  Future<BillPaymentModel> payBill({
    required String userId,
    required BillType billType,
    required BillProvider provider,
    required String accountNumber,
    required double amount,
    required String pin,
  });
  Future<List<BillPaymentModel>> getBillPaymentHistory(String userId);
}

class BillPaymentRemoteDataSourceImpl implements BillPaymentRemoteDataSource {
  // TODO: Inject Dio or HTTP client here

  @override
  Future<BillPaymentModel> payBill({
    required String userId,
    required BillType billType,
    required BillProvider provider,
    required String accountNumber,
    required double amount,
    required String pin,
  }) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 2));
    
    return BillPaymentModel(
      id: 'bill_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      billType: billType,
      provider: provider,
      accountNumber: accountNumber,
      amount: amount,
      createdAt: DateTime.now(),
      status: TransactionStatus.success,
    );
  }

  @override
  Future<List<BillPaymentModel>> getBillPaymentHistory(String userId) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 1));
    
    return [];
  }
}
