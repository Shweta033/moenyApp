import '../../domain/entities/airtime_purchase.dart';
import '../../../transaction/domain/entities/transaction.dart';

class AirtimePurchaseModel extends AirtimePurchase {
  const AirtimePurchaseModel({
    required super.id,
    required super.userId,
    required super.provider,
    required super.mobileNumber,
    required super.amount,
    super.currency,
    required super.createdAt,
    required super.status,
  });

  factory AirtimePurchaseModel.fromJson(Map<String, dynamic> json) {
    return AirtimePurchaseModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      provider: AirtimeProvider.values.firstWhere(
        (e) => e.toString().split('.').last == json['provider'],
        orElse: () => AirtimeProvider.mtn,
      ),
      mobileNumber: json['mobile_number'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'GHS',
      createdAt: DateTime.parse(json['created_at'] as String),
      status: TransactionStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => TransactionStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'provider': provider.toString().split('.').last,
      'mobile_number': mobileNumber,
      'amount': amount,
      'currency': currency,
      'created_at': createdAt.toIso8601String(),
      'status': status.toString().split('.').last,
    };
  }
}
