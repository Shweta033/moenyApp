import '../../domain/entities/bill_payment.dart';
import '../../../transaction/domain/entities/transaction.dart';

class BillPaymentModel extends BillPayment {
  const BillPaymentModel({
    required super.id,
    required super.userId,
    required super.billType,
    required super.provider,
    required super.accountNumber,
    required super.amount,
    super.currency,
    required super.createdAt,
    required super.status,
  });

  factory BillPaymentModel.fromJson(Map<String, dynamic> json) {
    return BillPaymentModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      billType: BillType.values.firstWhere(
        (e) => e.toString().split('.').last == json['bill_type'],
        orElse: () => BillType.electricity,
      ),
      provider: BillProvider.values.firstWhere(
        (e) => e.toString().split('.').last == json['provider'],
        orElse: () => BillProvider.ecg,
      ),
      accountNumber: json['account_number'] as String,
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
      'bill_type': billType.toString().split('.').last,
      'provider': provider.toString().split('.').last,
      'account_number': accountNumber,
      'amount': amount,
      'currency': currency,
      'created_at': createdAt.toIso8601String(),
      'status': status.toString().split('.').last,
    };
  }
}
