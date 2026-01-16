import '../models/wallet_model.dart';

abstract class WalletLocalDataSource {
  Future<void> cacheWallets(List<WalletModel> wallets);
  Future<List<WalletModel>?> getCachedWallets();
  Future<void> clearCache();
}

class WalletLocalDataSourceImpl implements WalletLocalDataSource {
  // TODO: Use SharedPreferences
  
  List<WalletModel>? _cachedWallets;

  @override
  Future<void> cacheWallets(List<WalletModel> wallets) async {
    _cachedWallets = wallets;
    // TODO: Persist to SharedPreferences
  }

  @override
  Future<List<WalletModel>?> getCachedWallets() async {
    return _cachedWallets;
    // TODO: Load from SharedPreferences
  }

  @override
  Future<void> clearCache() async {
    _cachedWallets = null;
    // TODO: Clear SharedPreferences
  }
}
