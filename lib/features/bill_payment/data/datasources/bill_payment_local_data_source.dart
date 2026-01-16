import '../models/bill_payment_model.dart';

abstract class BillPaymentLocalDataSource {
  Future<void> cacheBillPayments(List<BillPaymentModel> billPayments);
  Future<List<BillPaymentModel>?> getCachedBillPayments();
  Future<void> clearCache();
}

class BillPaymentLocalDataSourceImpl implements BillPaymentLocalDataSource {
  // TODO: Use SharedPreferences
  
  List<BillPaymentModel>? _cachedBillPayments;

  @override
  Future<void> cacheBillPayments(List<BillPaymentModel> billPayments) async {
    _cachedBillPayments = billPayments;
    // TODO: Persist to SharedPreferences
  }

  @override
  Future<List<BillPaymentModel>?> getCachedBillPayments() async {
    return _cachedBillPayments;
    // TODO: Load from SharedPreferences
  }

  @override
  Future<void> clearCache() async {
    _cachedBillPayments = null;
    // TODO: Clear SharedPreferences
  }
}
