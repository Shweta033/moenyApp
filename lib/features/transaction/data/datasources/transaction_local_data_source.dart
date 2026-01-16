import '../models/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future<void> cacheTransactions(List<TransactionModel> transactions);
  Future<List<TransactionModel>?> getCachedTransactions();
  Future<void> clearCache();
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  // TODO: Use SharedPreferences
  
  List<TransactionModel>? _cachedTransactions;

  @override
  Future<void> cacheTransactions(List<TransactionModel> transactions) async {
    _cachedTransactions = transactions;
    // TODO: Persist to SharedPreferences
  }

  @override
  Future<List<TransactionModel>?> getCachedTransactions() async {
    return _cachedTransactions;
    // TODO: Load from SharedPreferences
  }

  @override
  Future<void> clearCache() async {
    _cachedTransactions = null;
    // TODO: Clear SharedPreferences
  }
}
