import '../models/airtime_purchase_model.dart';

abstract class AirtimeLocalDataSource {
  Future<void> cacheAirtimePurchases(List<AirtimePurchaseModel> purchases);
  Future<List<AirtimePurchaseModel>?> getCachedAirtimePurchases();
  Future<void> clearCache();
}

class AirtimeLocalDataSourceImpl implements AirtimeLocalDataSource {
  // TODO: Use SharedPreferences
  
  List<AirtimePurchaseModel>? _cachedPurchases;

  @override
  Future<void> cacheAirtimePurchases(List<AirtimePurchaseModel> purchases) async {
    _cachedPurchases = purchases;
    // TODO: Persist to SharedPreferences
  }

  @override
  Future<List<AirtimePurchaseModel>?> getCachedAirtimePurchases() async {
    return _cachedPurchases;
    // TODO: Load from SharedPreferences
  }

  @override
  Future<void> clearCache() async {
    _cachedPurchases = null;
    // TODO: Clear SharedPreferences
  }
}
