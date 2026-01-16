import '../models/wallet_model.dart';

abstract class WalletRemoteDataSource {
  Future<WalletModel> getWallet(String userId, String provider);
  Future<List<WalletModel>> getUserWallets(String userId);
  Future<WalletModel> refreshWalletBalance(String walletId);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  // TODO: Inject Dio or HTTP client here

  @override
  Future<WalletModel> getWallet(String userId, String provider) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 1));
    
    return WalletModel(
      id: 'wallet_${provider}_$userId',
      userId: userId,
      provider: provider,
      balance: 0.0,
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Future<List<WalletModel>> getUserWallets(String userId) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      WalletModel(
        id: 'wallet_mtn_$userId',
        userId: userId,
        provider: 'MTN',
        balance: 0.0,
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  @override
  Future<WalletModel> refreshWalletBalance(String walletId) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock response
    return WalletModel(
      id: walletId,
      userId: 'user_123',
      provider: 'MTN',
      balance: 100.0,
      lastUpdated: DateTime.now(),
    );
  }
}
