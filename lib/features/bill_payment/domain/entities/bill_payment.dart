import 'package:equatable/equatable.dart';
import '../../../transaction/domain/entities/transaction.dart';

enum BillType {
  electricity,
  water,
  telecom,
}

enum BillProvider {
  ecg, // Electricity Company of Ghana
  gwc, // Ghana Water Company
  mtn,
  vodafone,
  airtelTigo,
}

class BillPayment extends Equatable {
  final String id;
  final String userId;
  final BillType billType;
  final BillProvider provider;
  final String accountNumber;
  final double amount;
  final String currency;
  final DateTime createdAt;
  final TransactionStatus status;

  const BillPayment({
    required this.id,
    required this.userId,
    required this.billType,
    required this.provider,
    required this.accountNumber,
    required this.amount,
    this.currency = 'GHS',
    required this.createdAt,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        billType,
        provider,
        accountNumber,
        amount,
        currency,
        createdAt,
        status,
      ];
}
