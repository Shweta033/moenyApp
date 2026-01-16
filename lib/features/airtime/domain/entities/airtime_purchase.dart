import 'package:equatable/equatable.dart';
import '../../../transaction/domain/entities/transaction.dart';

enum AirtimeProvider {
  mtn,
  vodafone,
  airtelTigo,
}

class AirtimePurchase extends Equatable {
  final String id;
  final String userId;
  final AirtimeProvider provider;
  final String mobileNumber;
  final double amount;
  final String currency;
  final DateTime createdAt;
  final TransactionStatus status;

  const AirtimePurchase({
    required this.id,
    required this.userId,
    required this.provider,
    required this.mobileNumber,
    required this.amount,
    this.currency = 'GHS',
    required this.createdAt,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        provider,
        mobileNumber,
        amount,
        currency,
        createdAt,
        status,
      ];
}
