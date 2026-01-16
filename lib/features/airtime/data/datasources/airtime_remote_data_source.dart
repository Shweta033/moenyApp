import '../models/airtime_purchase_model.dart';
import '../../domain/entities/airtime_purchase.dart';
import '../../../transaction/domain/entities/transaction.dart';

abstract class AirtimeRemoteDataSource {
  Future<AirtimePurchaseModel> purchaseAirtime({
    required String userId,
    required AirtimeProvider provider,
    required String mobileNumber,
    required double amount,
    required String pin,
  });
  Future<List<AirtimePurchaseModel>> getAirtimePurchaseHistory(String userId);
}

class AirtimeRemoteDataSourceImpl implements AirtimeRemoteDataSource {
  // TODO: Inject Dio or HTTP client here

  @override
  Future<AirtimePurchaseModel> purchaseAirtime({
    required String userId,
    required AirtimeProvider provider,
    required String mobileNumber,
    required double amount,
    required String pin,
  }) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 2));
    
    return AirtimePurchaseModel(
      id: 'airtime_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      provider: provider,
      mobileNumber: mobileNumber,
      amount: amount,
      createdAt: DateTime.now(),
      status: TransactionStatus.success,
    );
  }

  @override
  Future<List<AirtimePurchaseModel>> getAirtimePurchaseHistory(String userId) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 1));
    
    return [];
  }
}
