import '../models/transaction_model.dart';
import '../../domain/entities/transaction.dart';

abstract class TransactionRemoteDataSource {
  Future<TransactionModel> sendMoney({
    required String userId,
    required String recipientMobileNumber,
    required double amount,
    required String pin,
  });
  Future<TransactionModel> requestMoney({
    required String userId,
    required String requesterMobileNumber,
    required double amount,
  });
  Future<List<TransactionModel>> getTransactionHistory({
    required String userId,
    int? limit,
    int? offset,
  });
  Future<TransactionModel> getTransactionById(String transactionId);
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  // TODO: Inject Dio or HTTP client here

  @override
  Future<TransactionModel> sendMoney({
    required String userId,
    required String recipientMobileNumber,
    required double amount,
    required String pin,
  }) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 2));
    
    return TransactionModel(
      id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      type: TransactionType.send,
      status: TransactionStatus.success,
      amount: amount,
      recipientMobileNumber: recipientMobileNumber,
      createdAt: DateTime.now(),
      completedAt: DateTime.now(),
    );
  }

  @override
  Future<TransactionModel> requestMoney({
    required String userId,
    required String requesterMobileNumber,
    required double amount,
  }) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 1));
    
    return TransactionModel(
      id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      type: TransactionType.request,
      status: TransactionStatus.pending,
      amount: amount,
      recipientMobileNumber: requesterMobileNumber,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<List<TransactionModel>> getTransactionHistory({
    required String userId,
    int? limit,
    int? offset,
  }) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 1));
    
    return [];
  }

  @override
  Future<TransactionModel> getTransactionById(String transactionId) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(seconds: 1));
    
    throw Exception('Transaction not found');
  }
}
